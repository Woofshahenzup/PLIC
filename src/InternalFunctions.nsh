SetOverwrite on
!define WHAT_TO_CALL_ON_BOOT "Start Puppy Linux"

; HM NIS Edit Wizard helper defines
!define PRODUCT_WEB_SITE "http://puppylinux.org"
!define PRODUCT_UNINST_KEY_UP_ONE "Software\Microsoft\Windows\CurrentVersion\Uninstall\PuppyLinux"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\PuppyLinux\${PRODUCT_NAME} ${PRODUCT_VERSION}"
!define PRODUCT_UNINST_KEY_THAT_SHOWS_IN_REMOVE_PROGRAMS "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME} ${PRODUCT_VERSION}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

!define PRODUCT_PUBLISHER "Puppy Linux"

!macro mINIChgLine un
Function ${un}INIChgLine
  Exch $0    ;file to replace in
  Exch
  Exch $1    ;line to be changed
  Exch
  Exch 2
  Exch $2    ;line to be search
  Exch 2

  Push $R0   ;for open file
  Push $R1   ;for temp file
  Push $R2

  ClearErrors

  FileOpen $R0 "$0" a
  FileOpen $R1 temp.ini w

    FileRead $R0 $R2
    IfErrors +9
;search for a string
    StrCmp "$2" $R2 +4 0
    StrCmp "$2$\r$\n" $R2 +5 0
;not found yet
    Filewrite $R1 $R2
    GOTO -5
;change a line
    Filewrite $R1 "$1"
    GOTO -7
    Filewrite $R1 "$1$\r$\n"
    GOTO -9
;done
    FileClose $R0
    FileClose $R1
  ;use the temp to replace the original file
  Delete "$0"
  CopyFiles temp.ini "$0"
  Delete "$OUTDIR\temp.ini"

  POP $R2
  POP $R1
  pop $R0
  POP $0
  POP $1
  POP $2
FunctionEnd
!macroend
!insertmacro mINIChgLine ""
!insertmacro mINIChgLine "un."

!macro mFindWinVersion un
Function ${un}findWinVersion

  Push $R9
  Push $R1

  ClearErrors

  ReadRegStr $R9 HKLM \
  "SOFTWARE\Microsoft\Windows NT\CurrentVersion" CurrentVersion

  IfErrors 0 lbl_winnt

  ; not NT
  ReadRegStr $R9 HKLM \
  "SOFTWARE\Microsoft\Windows\CurrentVersion" VersionNumber

  StrCpy $R1 $R9 1
  StrCmp $R1 '4' 0 lbl_error

  StrCpy $R1 $R9 3
  StrCmp $R1 '4.0' lbl_win32_95
  StrCmp $R1 '4.9' lbl_win32_ME lbl_win32_98

  lbl_win32_95:
    #StrCpy $R9 '95'
    StrCpy $R9 '9x'
    Goto lbl_done

  lbl_win32_98:
    #StrCpy $R9 '98'
    StrCpy $R9 '9x'
    Goto lbl_done

  lbl_win32_ME:
    #StrCpy $R9 'ME'
    StrCpy $R9 '9x'
    Goto lbl_done

  lbl_winnt:

  StrCpy $R1 $R9 1

  StrCmp $R1 '3' lbl_winnt_x
  StrCmp $R1 '4' lbl_winnt_x

  StrCpy $R1 $R9 3

  StrCmp $R1 '5.0' lbl_winnt_2000
  StrCmp $R1 '5.1' lbl_winnt_XP
  StrCmp $R1 '5.2' lbl_winnt_2003
  StrCmp $R1 '6.0' lbl_winnt_vista
  StrCmp $R1 '6.1' lbl_winnt_7
  StrCmp $R1 '6.2' lbl_winnt_8
  StrCmp $R1 '6.3' lbl_winnt_8_1
  Goto lbl_error

  lbl_winnt_x:
    #StrCpy $R0 "NT $R0" 6
    StrCpy $R9 'NT'
  Goto lbl_done

  lbl_winnt_2000:
    #Strcpy $R9 '2000'
    StrCpy $R9 'NT'
    Goto lbl_done

  lbl_winnt_XP:
    #Strcpy $R9 'XP'
    StrCpy $R9 'NT'
    Goto lbl_done

  lbl_winnt_2003:
    #Strcpy $R9 '2003'
    StrCpy $R9 'NT'
    Goto lbl_done

  lbl_winnt_vista:
    #Strcpy $R9 'Vista'
    Strcpy $R9 '7'
    Goto lbl_done

  lbl_winnt_7:
    #Strcpy $R9 '7'
    Strcpy $R9 '7'
  Goto lbl_done

  lbl_winnt_8:
    #Strcpy $R9 '8'
    Strcpy $R9 '7'
  Goto lbl_done

  lbl_winnt_8_1:
    #Strcpy $R9 '8.1'
    Strcpy $R9 '7'
  Goto lbl_done

  lbl_error:
    Strcpy $R9 ''
    MessageBox MB_OK|MB_ICONQUESTION "$(unknownWinVer)" IDOK
    quit
  lbl_done:
  Pop $R1
  Exch $R9
