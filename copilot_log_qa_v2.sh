#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="${QA_DIR:-$HOME/Copilot-qa-history}"
MD_FILE="$BASE_DIR/CopilotHistorial.md"
JSON_DIR="$BASE_DIR/entries"
BACKUP_DIR="$BASE_DIR/backups"

usage(){
  cat <<EOF
Uso:
  copilot_log_qa.sh [-q "Pregunta"] [-a "Respuesta"] [-t "tag1,tag2"]
  copilot_log_qa.sh -Q pregunta.txt -A respuesta.txt
  copilot_log_qa.sh -e    # abrir editor para pregunta+respuesta
Opciones:
  -j    -> crear entries/<ID>.json
  -d DIR -> cambiar base dir
EOF
  exit 1
}

EDITOR="${VISUAL:-${EDITOR:-vi}}"
MAKE_JSON=false
USE_EDITOR=false

while getopts ":q:a:t:Q:A:ejd:" opt; do
  case $opt in
    q) Q="$OPTARG" ;;
    a) A="$OPTARG" ;;
    t) TAGS="$OPTARG" ;;
    Q) Q="$(cat "$OPTARG")" ;;
    A) A="$(cat "$OPTARG")" ;;
    e) USE_EDITOR=true ;;
    j) MAKE_JSON=true ;;
    d) BASE_DIR="$OPTARG"; MD_FILE="$BASE_DIR/CopilotHistorial.md"; JSON_DIR="$BASE_DIR/entries" ;;
    *) usage ;;
  esac
done

mkdir -p "$BASE_DIR" "$JSON_DIR"
mkdir -p "$BACKUP_DIR"

if [ "${USE_EDITOR:-false}" = true ]; then
  TMP="$(mktemp /tmp/qa.XXXXXX.md)"
  cat > "$TMP" <<'TEMPLATE'
# Edita entre las marcas. Borra comentarios cuando termines.
<<<QUESTION>>>
Escribe o pega aquí la pregunta (multi-línea).
<<<ENDQUESTION>>>
<<<ANSWER>>>
Escribe o pega aquí la respuesta (multi-línea).
<<<ENDANSWER>>>
Tags: tag1,tag2
TEMPLATE
  if [[ "${EDITOR}" == *" "* ]]; then
    eval "$EDITOR \"${TMP//\"/\\\"}\""
  else
    "$EDITOR" "$TMP"
  fi
  CONTENT="$(cat "$TMP")"
  rm -f "$TMP"
  Q="$(printf "%s\n" "$CONTENT" | awk '/^<<<QUESTION>>>/{p=1;next}/^<<<ENDQUESTION>>/{p=0}p')"
  A="$(printf "%s\n" "$CONTENT" | awk '/^<<<ANSWER>>>/{p=1;next}/^<<<ENDANSWER>>/{p=0}p')"
  TAGS="$(printf "%s\n" "$CONTENT" | awk -F'Tags:' '/Tags:/{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//')"
fi

if [ -z "${Q:-}" ] || [ -z "${A:-}" ]; then
  echo "Faltan pregunta o respuesta. Usa -q/-a, -Q/-A o -e."
  exit 1
fi

TIMESTAMP="$(date -u +"%Y%m%d_%H%M%S")"

# SLUG: collapse newlines -> spaces, squeeze spaces, lowercase, transliterate, replace non-alnum with _
SLUG="$(printf "%s" "$Q" | tr '\r\n' ' ' | tr -s ' ' | sed 's/^ //;s/ $//' | tr '[:upper:]' '[:lower:]' \
  | iconv -f utf8 -t ascii//TRANSLIT 2>/dev/null | sed 's/[^a-z0-9 ]/_/g' | tr -s '_' | sed 's/^_//;s/_$//' | cut -c1-40)"
ID="${TIMESTAMP}_${SLUG:-entry}"

# make a repository-backed backup of the master MD file before modifying it
if [ -f "$MD_FILE" ]; then
  cp "$MD_FILE" "$BACKUP_DIR/CopilotHistorial.md.$TIMESTAMP"
fi

# Remove any leading '>' from lines of Q before adding blockquote
Q_CLEAN="$(printf "%s\n" "$Q" | sed 's/^[[:space:]]*>[[:space:]]*//')"
A_CLEAN="$A"
TAGS="$(printf "%s" "${TAGS:-}" | sed 's/^[ \t]*//;s/[ \t]*$//')"

ENTRY="$(cat <<EOF

## Entrada — $TIMESTAMP  (ID: $ID)
**Pregunta:**  
$(printf "%s\n" "$Q_CLEAN" | sed 's/^/> /g')

**Respuesta:**  
$(printf "%s\n" "$A_CLEAN" | sed 's/^/> /g')

**Contexto / Notas:**  

**Tags:** ${TAGS:-}

---
EOF
 )"

printf '%s' "$ENTRY" >> "$MD_FILE"

if [ "$MAKE_JSON" = true ]; then
  if command -v jq >/dev/null 2>&1; then
    jq -n --arg id "$ID" --arg t "$TIMESTAMP" --arg q "$Q" --arg a "$A" --arg tags "${TAGS:-}" \
      '{id:$id,timestamp:$t,question:$q,answer:$a,tags:$tags}' > "$JSON_DIR/$ID.json"
  else
    python3 - <<PY > "$JSON_DIR/$ID.json"
import json,sys
obj = {"id":"$ID","timestamp":"$TIMESTAMP","question":"""$Q""","answer":"""$A""","tags":"${TAGS:-}"}
print(json.dumps(obj, ensure_ascii=False))
PY
  fi
fi

if git -C "$BASE_DIR" rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  git -C "$BASE_DIR" add "$MD_FILE" >/dev/null 2>&1 || true
  git -C "$BASE_DIR" add "$JSON_DIR/$ID.json" >/dev/null 2>&1 || true
  # add the timestamped backup into the repo as well (if it exists)
  if [ -f "$BACKUP_DIR/CopilotHistorial.md.$TIMESTAMP" ]; then
    git -C "$BASE_DIR" add "$BACKUP_DIR/CopilotHistorial.md.$TIMESTAMP" >/dev/null 2>&1 || true
  fi
  git -C "$BASE_DIR" commit -m "Q&A: $ID" || true
  git -C "$BASE_DIR" push || true
fi

echo "Entrada añadida: $MD_FILE (ID: $ID)"

