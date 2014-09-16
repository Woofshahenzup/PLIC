!insertmacro MUI_LANGUAGE "Russian" ; 3: Change this to !insertmacro MUI_LANGUAGE "YourLanguage"

; 4: Replace ${LANG_ENGLISH} with ${LANG_YOUR_LANGUAGE} in this file


; 5: Convert English strings below to your language
; Interface
LangString welcomeTitle ${LANG_RUSSIAN} "��������� ${PRODUCT_NAME} ${PRODUCT_VERSION}"
LangString welcomeText ${LANG_RUSSIAN} "���� ������ ��������� ${PRODUCT_NAME} ${PRODUCT_VERSION}.$\r$\n$\r$\n�������� ���������� ��� ������ ���������."

LangString finishTitle ${LANG_RUSSIAN} "��������� ���������!"
LangString rebootQuestion ${LANG_RUSSIAN} "�� ������ ������������� �� � ��������� ${PRODUCT_NAME} ${PRODUCT_VERSION}?"
LangString rebootNow ${LANG_RUSSIAN} "������������� ������"
LangString rebootLater ${LANG_RUSSIAN} "������������� �����"

; Messages
LangString un_confirm ${LANG_RUSSIAN} "�� �������, ��� ������ ��������� ������� $(^Name) � ��� ��� ����������?"
LangString un_success ${LANG_RUSSIAN} "$(^Name) ��� ������� ����� � ������ ����������."

LangString un_delSaveFile ${LANG_RUSSIAN} "�� ������ ������� ����-����?"
LangString un_deleteGrub ${LANG_RUSSIAN} "�� ������ ������� GRUB? ���� ��� ���������� ������ ������, ������� ���. � ��������� ������ ������� ��. (���� ������������, ������� ��)"

; Errors
LangString unknownWinVer ${LANG_RUSSIAN} "����������� ������ Windows. ���������� �������� �� ���� �� �����."
LangString notCompatibleWinVer ${LANG_RUSSIAN} "���� ������ Windows �� ���������� � ���� ����������."
LangString mustBeAdmin ${LANG_RUSSIAN} "�� ������ ���� ���������������, ����� ������������ ��� ���������."

LangString errorFileNotFound_1 ${LANG_RUSSIAN} "������:" ; part 1
LangString errorFileNotFound_2 ${LANG_RUSSIAN} "�� ������." ; part 2

LangString aborting ${LANG_RUSSIAN} "��������� ������ ����� �����������."

LangString cantFindMenuLst ${LANG_RUSSIAN} "GRUB ���������� �� ����� ����������, �� ���������� �� ����� ����� menu.lst. ���������� �������� ��������� � ���� ����:"

LangString errorWriteRegistry ${LANG_RUSSIAN} "������: �� ������� ���������� ������ � ������."

LangString un_errorNoBootId ${LANG_RUSSIAN} "������: �� ������� ����� BootID � �������."

; Readme File
LangString readme_ln_1 ${LANG_RUSSIAN} "��� ������� Puppy Linux ������ ���������������. ��� �������� �� ������� ������� Windows ��� Puppy Linux.$\r$\n"
LangString readme_ln_2 ${LANG_RUSSIAN} "������� ������� ����, ����� enter ����� ������� Puppy Linux.$\r$\n"
LangString readme_ln_3 ${LANG_RUSSIAN} "$\r$\n"
LangString readme_ln_4 ${LANG_RUSSIAN} "����� ������� Puppy Linux, ������ �������� ���� > ��� ��������� > ${PRODUCT_NAME} ${PRODUCT_VERSION} > Uninstall.$\r$\n"