FunctionEnd
!macroend
!insertmacro mFindWinVersion ""
!insertmacro mFindWinVersion "un."

!macro mTrim un
Function ${un}Trim
	Exch $R9 ; Original string
	Push $R8

Loop:
	StrCpy $R8 "$R9" 1
	StrCmp "$R8" " " TrimLeft
	StrCmp "$R8" "$\r" TrimLeft
	StrCmp "$R8" "$\n" TrimLeft
	StrCmp "$R8" "$\t" TrimLeft
	GoTo Loop2
TrimLeft:
	StrCpy $R9 "$R9" "" 1
	Goto Loop

Loop2:
	StrCpy $R8 "$R9" 1 -1
	StrCmp "$R8" " " TrimRight
	StrCmp "$R8" "$\r" TrimRight
	StrCmp "$R8" "$\n" TrimRight
	StrCmp "$R8" "$\t" TrimRight
	GoTo Done
TrimRight:
	StrCpy $R9 "$R9" -1
	Goto Loop2

Done:
	Pop $R8
	Exch $R9
FunctionEnd
!macroend
!insertmacro mTrim ""
!insertmacro mTrim "un."

!macro mTrimText un
Function ${un}TrimText
 Exch $R9 ; char
 Exch
 Exch $R8 ; length
 Exch 2
 Exch $R7 ; text
 Push $R6
 Push $R5

 StrLen $R6 $R7
 IntCmp $R6 $R8 Done Done

 StrCpy $R7 $R7 $R8

 StrCpy $R6 0
  IntOp $R6 $R6 + 1
  StrCpy $R5 $R7 1 -$R6
  StrCmp $R5 "" Done
  StrCmp $R5 $R9 0 -3

  IntOp $R6 $R6 + 1
  StrCpy $R5 $R7 1 -$R6
  StrCmp $R5 "" Done
  StrCmp $R5 $R9 -3

  IntOp $R6 $R6 - 1
  StrCpy $R7 $R7 -$R6
  StrCpy $R7 $R7

 Done:
 StrCpy $R9 $R7
 Pop $R5
 Pop $R6
 Pop $R7
 Pop $R8
 Exch $R9 ; output
FunctionEnd
!macroend
!insertmacro mTrimText ""
!insertmacro mTrimText "un."


Function BetweenBrackets
	Exch $R9 ; Original string
	Push $R8

Loop:
	StrCpy $R8 "$R9" 1
	StrCmp "$R8" "{" Loop2 TrimLeft
TrimLeft:
	StrCpy $R9 "$R9" "" 1
	Goto Loop

Loop2:
	StrCpy $R8 "$R9" 1 -1
	StrCmp "$R8" "}" Done TrimRight
TrimRight:
	StrCpy $R9 "$R9" -1
	Goto Loop2

Done:
	Pop $R8
	Exch $R9
FunctionEnd
