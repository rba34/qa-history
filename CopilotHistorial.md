# Historial Q&A


## Entrada — 20260320_113135  (ID: 20260320_113135_20260320_q1_ en minipc _mpca_ tengo usua)
**RepoCommit:** 66871c5
**ScriptCommit:** 66871c5
**Pregunta:**  
> [20260320.Q1] En MiniPC "MPCA" tengo usuario Windows11 Pro "migca" asociado a cuenta "aubox@outlook.com"  con PIN Local "<ca_pin>"  y Clave MSFT "<ca_key>" y 2FA activado
> Quiero entrar desde otro servidor Windows11 Pro que tiene usuario local "migcc"  y asociado a cuenta MSFT "migc@outlook.com" 
> Cómo debo configurar el miniPC "MPCA" para entrar con RDP (mstsc)
> Y qué Username y Password debo emplear. (He probado varios y todos fallan)

**Respuesta:**  
> Voy a indicar los pasos mínimos para configurar el MiniPC `MPCA` y las combinaciones de usuario/contraseña que debes probar. Si falla, dime el mensaje de error exacto y avanzo con diagnóstico.
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

**Contexto / Notas:**  

**Tags:** windows11,rdp,aaa

---
## Entrada — 20260320_121825  (ID: 20260320_121825_tengo mini pc chuwi aubox que viene con )
**RepoCommit:** e02f47a
**ScriptCommit:** 66871c5
**Pregunta:**  
> 
> Tengo mini PC Chuwi Aubox que viene con Licencia Windows 11 Pro Activada (Tipo iRETAIL y Digital Account). No me pidió cuenta de Email pero posteriormente la cree
> Quiero transferir la Licencia a una instancia VM en ese mismo mini PC (teniendo Proxmox como Host Operating System).
> Utilizo esa cuenta de Outlook para con Windows System Settings --> Activation --> Troubleshoot --> I recently changed hardware on this device
> Desde Web Microsoft me muestra los dos dispositivos (Mini-PC Chuwi Aubox  y la instancia VM con Windowss 11 en ese miniPC). El primero tiene Licencia activada , el segundo no
> Si intento transferir desde el Mini-PC me dice que No se puede puesto que aunque ahora tiene Windows11 era originalmente Windows10 y NO se soporta esta feature (supongo que transferencias)
> 
> 
> [Duda1] Microsoft Windows 11 PRO en su EULA permite traspasar Licencia Activada desde el Mini-PC Chuwi-Aubox a una instancia VM en el mismo mini-PC (La licencia aparece tipo RETAIL  y Digital Account)
> 
> [Duda2] Me puedes indicar un método (CMD, Powershell, Registry, UI ) para conseguir transferir licencia desde Mini-PC (Host OS) a la instancia VM Windows en mismo mini PC (Usando Proxmox como Host OS)?
> 
> 
> Te pongo a continuación los datos que aparecen con Windows System y slmgr /dlv:w
> 
> 
> ########################
> ####[INFO1] Mini-PC Chuwi AuBox . Licencia Windows 11 Pro Activada (Digital Account)
> ########################
> [12:44, 18/3/2026] Mig Manza: Windows Script Host
> 
> Software licensing service version: 10.0.26100.8036
> 
> Name: Windows(R), Professional edition
> Description: Windows(R) Operating System, RETAIL channel
> Activation ID: 4de7cb65-cdf1-4de9-8ae8-e3cce27b9f2c
> Application ID: 55c92734-d682-4d71-983e-d6ec3f16059f
> Extended PID: 03612-03308-000-000000-00-1033-26100.0000-3102025
> Product Key Channel: Retail
> Installation ID: 614135664427524181672335770744316131663200377370422449461642
> Use License URL: https://activation-v2.sls.microsoft.com/SLActivateProduct/SLActivateProduct.asmx?configextension=Retail
> Validation URL: https://validation-v2.sls.microsoft.com/SLWGA/slwga.asmx
> Partial Product Key: 3V66T
> License Status: Licensed
> Remaining Windows rearm count: 1000
> Remaining SKU rearm count: 1000
> Trusted time: 3/18/2026 12:34:20 PM
> 
> [12:44, 18/3/2026] Mig Manza: Device name       DESKTOP-8JJH4RO
> Processor       AMD Ryzen 7 8745HS w/ Radeon 780M Graphics      (3.80 GHz)
> Installed RAM   16.0 GB (15.3 GB usable)
> Device ID       A12C126F-D9B8-4E3C-8EFA-B142F08A1FAD
> Product ID      00330-80000-00000-AA121
> System type     64-bit operating system, x64-based processor
> Pen and touch   No pen or touch input is available for this display
> 
> 
> 
> ########################
> ####[INFO2] Instancia VM Windows 11 en ProxMox de Mini-PC Chuwi Aubox
> ########################
> Software licensing service version: 10.0.26100.8036
> 
> Name: Windows(R), Professional edition
> Description: Windows(R) Operating System, RETAIL channel
> Activation ID: 4de7cb65-cdf1-4de9-8ae8-e3cce27b9f2c
> Application ID: 55c92734-d682-4d71-983e-d6ec3f16059f
> Extended PID: 03612-03308-000-000000-00-2057-26200.0000-0782026
> Product Key Channel: Retail
> Installation ID: 130096098742538877424757780434931350325192537413574684069762241
> Use License URL: https://activation-v2.sls.microsoft.com/SLActivateProduct/SLActivateProduct.asmx?configextension=Retail
> Validation URL: https://validation-v2.sls.microsoft.com/SLWGA/slwga.asmx
> Partial Product Key: 3V66T
> License Status: Notification
> Notification Reason: 0xC004F034.
> Remaining Windows rearm count: 1000
> Remaining SKU rearm count: 1000
> Trusted time: 20/03/2026 12:44:15
> 
> Device name     aubox1-vm-win1
> Processor       AMD Ryzen 7 8745HS w/ Radeon 780M Graphics      (3.79 GHz)
> Installed RAM   8.00 GB
> Device ID       C47F5BA2-FFCD-49D3-A695-9733E8FB26F9
> Product ID      00330-80000-00000-AA584
> System type     64-bit operating system, x64-based processor
> Pen and touch   No pen or touch input is available for this display

