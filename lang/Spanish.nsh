!insertmacro MUI_LANGUAGE "Spanish" ; 3: Change this to !insertmacro MUI_LANGUAGE "YourLanguage"

; 4: Replace ${LANG_ENGLISH} with ${LANG_YOUR_LANGUAGE} in this file


; 5: Convert English strings below to your language
; Interface
LangString welcomeTitle ${LANG_SPANISH} "${PRODUCT_NAME} ${PRODUCT_VERSION} Configuración"
LangString welcomeText ${LANG_SPANISH} "Este asistente instalará ${PRODUCT_NAME} ${PRODUCT_VERSION}.$\r$\n$\r$\nHaga click en Instalar para iniciar la instalación."

LangString finishTitle ${LANG_SPANISH} "Instalación completa!"
LangString rebootQuestion ${LANG_SPANISH} "Le gustaría reiniciar ahora para ejecutar ${PRODUCT_NAME} ${PRODUCT_VERSION}?"
LangString rebootNow ${LANG_SPANISH} "Reinicar ahora"
LangString rebootLater ${LANG_SPANISH} "Reiniciar mas tarde"

; Messages
LangString un_confirm ${LANG_SPANISH} "Esta seguro que quiere desinstalar completamente $(^Name) y todos sus componentes?"
LangString un_success ${LANG_SPANISH} "$(^Name) fue exitosamente desinstalado de su computador."

LangString un_delSaveFile ${LANG_SPANISH} "Desea borrar su archivo de sesión?"
LangString un_deleteGrub ${LANG_SPANISH} "Desea eliminar GRUB? Si usted tiene otra instalación Linux usándolo, haga click en no. De otra forma, haga click en si. (Si tiene dudas, sólo haga clic en SI)"

; Errors
LangString unknownWinVer ${LANG_SPANISH} "Versión de windows desconocida. Por favor reporte esto en el foro."
LangString notCompatibleWinVer ${LANG_SPANISH} "Su versión de windows no es compatible con este programa."
LangString mustBeAdmin ${LANG_SPANISH} "Debe ser un administrador para usar este programa."

LangString errorFileNotFound_1 ${LANG_SPANISH} "Error:" ; part 1
LangString errorFileNotFound_2 ${LANG_SPANISH} "no se encuentra." ; part 2

LangString aborting ${LANG_SPANISH} "El programa de instalación se va a detener ahora."

LangString cantFindMenuLst ${LANG_SPANISH} "GRUB esta instalado en su computadora, pero el instalador no encuentra menu.lst. Por favor agregue lo siguiente manualmente:"

LangString errorWriteRegistry ${LANG_SPANISH} "Error: No se pudo escribir en el registro."

LangString un_errorNoBootId ${LANG_SPANISH} "Error: No se pudo encontrar el BootID en el registro."

; Readme File
LangString readme_ln_1 ${LANG_SPANISH} "Para ejecutar Puppy Linux, sólo reinicie. Cuando su computador arranque de nuevo, verá una pantalla preguntando si quiere iniciar con windows, o Puppy Linux.$\r$\n"
LangString readme_ln_2 ${LANG_SPANISH} "Presione abajo luego enter para seleccionar Puppy Linux.$\r$\n"
LangString readme_ln_3 ${LANG_SPANISH} "$\r$\n"
LangString readme_ln_4 ${LANG_SPANISH} "Para desinstalar Puppy Linux, vaya a Inicio > Todos los programas > ${PRODUCT_NAME} ${PRODUCT_VERSION} > Desinstalar.$\r$\n"
