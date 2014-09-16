Function GrubAlreadyInstalled
IfFileExists C:\menu.lst root
    IfFileExists C:\boot\grub\menu.lst bootgrub
    goto CantFind
root:
    #extend time out for you to choose
      Push "timeout=0"                #-- line to be found
      Push "timeout=5"                #-- line to be added
      Push "C:\menu.lst"     #-- file to be searched in
        Call INIChgLine #extend time out
      FileOpen $0 "C:\menu.lst" a
    goto ContWrite
bootgrub:
    #extend time out for you to choose
      Push "timeout=0"                #-- line to be found
      Push "timeout=5"                #-- line to be added
      Push "C:\boot\grub\menu.lst"     #-- file to be searched in
        Call INIChgLine #extend time out
      FileOpen $0 "C:\boot\grub\menu.lst" a
      goto ContWrite
CantFind:
    messagebox MB_OK '$(cantFindMenuLst)$\r$\ntitle ${PRODUCT_NAME} ${PRODUCT_VERSION}$\r$\nfind --set-root --ignore-floppies /${INSTALL_DIR}/initrd.gz$\r$\nkernel /${INSTALL_DIR}/vmlinuz psubdir="${INSTALL_DIR}"$\r$\ninitrd /${INSTALL_DIR}/initrd.gz$\r$\nboot'
      quit
ContWrite:
    FileSeek $0 0 END
    FileWrite $0 "$\r$\n"
    FileWrite $0 "$\r$\n" ; write 2 new lines
    
    FileWrite $0 'title ${PRODUCT_NAME} ${PRODUCT_VERSION}$\r$\n'
    FileWrite $0 'find --set-root --ignore-floppies /${INSTALL_DIR}/initrd.gz$\r$\n'
    FileWrite $0 'kernel /${INSTALL_DIR}/vmlinuz psubdir="${INSTALL_DIR}" pfix=fsck$\r$\n'
    FileWrite $0 'initrd /${INSTALL_DIR}/initrd.gz$\r$\n'
    FileWrite $0 'boot$\r$\n'
    
    ;pfix=ram
    FileWrite $0 "$\r$\n" ; write 2 new lines
    FileWrite $0 'title ${PRODUCT_NAME} ${PRODUCT_VERSION} - Do not load save file$\r$\n'
    FileWrite $0 'find --set-root --ignore-floppies /${INSTALL_DIR}/initrd.gz$\r$\n'
    FileWrite $0 'kernel /${INSTALL_DIR}/vmlinuz psubdir="${INSTALL_DIR}" pfix=ram$\r$\n'
    FileWrite $0 'initrd /${INSTALL_DIR}/initrd.gz$\r$\n'
    FileWrite $0 'boot$\r$\n'
    
    FileClose $0 ; and close the file
FunctionEnd

Function CreateMenuLst
  SetOutPath "C:\"
  File "${SUPPORT}Grub_GUI.gz"
  
  FileOpen $0 "C:\menu.lst" w ;Opens a Empty File and fills it
  FileWrite $0 'timeout=5$\r$\n'
  FileWrite $0 'default=0$\r$\n'
  FileWrite $0 'gfxmenu=/Grub_GUI.gz$\r$\n'
  FileWrite $0 '$\r$\n'

  FileWrite $0 'title ${PRODUCT_NAME} ${PRODUCT_VERSION}$\r$\n'
  FileWrite $0 'find --set-root --ignore-floppies /${INSTALL_DIR}/initrd.gz$\r$\n'
  FileWrite $0 'kernel /${INSTALL_DIR}/vmlinuz psubdir="${INSTALL_DIR}" pfix=fsck$\r$\n'
  FileWrite $0 'initrd /${INSTALL_DIR}/initrd.gz$\r$\n'
  FileWrite $0 'boot$\r$\n'

  ;pfix=ram
  FileWrite $0 "$\r$\n" ; write 2 new lines
  FileWrite $0 'title ${PRODUCT_NAME} ${PRODUCT_VERSION} - Do not load save file$\r$\n'
  FileWrite $0 'find --set-root --ignore-floppies /${INSTALL_DIR}/initrd.gz$\r$\n'
  FileWrite $0 'kernel /${INSTALL_DIR}/vmlinuz psubdir="${INSTALL_DIR}" pfix=ram$\r$\n'
  FileWrite $0 'initrd /${INSTALL_DIR}/initrd.gz$\r$\n'
  FileWrite $0 'boot$\r$\n'

  FileClose $0 ; and close the file
FunctionEnd




Function Win9x
SetOutPath "C:\boot\grub"
  file "${SUPPORT}grub.exe"
  IfFileExists "C:\config.sys" NOERRORNoConfigsys
  ERRORNoConfigsys:
      messagebox MB_OK "$(errorFileNotFound_1) config.sys $(errorFileNotFound_2). $(aborting)"
      quit
  NOERRORNoConfigsys:

  FileOpen $R1 "C:\config.sys" r
  strcpy $R2 "0" #[menu]
  strcpy $R3 "0" #[puplinux]
  strcpy $R4 "0" #menuitem=PUPLINUX