**Respuesta:**  
> 
> Resumen rápido — respuesta corta a tus dudas y pasos prácticos.
> 
> - Duda1 (¿permitido por EULA?): Sí, una licencia Retail vinculada a una cuenta Microsoft (Digital License / Digital Account) suele poder transferirse entre dispositivos, y eso incluye transferirla a una VM si la licencia es Retail (no OEM). El bloqueo que ves en el Troubleshooter suele ser una limitación de la herramienta/flujo automático (o un caso especial por historial de actualización), no necesariamente que la EULA lo prohíba. Si la licencia fuera OEM/embebida no sería transferible; tu salida de `slmgr /dlv` muestra canal Retail, por tanto en principio transferible.
> 
> - Duda2 (métodos prácticos): te doy 2 vías — la recomendada (Microsoft Account / Troubleshooter) y la “manual” (liberar e instalar clave con slmgr). Haz copia de seguridad y planifica una ventana de activación.
> 
> 1) Método recomendado: Transferencia vía cuenta Microsoft (sin tocar clave)
> - Requisitos: ambas instalaciones (host y VM) deben usar la misma cuenta Microsoft en Settings → Accounts → Your info.
> - En la VM (ejecutar como Administrador):
>   - Settings → System → Activation → Troubleshoot → “I changed hardware on this device”.
>   - Inicia sesión con la misma cuenta Microsoft si te lo pide.
>   - Elige el dispositivo que aparece en la lista (tu Mini‑PC físico) y marca “This is the device I’m using right now” en la opción que corresponda para transferir la licencia.
>   - Pulsa Activate.
> - Si el Troubleshooter falla mostrando “no se puede porque originalmente era Windows 10” o mensaje similar, pasa al método manual o contacta Soporte Microsoft (véase abajo).
> 
> 2) Método manual (si no puedes transferir por cuenta MS)
> - Paso A: Liberar la licencia en el host (opcional pero recomendable)
>   - En el Host (Windows físico) abrir CMD como Administrador:
>     - slmgr.vbs /upk                # desinstala la clave del producto del host
>     - slmgr.vbs /cpky               # elimina la clave del registro (opcional, seguridad)
>   - Comprueba estado: slmgr.vbs /dlv y slmgr.vbs /xpr
> - Paso B: Activar en la VM
>   - Si tienes la clave retail completa: en la VM (Admin CMD):
>     - slmgr.vbs /ipk XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
>     - slmgr.vbs /ato
>   - Si no tienes clave (solo cuenta MS / digital): intenta Troubleshooter en la VM (ver método 1). Si sigue fallando, contacta Soporte y realiza activación por teléfono:
>     - Ejecuta: slui 4   (esto lanza la activación por teléfono)
> - Nota: si la VM ya aparece en tu cuenta Microsoft (lista dispositivos) y la entrada “VM” está como “Notification”, puede que al eliminar la licencia del host y forzar Troubleshooter en la VM funcione mejor.
> 
> 3) Diagnóstico y comandos útiles (ejecutar en Admin CMD / PowerShell)
> - Ver estado de activación:
>   - slmgr.vbs /dlv
>   - slmgr.vbs /xpr
> - Verificar canal/key parcial (ya lo has hecho): el Partial Product Key se muestra en /dlv.
> - Para recuperar una clave (si se compró y está en registro o firmware): usar ShowKeyPlus o ProduKey (herramientas de terceros).
> 
> 4) Si Troubleshooter indica “no soportado” por haber sido originalmente Windows 10
> - Posibles causas:
>   - La licencia fue originalmente una actualización OEM → algunas transferencias automáticas no están automatizadas.
>   - La cuenta Microsoft no “vinculó” correctamente la licencia (o la entrada del dispositivo en account.microsoft.com/devices está en estado extraño).
> - Qué hacer:
>   - Intenta liberar la clave del host (slmgr /upk) y volver a correr Troubleshooter en la VM.
>   - Si sigue fallando, contacta Soporte Microsoft (chat/llamada) y explícales que tienes una licencia Retail vinculada a tu cuenta MS y quieres transferirla a la VM en el mismo hardware (proporciona Device IDs y la hora). Ellos pueden forzar la transferencia/activación.
> 
> 5) Precauciones
> - Haz /upk solo si estás seguro y en una ventana donde puedas reprovisionar la VM; si lo haces y no puedes activar, tendrás que contactar Soporte.
> - No publiques claves en texto plano.
> - Guarda el output de `slmgr /dlv` de ambos sistemas antes de cambios.
> 
> 6) Pasos recomendados, orden mínimo seguro
> - En ambos sistemas: confirma que estás con la misma cuenta Microsoft en Settings → Accounts.
> - En la VM prueba Troubleshooter (método 1). Si funciona, listo.
> - Si no: en Host, ejecuta (Admin CMD) `slmgr /upk` → en VM intenta Troubleshooter de nuevo → si continúa, en VM instala clave con `/ipk` si la tienes o usa `slui 4` y contacta Soporte.
> - Si quieres que haga un script de comprobación que recopile `slmgr /dlv` y lo formatee para adjuntar a Soporte, lo preparo.
> 
> ¿Quieres que:
> A) Te prepare un mini-guion paso a paso (comandos exactos) para ejecutar ahora en Host y en VM, con seguridad (ejecución no destructiva)?  
> B) Pruebe un flujo “no destructivo” primero: en la VM ejecuto Troubleshooter y te indico exactamente lo que devuelve (necesito acceso remoto o que pegues el output).  
> C) Prepare un paquete (logs `slmgr /dlv`, `slmgr /xpr`) listo para enviar a Soporte Microsoft?
> 
> Dime cuál prefieres y preparo/ejecuto lo necesario.

**Contexto / Notas:**  

**Tags:** windows11,aaa,license

---