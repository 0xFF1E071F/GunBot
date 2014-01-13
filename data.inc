Main_Handles struct
    hServer     dd  ?
    hPort       dd  ?
    hChannel    dd  ?
    hConnect    dd  ?
    hServerOut  dd  ?
    hChatOut    dd  ?
    hCommands   dd  ?
    hUsers      dd  ?
    hNick       dd  ?
Main_Handles ends
 
.data?
hDBase                  dd  ?
hRichEditDll            dd  ?
hInst                   dd  ?
hHeap                   dd  ?
hMain                   dd  ?
dwSocket                dd  ?
NickNum                 dd  ?
dwEditProc              dd  ?
bInChat                 dd  ?
MainHandles             Main_Handles <?>
wsadata                 WSADATA <?>
lvi                     LVITEM <?>
hIml                    dd  ?
lpChannel               db  51 dup (?)
lpszNick                db  12 dup (?)
lpBufHostent            db  MAXGETHOSTSTRUCT dup (?)
szIRCCommand		    db  MAX_STRLEN dup (?)	; the irc command
szIncoming       		db  01000h dup (?)
Nickbuff    		    db  01000h dup (?)