Read:

  FileRead $R1 $1 ; read the next line
  IfErrors DoneReadWin9x


  push $1
    Call trim
  pop $1

  Push "$1"
  Push "17"
  Push ""
    Call TrimText
  Pop "$1"

  strcmp $1 "menuitem=PUPLINUX" 0 +2
    strcpy $R4 "1"

  Push "$1"
  Push "10"
  Push ""
    Call TrimText
  Pop "$1"

  strcmp $1 "[puplinux]" 0 +2
    strcpy $R3 "1"

  Push "$1"
  Push "6"
  Push ""
    Call TrimText
  Pop "$1"
  strcmp $1 "[menu]" 0 +2
    strcpy $R2 "1"
  goto Read

DoneReadWin9x:
FileClose $R1 ; and close the file

strcmp $R2 "0" 0 YesMenu

  setFileAttributes C:\config.sys.backup NORMAL
  #backup config.sys
  iffileexists "C:\config.sys.backup" 0 +4
    setFileAttributes C:\config.sys.backup NORMAL
    delete "C:\config.sys.backup"
    sleep 500
  CopyFiles "C:\config.sys" "C:\config.sys.backup"

  ClearErrors
  FileOpen $R0 "C:\config.sys" r
  IfErrors ERRORNoConfigsys
  FileOpen $R1 temp.ini w
  FileWrite $R1 "[menu]$\r$\n"
  FileWrite $R1 "menuitem=WINDOWS, Start Windows$\r$\n"
  FileWrite $R1 "menuitem=PUPLINUX, Start Puppy Linux$\r$\n"
  FileWrite $R1 "menudefault=WINDOWS,5$\r$\n"
  FileWrite $R1 "$\r$\n"
  FileWrite $R1 "[PUPLINUX]$\r$\n"
  FileWrite $R1 "install=c:\boot\grub\grub.exe$\r$\n"
  FileWrite $R1 "$\r$\n"
  FileWrite $R1 "[WINDOWS]$\r$\n"

  FileRead $R0 $1
  IfErrors +3
  FileWrite $R1 "$1"
  goto -3

  FileClose $R1
  FileClose $R0
  sleep 200
  delete "C:\config.sys"
  sleep 200
  CopyFiles temp.ini "C:\config.sys"
  delete "$OUTDIR\temp.ini"

  setFileAttributes C:\config.sys.backup HIDDEN|SYSTEM|READONLY
  setFileAttributes C:\config.sys HIDDEN|SYSTEM|READONLY
  return

YesMenu:
  strcmp $R4 "0" 0 YesPuppy


  #backup config.sys
  iffileexists "C:\config.sys.backup" 0 +3
    setFileAttributes C:\config.sys.backup NORMAL
    delete "C:\config.sys.backup"
  CopyFiles "C:\config.sys" "C:\config.sys.backup"

  strcpy $0 "C:\config.sys"    ;file to replace in
  strcpy $1 "menuitem=PUPLINUX, Start Puppy Linux$\r$\n"    ;line to be added
  strcpy $2 "[menu]"    ;line to be found

  ClearErrors

  FileOpen $R0 "$0" a
  FileOpen $R1 temp.ini w

    FileRead $R0 $R2
    IfErrors +18
;trim string
    strcpy $R3 "$R2"
    push $R3
      call Trim
    pop $R3
    push $R3
    Push "6"
    Push ""
      call TrimText
    pop $R3

;search for a string
    StrCmp "$2" $R3 +4 0
    StrCmp "$2$\r$\n" $R3 +5 0
;not found yet
    Filewrite $R1 "$R2"
    GOTO -14
;change a line
    Filewrite $R1 "$R2$\r$\n$1"
    GOTO -16
    Filewrite $R1 "$R2$\r$\n$1"
    GOTO -18
;done
    FileClose $R0
    FileClose $R1
  ;use the temp to replace the original file
  Delete "$0"
  CopyFiles temp.ini "$0"
  Delete "$OUTDIR\temp.ini"

  strcmp $R3 "0" 0 YesPuppy


  FileOpen $R0 "C:\config.sys" a #append
  FileSeek $R0 0 END #go to end
  FileWrite $R0 "$\r$\n$\r$\n"
  FileWrite $R0 "[PUPLINUX]$\r$\n"
  FileWrite $R0 "install=c:\boot\grub\grub.exe$\r$\n"
  FileWrite $R0 "$\r$\n"
  FileClose $R0

  setFileAttributes C:\config.sys.backup HIDDEN|SYSTEM|READONLY
  setFileAttributes C:\config.sys HIDDEN|SYSTEM|READONLY
  return

