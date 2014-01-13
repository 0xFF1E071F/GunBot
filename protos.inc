ProcMainDlg PROTO hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM
UpdateText PROTO lpText:DWORD,hControl:DWORD
ProcEdit PROTO hCtl:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD

SendIRCString PROTO lpszString:DWORD

DoCTCP PROTO lpTo:DWORD,lpCommand:DWORD,lpText:DWORD
ParseNicksOn PROTO lpNicks:DWORD



GetQuitMsg PROTO lpQuitMsg:DWORD
toMorseCode PROTO lpszText:DWORD
toPlainText PROTO lpszMorse_Code:DWORD