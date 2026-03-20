# Historial Q&A
## Entrada — 20260319_202159  (ID: 20260319_202159_escribe_o_pega_aqui_la_pregunta_multi_li)
**Pregunta:**  
> > Escribe o pega aquí la pregunta (multi-línea).

**Respuesta:**  
> > Escribe o pega aquí la respuesta (multi-línea).

**Contexto / Notas:**  

**Tags:** tag1,tag2

---

## Entrada — 20260320_103828  (ID: 20260320_103828_20260320_q1_en_minipc_mpca_tengo_usuario
quiero_entrar_desde_otro_servidor_window
como_debo_configurar_el_minipc_mpca_para
y_que_username_y_password_debo_emplear_h)
**Pregunta:**  
> > [20260320.Q1] En MiniPC "MPCA" tengo usuario Windows11 Pro "migca" asociado a cuenta "aubox@outlook.com"  con PIN Local "<ca_pin>""  y Clave MSFT "<ca_key>"" y 2FA activado
> Quiero entrar desde otro servidor Windows11 Pro que tiene usuario local "migcc"  y asociado a cuenta MSFT "migc@outlook.com"
> Cómo debo configurar el miniPC "MPCA" para entrar con RDP (mstsc)
> Y qué Username y Password debo emplear. (He probado varios y todos fallan)

**Respuesta:**  
> > Voy a indicar los pasos mínimos para configurar el MiniPC `MPCA` y las combinaciones de usuario/contraseña que debes probar. Si falla, dime el mensaje de error exacto y avanzo con diagnóstico.
> 
> **Pasos (configurar en MPCA)**
> - **Habilitar RDP:** Ajustes > Sistema > Escritorio remoto > activar `Habilitar Escritorio remoto`. Anota el nombre del equipo.
> - **Usuarios remotos:** Click en `Usuarios de Escritorio remoto` y añade el usuario que vayas a usar (ver formatos abajo). El usuario debe estar en ese grupo o ser administrador.
> - **Firewall:** Permitir `Escritorio remoto (TCP 3389)` en el Firewall de Windows.
> - **NLA:** Mantén `Requerir Autenticación a nivel de red` activado; solo desactívalo temporalmente para pruebas si hay problemas.
> - **Si hay MFA/2FA y da problemas:** crea un usuario local con contraseña: Ajustes > Cuentas > Familia y otros usuarios > Añadir un usuario sin cuenta Microsoft. Añádelo a `Remote Desktop Users`.
> - **Red/Internet:** Si conectas desde fuera de la LAN, necesitas VPN o reenviar el puerto 3389 en el router (no recomendado sin VPN).
> 
> **Qué credenciales usar en el cliente (`mstsc`)**
> - No puedes usar PIN remoto. Usa siempre la contraseña de la cuenta (no el PIN).
> - Para la cuenta Microsoft del MPCA:
>   - `aubox@outlook.com` con la contraseña de la cuenta Microsoft.
>   - Si eso falla, prueba con el prefijo: `MicrosoftAccount\aubox@outlook.com` + contraseña.
> - Para un usuario local del MPCA (si lo creas o existe):
>   - `MPCA\migca` o `.\migca` con la contraseña local.
>   - Si creas `remoteuser`, usa `MPCA\remoteuser` o `.\remoteuser`.
> - Asegúrate en `mstsc` > Mostrar opciones > Usuario de inicio de sesión: poner uno de los anteriores; si hay credenciales guardadas, bórralas en el `Administrador de credenciales`.
> 
> **Comprobaciones rápidas desde el cliente**
> - `ping <IP_o_nombre_MPCA>`
> - En PowerShell: `Test-NetConnection -ComputerName <IP_o_nombre_MPCA> -Port 3389`
> Test-NetConnection -ComputerName aubox1-vm-win1  -Port 3389
> - Si falla, pega aquí el resultado o el texto exacto del error de `mstsc`.
> 
> Si quieres, te guío paso a paso (indícame si estás en la misma red o remoto y si quieres que te indique cómo crear un usuario local seguro).

**Contexto / Notas:**  

**Tags:** windows11,rdp,aaa

---