YesPuppy:

  ClearErrors
  setFileAttributes C:\config.sys NORMAL
  ReadINIStr $0 "C:\config.sys" "PUPLINUX" "install"
  strcmp $0 "C:\boot\grub\grub.exe" +3 0
  WriteINIStr "C:\config.sys" "PUPLINUX" "install" "C:\boot\grub\grub.exe"
  FlushINI "C:\config.sys"

  setFileAttributes C:\config.sys HIDDEN|SYSTEM|READONLY

  return
FunctionEnd





Function WinNT
  SetOutPath "C:\"
    file "${SUPPORT}grldr"
  #add to boot.ini
  setFileAttributes C:\boot.ini NORMAL
  #backup boot.ini
  IfFileExists "C:\boot.ini.backup" 0 +3
    setFileAttributes C:\boot.ini.backup NORMAL
    delete "C:\boot.ini.backup"
  CopyFiles "C:\boot.ini" "C:\boot.ini.backup"

  FileOpen $0 "C:\boot\grub\menu.lst" a
  FileOpen $0 "C:\boot.ini" a
  FileSeek $0 0 END
  FileWrite $0 "$\r$\n" ; write a new line
  FileWrite $0 'c:\grldr="${WHAT_TO_CALL_ON_BOOT}"'
  FileWrite $0 "$\r$\n" ; write an extra line
  FileClose $0 ; and close the file

  Push "timeout=0"                #-- line to be found
  Push "timeout=5"                #-- line to be added
  Push "C:\boot.ini"     #-- file to be searched in
    Call INIChgLine #extend time out
  Push "timeout=1"                #-- line to be found
  Push "timeout=5"                #-- line to be added
  Push "C:\boot.ini"     #-- file to be searched in
    Call INIChgLine #extend time out
  Push "timeout=2"                #-- line to be found
  Push "timeout=5"                #-- line to be added
  Push "C:\boot.ini"     #-- file to be searched in
    Call INIChgLine #extend time out
  Push "timeout=3"                #-- line to be found
  Push "timeout=5"                #-- line to be added
  Push "C:\boot.ini"     #-- file to be searched in
    Call INIChgLine #extend time out
  Push "timeout=4"                #-- line to be found
  Push "timeout=5"                #-- line to be added
  Push "C:\boot.ini"     #-- file to be searched in
    Call INIChgLine #extend time out
  Push "timeout=30"                #-- line to be found
  Push "timeout=5"                #-- line to be added
  Push "C:\boot.ini"     #-- file to be searched in
    Call INIChgLine #shorten time out
  Push "timeout=29"                #-- line to be found
  Push "timeout=5"                #-- line to be added
  Push "C:\boot.ini"     #-- file to be searched in
    Call INIChgLine #shorten time out
  
  setFileAttributes C:\boot.ini HIDDEN|SYSTEM|READONLY
  setFileAttributes C:\boot.ini.backup HIDDEN|SYSTEM|READONLY
FunctionEnd


Function Win7
  ;make backup folder, backup fails without it
  SetOutPath "C:\Backups\"

    ;output files
    SetOutPath "C:\"
    file "${SUPPORT}grldr"
    file "${SUPPORT}grldr.mbr"
    
    ;bcdedit location for 32/64 bit
    strcpy $1 "bcdedit"
   
    ;64 bit
    ${If} ${RunningX64}
      strcpy $1 "$WINDIR\Sysnative\bcdedit.exe"
    ${EndIf}
    ;backup
    nsExec::Exec '"$1" /export "C:\Backups\BCD Backup"'
    
    ;create entry
    nsExec::ExecToStack '"$1" /create /d "${WHAT_TO_CALL_ON_BOOT}" /application bootsector'

    ;get the entry ID
    pop $5 #exit code
    pop $5 #real output
    push $5
      call BetweenBrackets
    pop $5
    
    ;when selected, run C:\grldr.mbr
    nsExec::Exec  '"$1" /set $5 device "partition=C:"'
    nsExec::Exec  '"$1" /set $5 path \grldr.mbr'

    ;add the entry to the selectable list
    nsExec::Exec  '"$1" /displayorder $5 /addlast'

    ;change the timeout to 5, to give the user time to choose
    nsExec::Exec  '"$1" /timeout 5'
    
	;use the lagacy chooser on win8, this will not do anything to win7
    nsExec::Exec '"$1" /set {default} bootmenupolicy legacy'

    ;save to registry
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY_UP_ONE}" "BootID" "$5"

    ;make sure write was good
    clearerrors
    ReadRegStr $6 ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY_UP_ONE}" "BootID"
    
    iferrors 0 +3
    messagebox MB_OK "$(errorWriteRegistry)"
    abort

    strcmp $5 $6 +3
    messagebox MB_OK "$(errorWriteRegistry)"
    abort
    return
FunctionEnd
