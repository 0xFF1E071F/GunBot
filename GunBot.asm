include masm32rt.inc
include ws2_32.inc
includelib ws2_32.lib
include datetime.inc
includelib datetime.lib
include debug2.inc
includelib debug2.lib

include sqlite3.inc                              
includelib sqlite3.lib

include equates.inc
include strings.inc
include data.inc
include protos.inc
_iobuf STRUCT
    _ptr        DWORD ?
    _cnt        DWORD ?
    _base       DWORD ?
    _flag       DWORD ?
    _file       DWORD ?
    _charbuf    DWORD ?
    _bufsiz     DWORD ?
    _tmpfname   DWORD ?
_iobuf ENDS
	;MyProc PROTO here:DWORD,there:DWORD,a:DWORD


.code                           
GunBot:

     
    
    invoke  LoadLibrary, offset szRichEditDll
    mov     hRichEditDll, eax
    ;PrintText "HERE"
    invoke  GetProcessHeap
    mov     hHeap, eax
    
    invoke  GetModuleHandle, NULL
    mov     hInst, eax
     
    invoke  sqlite3_open, offset szSQLDB, offset hDBase

    invoke  DialogBoxParam, eax, DLG_MAIN, HWND_DESKTOP, ProcMainDlg, NULL 
    call    Cleanup
    
GunBot_End:
    invoke  ExitProcess, 0

Cleanup proc
    invoke  closesocket, dwSocket
    invoke  WSACleanup
    invoke  ImageList_Destroy, hIml
    invoke  FreeLibrary, hRichEditDll
    invoke  sqlite3_close, hDBase
    ret
Cleanup endp

GetQuitMsg proc uses esi edi ebx lpQuitMsg:DWORD
local   ppStmt 

    invoke  HeapAlloc, hHeap, HEAP_ZERO_MEMORY, MAX_PATH
    mov     edi, eax
    
    invoke  szMultiCat, 5, edi, offset szSQLSelect, chr$("*"), offset szSQLFrom, chr$("Quit"), chr$(" ORDER BY RANDOM() LIMIT 1;")

    invoke  sqlite3_prepare_v2, hDBase, edi, -1, addr ppStmt, NULL
    invoke  sqlite3_step, ppStmt
    invoke  sqlite3_data_count, ppStmt
    .if eax !=0
        invoke  sqlite3_column_text, ppStmt, 0
        mov    esi, eax
        invoke  szLen, eax
        inc     eax
        invoke  MemCopy, esi, lpQuitMsg, eax
        
    .endif    
    invoke  HeapFree, hHeap, 0, edi
    ret    
GetQuitMsg endp

ProcMainDlg proc uses esi edi ebx hDlg:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
LOCAL   lvc:LVCOLUMN
    mov     eax,uMsg
    .if eax == WM_INITDIALOG
	    push    hDlg
	    pop     hMain
	  
	    mov     ebx, sizeof MainHandles / 4 - 1
	    mov     esi, LAST_RESOURCE
	    mov     edi, offset MainHandles
	GetNextItem:
	    invoke  GetDlgItem, hDlg, esi
	    mov     [edi + 4 * ebx], eax
	    dec     esi
	    dec     ebx
	    jns     GetNextItem
    
        invoke  SetWindowLong, (Main_Handles ptr [edi]).hConnect, GWL_USERDATA, DISCONNECTED  
        invoke  SetWindowLong, (Main_Handles ptr [edi]).hCommands, GWL_WNDPROC, ProcEdit
        mov     dwEditProc, eax
        
        invoke  UpdateText, offset szAppName, (Main_Handles ptr [edi]).hServerOut
        invoke  UpdateText, chr$("Initializing Winsock..."), (Main_Handles ptr [edi]).hServerOut
        invoke  WSAStartup, 0101h, offset wsadata
        test    eax, eax
        jz      @F
        invoke  UpdateText, chr$("ERROR: Winsock Initialization Failed!"), (Main_Handles ptr [edi]).hServerOut
        invoke  EnableWindow, (Main_Handles ptr [edi]).hConnect, FALSE
        mov     eax, TRUE
        ret
    @@:
        invoke  UpdateText, chr$("Winsock initialized, waiting for your command..."), (Main_Handles ptr [edi]).hServerOut
        
        invoke  SendMessage, (Main_Handles ptr [edi]).hUsers, LVM_INSERTCOLUMN, 0, addr lvc
        
        invoke  ImageList_Create, 16, 16, ILC_MASK or ILC_COLORDDB, 4, 4
        mov     hIml, eax
        invoke  LoadImage, hInst, 2, IMAGE_ICON, 16, 16, LR_LOADTRANSPARENT
        push    eax
        invoke  ImageList_AddIcon, hIml, eax 
        call    DestroyIcon
        invoke  SendMessage, (Main_Handles ptr [edi]).hUsers, LVM_SETIMAGELIST, LVSIL_SMALL, hIml
        
    .elseif eax == WM_COMMAND
        mov		edx,wParam
        movzx	eax,dx
        shr		edx,16
        .if edx == BN_CLICKED
            .if eax == BTN_CONNECT              
                invoke  GetWindowLong, MainHandles.hConnect, GWL_USERDATA
                .if eax == DISCONNECTED
                    invoke  SetWindowLong, MainHandles.hConnect, GWL_USERDATA, CONNECTED
                    invoke  SendMessage, MainHandles.hConnect, WM_SETTEXT, 0, chr$("Disconnect") 
                    call    ResolveServer  
                .else
                    invoke  HeapAlloc, hHeap, HEAP_ZERO_MEMORY, MAX_PATH * 2
                    mov     esi, eax
                    invoke  HeapAlloc, hHeap, HEAP_ZERO_MEMORY, MAX_PATH
                    mov     edi, eax
                    
                    invoke  GetQuitMsg, edi
                    invoke  szMultiCat, 4, esi, offset szQuit, offset szColon, edi, offset szCRLF
                    invoke  SetWindowLong, MainHandles.hConnect, GWL_USERDATA, DISCONNECTED
                    invoke  SendMessage, MainHandles.hConnect, WM_SETTEXT, 0, chr$("Connect")
                    invoke  szLen, esi
                    invoke  send, dwSocket, esi, eax, 0
                    invoke  closesocket, dwSocket
                    invoke  HeapFree, hHeap, 0, esi
                    invoke  HeapFree, hHeap, 0, edi
                    invoke  SendMessage, MainHandles.hUsers, LVM_DELETEALLITEMS, 0, 0
                    invoke  SendMessage, MainHandles.hServerOut, WM_SETTEXT, 0, 0
                    invoke  SendMessage, MainHandles.hChatOut, WM_SETTEXT, 0, 0
                .endif             
            .endif
        .endif

    .elseif eax == WM_RESOLVE_SERVER
        mov     eax, lParam
        shr     eax, 16
        .if eax == 0
	        mov     eax, offset lpBufHostent
	        mov     eax, [eax].hostent.h_list
	        mov     eax, [eax]
	        mov     eax, [eax]
	        mov     sin.sin_addr, eax
            invoke  UpdateText, chr$("Server address resolved"), MainHandles.hServerOut 
            call    ConnectServer
                 
        .elseif eax == WSAENETDOWN
            invoke  UpdateText, chr$("DNS could not be reached."), MainHandles.hServerOut
            
        .elseif eax == WSAENOBUFS
            invoke  UpdateText, chr$("DNS Lookup buffer space ran out."), MainHandles.hServerOut
            
        .elseif eax == WSAHOST_NOT_FOUND || eax==WSATRY_AGAIN
            invoke  UpdateText, chr$("Address not found, make sure the address is typed correctly!"), MainHandles.hServerOut
            
        .else
            invoke  UpdateText, chr$("DNS Lookup failed...somehow, did you break something again!?!?"), MainHandles.hServerOut
        .endif      
          
    .elseif eax == WM_WSAASYNC
        mov     eax, lParam
        and     eax, 0FFFFh
        .if eax == FD_CONNECT
            mov     eax, lParam
            shr     eax, 16    
			.if eax==0 			    
			    invoke UpdateText, chr$("Connected to IRC server, logging in..."), MainHandles.hServerOut
			    call    LogIn
			    
			.elseif eax== WSAECONNREFUSED
			    invoke UpdateText, chr$("Connection refused.  Server might be down."), MainHandles.hServerOut
			
			.elseif eax== WSAENETUNREACH
			    invoke UpdateText, chr$("Network couldn't be reached."), MainHandles.hServerOut
			
			.elseif eax== WSAETIMEDOUT
			    invoke UpdateText, chr$("Connection request timed out."), MainHandles.hServerOut
			
			.else
			   invoke UpdateText, chr$("Connection request failed...somehow."), MainHandles.hServerOut
			.endif
		
		.elseif eax == FD_READ
		    call    ReadSocket
		
		.elseif eax == FD_CLOSE
		    PrintText "Socket Closed"
		     
        .endif
        
    .elseif eax == WM_CLOSE
        invoke  GetWindowLong, MainHandles.hConnect, GWL_USERDATA
        .if eax == CONNECTED
            MAKEDWORD	BTN_CONNECT, BN_CLICKED
		    invoke	SendMessage, hMain, WM_COMMAND, eax, NULL
        .endif
        invoke  EndDialog, hDlg, NULL
        
    .else
        mov     eax, FALSE
        ret
    .endif
    mov     eax, TRUE
    ret
ProcMainDlg endp

ProcEdit proc hCtl:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
    .if uMsg == WM_GETDLGCODE
         mov     ecx, lParam
        .if ecx != NULL
            mov     edx, (MSG ptr [ecx]).wParam
            .if (edx == VK_RETURN)
                mov     eax, DLGC_WANTALLKEYS
                ret
            .endif
        .endif   
    
    .elseif uMsg == WM_CHAR
        .if wParam == VK_RETURN
            call    ProcessText
            invoke  SendMessage, MainHandles.hCommands, WM_SETTEXT, 0, 0
            xor     eax, eax
            ret
        .endif
    .endif
    invoke  CallWindowProc, dwEditProc, hCtl, uMsg, wParam, lParam
    ret
       
ProcEdit endp

ProcessText proc uses esi edi ebx
local lpCommand[548]:BYTE
LOCAL lpMsg[548]:BYTE
local lpCmd[8]:BYTE

    xor     edi, edi
    invoke  SendMessage, MainHandles.hCommands, WM_GETTEXTLENGTH, edi, edi
    test    eax, eax
    jz      Done
    
    lea     esi, lpCommand
    invoke  SendMessage, MainHandles.hCommands, WM_GETTEXT, sizeof lpCommand, esi
    invoke  szTrim, esi
    invoke  szLen, esi
    test    eax, eax
    jz      Done

    lea     ebx, lpMsg
    mov     dword ptr [ebx], edi
    cmp     byte ptr [esi], "/"
    je      GotCommand
    
JustChatText:  
    invoke  szMultiCat, 7, ebx, offset szChatMsg, offset szPound, offset lpChannel, offset szSpace, offset szColon, esi, offset szCRLF
    invoke  szLen, ebx
    invoke  send, dwSocket, ebx, eax, edi  
    
    mov     dword ptr [ebx], edi
    invoke  szMultiCat, 5, ebx, offset szNickL, offset lpszNick, offset szNickR, offset szSpace, esi
    invoke  UpdateText, ebx, MainHandles.hChatOut
    jmp     Done   

GotCommand:
    lea     edi, lpCmd
    mov     eax, [esi]  
    mov     [edi], eax
    invoke  szLower, edi
    .if dword ptr [edi] == "iuq/"
        MAKEDWORD	BTN_CONNECT, BN_CLICKED
		invoke	SendMessage, hMain, WM_COMMAND, eax, NULL
		jmp     Done
    .endif
    
    .if dword ptr [edi] == " em/"
        add     esi, 4
	    invoke  szMultiCat, 8, ebx, offset szChatMsg, offset szPound, offset lpChannel, offset szSpace, offset szColon, offset szAction, esi, offset szCRLF
	    invoke  szLen, ebx
	    invoke  send, dwSocket, ebx, eax, 0  
	    
	    mov     byte ptr[ebx], 0
        invoke  szMultiCat, 4, ebx, offset szStars, offset lpszNick, offset szSpace, esi
        invoke  UpdateText, ebx, MainHandles.hChatOut
	    jmp     Done
    .endif
    
    invoke  SendMessage, MainHandles.hCommands, WM_SETTEXT, 0, 0  
    inc     esi
    invoke  szCatStr, esi, offset szCRLF
    invoke  szLen, esi
    invoke  send, dwSocket, esi, eax, 0  

Done:    
    ret
ProcessText endp

LogIn proc uses esi edi ebx 
    xor     ebx, ebx
    mov     edi, offset lpszNick
    mov     dword ptr [edi], ebx
    
    invoke  SendMessage, MainHandles.hNick, WM_GETTEXTLENGTH, ebx, ebx
    test    eax, eax
    jnz     NickEntered
    
NickMissing:
    invoke  UpdateText, chr$("Nick not entered, defaulting to SomeBot"), MainHandles.hServerOut
    invoke  MemCopy, offset szDefNick, edi, sizeof lpszNick
    jmp     @F
    
NickEntered:
    invoke  SendMessage, MainHandles.hNick, WM_GETTEXT, sizeof lpszNick, edi
    invoke  szTrim, edi
    invoke  szLen, edi
    test    eax, eax
    jz      NickMissing   
    
@@: 
    invoke  SendMessage, MainHandles.hNick, WM_SETTEXT, ebx, edi

GetChannel:
    invoke  SendMessage, MainHandles.hChannel, WM_GETTEXTLENGTH, ebx, ebx
    test    eax, eax
    jnz     ChanEntered
    
ChanMissing:
    invoke  UpdateText, chr$("Channel not entered, defaulting to #Test"), MainHandles.hServerOut
    invoke  MemCopy, offset szDefChannel, offset lpChannel, sizeof lpChannel
    jmp     @F
    
ChanEntered:
    invoke  SendMessage, MainHandles.hChannel, WM_GETTEXT, sizeof lpChannel, addr lpChannel
    invoke  szTrim, addr lpChannel
    invoke  szLen, addr lpChannel
    test    eax, eax
    jz      ChanMissing 

@@:        
    invoke  SendMessage, MainHandles.hChannel, WM_SETTEXT, ebx, addr lpChannel
    mov     eax, sizeof szNICK
    push    eax
    invoke  szLen, edi
    pop     ecx
    add     eax, ecx
    inc     eax
    invoke  HeapAlloc, hHeap, HEAP_ZERO_MEMORY, eax
    mov     esi, eax
    invoke  wsprintf, esi, offset szNICK, edi
    invoke  szLen, esi
    invoke  send, dwSocket, esi, eax, ebx
    invoke  HeapFree, hHeap, ebx, esi
    ret
LogIn endp

ConnectServer proc uses ebx esi edi
local   lpszPort[16]:BYTE

    xor     ebx, ebx
    lea     esi, lpszPort
    mov     dword ptr [esi], ebx
    invoke  SendMessage, MainHandles.hPort, WM_GETTEXTLENGTH, ebx, ebx
    test    eax, eax
    jnz     PortEntered
    
PortMissing:
    invoke  UpdateText, chr$("Port not entered, defaulting to 6667"), MainHandles.hServerOut
    invoke  MemCopy, offset szDefPort, esi, sizeof szDefPort
    jmp     Connect
    
PortEntered:
    invoke  SendMessage, MainHandles.hPort, WM_GETTEXT, sizeof lpszPort, esi
    invoke  szTrim, esi
    invoke  szLen, esi
    test    eax, eax
    jz      PortMissing
    
Connect:
    invoke  SendMessage, MainHandles.hPort, WM_SETTEXT, ebx, esi
    mov     eax, sizeof szConnecting
    add     eax, sizeof szDotDotDot
    push    eax
    invoke  szLen, (hostent ptr[lpBufHostent]).h_name
    pop     ecx
    add     eax, ecx
    invoke  HeapAlloc, hHeap, HEAP_ZERO_MEMORY, eax
    xchg    eax, edi

    invoke  szMultiCat, 3, edi, offset szConnecting, (hostent ptr[lpBufHostent]).h_name, offset szDotDotDot
    invoke  UpdateText, edi, MainHandles.hServerOut
    invoke  HeapFree, hHeap, ebx, edi
    
    invoke  atodw, esi
    invoke  htons, eax
    mov     sin.sin_port, ax
    invoke  socket, AF_INET, SOCK_STREAM, ebx
    mov     dwSocket, eax
    invoke  WSAAsyncSelect, eax, hMain, WM_WSAASYNC, FD_CONNECT or FD_READ or FD_CLOSE
    invoke  connect, dwSocket, offset sin, sizeof sin
    ret
ConnectServer endp

ResolveServer proc uses esi ebx
local   lpszServer[64]:BYTE
local   dwIP:DWORD
   
    xor     ebx, ebx
    lea     esi, lpszServer
    mov     dword ptr[esi], ebx
    
    invoke  SendMessage, MainHandles.hServer, WM_GETTEXTLENGTH, ebx, ebx
    test    eax, eax
    jnz     ServerEntered
    
ServerMissing:
    invoke  UpdateText, chr$("Server not entered, defaulting to localhost"), MainHandles.hServerOut
    invoke  MemCopy, offset szLocalHost, esi, sizeof szLocalHost
    jmp     Resolve
    
ServerEntered:
    invoke  SendMessage, MainHandles.hServer, WM_GETTEXT, sizeof lpszServer, esi
    invoke  szTrim, esi
    invoke  szLen, esi
    test    eax, eax
    jz      ServerMissing

Resolve:
    invoke  SendMessage, MainHandles.hServer, WM_SETTEXT, ebx, esi
    invoke  UpdateText, chr$("Resolving server..."), MainHandles.hServerOut
    
    invoke  inet_addr, esi
    .if eax == INADDR_NONE
        invoke  WSAAsyncGetHostByName, hMain, WM_RESOLVE_SERVER, esi, offset lpBufHostent, MAXGETHOSTSTRUCT 
    .else
        mov     dwIP, eax
        invoke  WSAAsyncGetHostByAddr, hMain, WM_RESOLVE_SERVER, addr dwIP, 4, AF_INET, offset lpBufHostent, MAXGETHOSTSTRUCT
    .endif
    ret
ResolveServer endp

UpdateText proc lpText:DWORD, hControl:DWORD
    invoke  SendMessage, hControl, EM_SETSEL, -1, -1
    invoke  SendMessage, hControl, EM_REPLACESEL, FALSE, lpText
    invoke  SendMessage, hControl, EM_REPLACESEL, FALSE, offset szCRLF
    invoke  SendMessage, hControl, EM_SCROLLCARET,  0, 0    
    ret
UpdateText endp

ReadSocket proc uses esi edi ebx
    LOCAL available_data :DWORD
    locaL   TempBuf:DWORD
    
    invoke ioctlsocket, dwSocket, FIONREAD, addr available_data 
    .if (eax==NULL)
      invoke recv, dwSocket, ADDR szIncoming, available_data, 0 
     
      mov ecx, eax			; ecx=sizeof inbuf
	mov ebx, eax
      lea esi, szIncoming
	mov edi, esi
	cld
@L1:
	lodsb
      .if (al==0Ah) || (al==0Dh)
	    mov byte ptr [esi-1],0
	.endif
      dec ecx
      jnz @L1			
	mov ecx, ebx
	mov al,0
      mov edx, edi
@L2:
      repnz scasb
      pusha
      invoke lstrcpy,addr szIncoming,edx

PingResponse:
    cmp dword ptr[szIncoming], "GNIP"  
    jne     Sort_out_Numbers
	invoke  UpdateText, chr$("PING? PONG!"), MainHandles.hServerOut
    mov     byte ptr[szIncoming+1],'O'
    invoke  szLen, offset szIncoming
    invoke  send, dwSocket, offset szIncoming, eax, 0
    invoke  send, dwSocket, offset szCRLF, 2, 0
    jmp     EndSortCom
  
Sort_out_Numbers:
    mov     esi, offset szIncoming
    mov     edi, offset szIRCCommand

FindSpace:
    cmp     byte ptr [esi], 32
    je      GetCode
    inc     esi
    jmp     FindSpace

GetCode:
    inc     esi
    mov     eax, [esi]
    and     eax, 0FFFFFFH
    mov     [edi], eax
    
    cmp     byte ptr [edi], 48
    jb      NotNumber
    cmp     byte ptr [edi], 57
    ja      NotNumber

    invoke  atodw, edi
    .if eax == ERR_YOUREBANNEDCREEP
        invoke  UpdateText, chr$("ERROR: Banned from Server!"), MainHandles.hServerOut    
    
    .elseif eax == ERR_UNKNOWNCOMMAND || eax == ERR_NEEDMOREPARAMS || eax == ERR_NOADMININFO || eax == ERR_NOPRIVILEGES
        invoke  szLen, offset szIncoming
        invoke  HeapAlloc, hHeap, HEAP_ZERO_MEMORY, eax
        mov     TempBuf, eax
        mov     edi, eax
        mov     esi, offset szIncoming
	    mov     ebx, 2
    GetCommand:
        inc     esi
        cmp     byte ptr [esi], 32
        jne     GetCommand
        dec     ebx
        js      @F
        jmp     GetCommand
    @@:
        invoke  szCatStr, edi, offset szError
        invoke  szLen, edi
        add     edi, eax

    GetMsg:
        mov     al, byte ptr[esi]
        cmp     al, 0
        je      PrintIt
        mov     byte ptr [edi], al
        inc     esi
        inc     edi
        jmp     GetMsg
        
    PrintIt:
        invoke  UpdateText, TempBuf, MainHandles.hServerOut
        invoke  HeapFree, hHeap, 0, TempBuf        
        
    .elseif eax == RPL_ENDOFMOTD
        Join:
	    mov     eax, sizeof szJoin
	    push    eax
	    invoke  szLen, offset szDefChannel
	    pop     ecx
	    add     eax, ecx
	    add     eax, 3
	    invoke  HeapAlloc, hHeap, HEAP_ZERO_MEMORY, eax
	    mov     esi, eax
	    invoke  szMultiCat, 3, esi, offset szJoin, offset lpChannel, offset szCRLF
	    invoke  szLen, esi
	    invoke  send, dwSocket, esi, eax, 0
	    invoke  HeapFree, hHeap, 0, esi  
	    
	.elseif eax == ERR_NICKNAMEINUSE
	    inc     NickNum
	    invoke  dwtoa, NickNum, edi
	    invoke  szLen, edi
	    add     eax, sizeof szJustNICK
	    add     eax, 2
	    push    eax
	    invoke  szLen, offset lpszNick
	    pop     ecx
	    add     eax, ecx
	    invoke  HeapAlloc, hHeap, HEAP_ZERO_MEMORY, eax
	    mov     esi, eax
	    invoke  szMultiCat, 4, esi, offset szJustNICK, offset lpszNick, edi, offset szCRLF
        invoke  szLen, esi
        invoke  send, dwSocket, esi, eax, 0 
        invoke  HeapFree, hHeap, 0, esi
        jmp     Join
    
    .elseif eax == RPL_NAMREPLY
        mov     esi, offset szIncoming
        mov     edi, offset Nickbuff
        inc     esi ; skip first :
        
    SkipToNicks:
        inc     esi
        cmp     byte ptr[esi], ":"
        jne     SkipToNicks
        inc     esi ; skip : before nicks
        
        invoke  ParseNicksOn, esi
        
    .elseif eax >= 1 && eax <= 5
        mov     ebx, 2
        xor     edi, edi
        mov     esi, offset szIncoming
    SkipStuff:
        inc     esi
        inc     edi
        cmp     byte ptr [esi], 32
        jne     SkipStuff
        dec     ebx
        js      @F
        jmp     SkipStuff
        
    @@:
        .if eax >= 1 && eax <=3
            add     esi, 2
        .else
            inc     esi
        .endif
        invoke  UpdateText, esi, MainHandles.hServerOut
    .endif     
    jmp     EndChecking
    
NotNumber:
    ;       Check for PRIVMSG
    cmp     dword ptr [edi], "IRP"
    jne     @F
    call    ShowMessage
    jmp     EndChecking

@@:
    ;       Check for JOIN
    cmp     dword ptr [edi], "IOJ"
    jne     @F
    call    AddUser
    jmp     EndChecking 

@@:
    ;       Check for QUIT
    cmp     dword ptr [edi], "IUQ"
    jne     @F
    call    RemoveUser
    jmp     EndChecking
    
@@:
    ;       Check for NICK
    cmp     dword ptr [edi], "CIN"
    jne     @F
    call    UpdateUserList
    jmp     EndChecking

@@:    
    ;       Check for PART
    cmp     dword ptr [edi], "RAP"
    jne     @F
    call    RemoveUser
    jmp     EndChecking   
@@:    
    ; Add more here

EndChecking:
	popa 
	repz scasb			     ; skip any 0s between strings...
	mov edx, edi
	dec edx
	cmp ecx,0
	jne @L2	
   .endif
EndSortCom:
      ret
ReadSocket endp 

ParseNicksOn proc uses esi edi ebx lpNicks:DWORD
    
    mov     esi, lpNicks
    xor     ebx, ebx
    mov     lvi.imask, LVIF_TEXT or LVIF_IMAGE
NextNick:
    mov     edi, offset Nickbuff
ParseNicks: 
    mov     al, byte ptr [esi]
    cmp     al, 32
    je      AddNick
    cmp     al, 0
    je      LastNick
    
    mov     byte ptr [edi], al
    inc     esi
    inc     edi
    jmp     ParseNicks

LastNick:
    inc     ebx   
AddNick:
    mov     byte ptr[edi], 0
    mov     edi, offset Nickbuff
    .if byte ptr[edi] == "@"
        mov     lvi.iImage, 0
        inc     edi
    .else
        mov     lvi.iImage, -1
    .endif
    mov     lvi.pszText, edi 

    invoke  SendMessage, MainHandles.hUsers, LVM_INSERTITEM, 0, offset lvi
    @@:
    inc     esi
    test    ebx, ebx
    jz      NextNick       
    
    invoke  SendMessage, MainHandles.hUsers, LVM_SETCOLUMNWIDTH, 0, LVSCW_AUTOSIZE_USEHEADER
    ret
ParseNicksOn endp

AddUser proc uses esi edi ebx
Local   lpNick[16]:BYTE
local   TempBuf:DWORD
    
    lea     edi, lpNick
    mov     esi, offset szIncoming   
    inc     esi
GetName:
    mov     al, byte ptr [esi]
    cmp     al, "!"
    je      @F
    mov     byte ptr [edi], al
    inc     esi
    inc     edi
    jmp     GetName
@@:    
    mov     byte ptr[edi], 0
    mov     ebx, 1
    
@@:
    inc     esi
    cmp     byte ptr [esi], 32
    jne     @B
    dec     ebx
    jns     @B

PrintIt:    
    invoke  szLen, offset szIncoming
    invoke  HeapAlloc, hHeap, HEAP_ZERO_MEMORY, eax
    mov     edi, eax
    mov     TempBuf, eax
    invoke  szMultiCat, 3, edi, offset szEnter, addr lpNick, offset szJoined
    invoke  szLen, edi
    add     edi, eax
    inc     esi
    inc     esi
@@:
    mov     al, byte ptr [esi]
    cmp     al, 0
    je      Done
    mov     byte ptr[edi], al
    inc     esi
    inc     edi
    jmp     @B
Done:
    invoke  UpdateText, TempBuf, MainHandles.hChatOut
    invoke  HeapFree, hHeap, 0, TempBuf
    
    mov     lvi.imask, LVIF_TEXT or LVIF_IMAGE

    invoke  SendMessage, MainHandles.hUsers, LVM_GETITEMCOUNT, 0, 0
    .if eax == 0
        mov     lvi.iImage, 0
    .else
        mov     lvi.iImage, -1
    .endif
    lea     edi, lpNick
    invoke  Cmpi, edi, offset lpszNick
    test    eax, eax
    jz      Done2
    mov     lvi.pszText,  edi
    invoke  SendMessage, MainHandles.hUsers, LVM_INSERTITEM,  0, addr lvi
    Done2:
    ret
AddUser endp

RemoveUser proc uses esi edi ebx
Local   lpNick[16]:BYTE
local   TempBuf:DWORD
local lvfi:LVFINDINFO

    lea     edi, lpNick
    mov     esi, offset szIncoming
    inc     esi
GetName:
    mov     al, byte ptr [esi]
    cmp     al, "!"
    je      @F
    mov     byte ptr [edi], al
    inc     esi
    inc     edi
    jmp     GetName
@@:    
    mov     byte ptr[edi], 0
    mov     ebx, 1
    
@@:
    inc     esi
    cmp     byte ptr [esi], 32
    jne     @B
    dec     ebx
    jns     @B

PrintIt:    
    invoke  szLen, offset szIncoming
    invoke  HeapAlloc, hHeap, HEAP_ZERO_MEMORY, eax
    mov     edi, eax
    mov     TempBuf, eax
    invoke  szMultiCat, 3, edi, offset szLeave, addr lpNick, offset szLeftServer
    invoke  szLen, edi
    add     edi, eax
    inc     esi
    inc     esi
@@:
    mov     al, byte ptr [esi]
    cmp     al, 0
    je      Done
    mov     byte ptr[edi], al
    inc     esi
    inc     edi
    jmp     @B
Done:
    invoke  UpdateText, TempBuf, MainHandles.hChatOut
    invoke  HeapFree, hHeap, 0, TempBuf
    
    mov     lvfi.flags, LVFI_STRING
    lea     eax, lpNick
    mov     lvfi.psz, eax
    invoke  SendMessage, MainHandles.hUsers, LVM_FINDITEM, -1, addr lvfi
    invoke  SendMessage, MainHandles.hUsers, LVM_DELETEITEM, eax, 0
    ret
RemoveUser endp

UpdateUserList proc uses esi edi ebx
Local   lpNewNick[16]:BYTE
local   lpOldNick[16]:BYTE
local   TempBuf:DWORD
local   lvfi:LVFINDINFO

    lea     edi, lpOldNick
    mov     esi, offset szIncoming
    inc     esi
GetOldName:
    mov     al, byte ptr [esi]
    cmp     al, "!"
    je      @F
    mov     byte ptr [edi], al
    inc     esi
    inc     edi
    jmp     GetOldName
@@:    
    mov     byte ptr[edi], 0
    mov     ebx, 1
    
@@:
    inc     esi
    cmp     byte ptr [esi], 32
    jne     @B
    dec     ebx
    jns     @B
    inc     esi

    lea     edi, lpNewNick
    inc     esi
GetNewNick:
    mov     al, byte ptr [esi]
    cmp     al, 0
    je      @F
    mov     byte ptr [edi], al
    inc     esi
    inc     edi
    jmp     GetNewNick

@@:    
    mov     byte ptr[edi], 0
    
    mov     lvfi.flags, LVFI_STRING
    lea     eax, lpOldNick
    mov     lvfi.psz, eax
    invoke  SendMessage, MainHandles.hUsers, LVM_FINDITEM, -1, addr lvfi
    
    mov     lvi.imask, LVIF_TEXT
    mov     lvi.iItem, eax
    lea     eax, lpNewNick
    mov     lvi.pszText, eax
    invoke  SendMessage, MainHandles.hUsers, LVM_SETITEM, 0, offset lvi
    
    invoke  szLen, addr lpOldNick
    push    eax
    invoke  szLen, addr lpNewNick
    pop     ecx
    add     eax, ecx
    add     eax, sizeof szStars
    add     eax, sizeof szNickChange
    inc     eax
    invoke  HeapAlloc, hHeap, HEAP_ZERO_MEMORY, eax
    mov     ebx, eax
    lea     esi, lpOldNick
    lea     edi, lpNewNick
    invoke  szMultiCat, 4, ebx, offset szStars, esi, offset szNickChange, edi
    invoke  UpdateText, ebx, MainHandles.hChatOut
    invoke  HeapFree, hHeap, 0, ebx
    ret
UpdateUserList endp

ShowMessage proc uses esi edi ebx
LOCAL lpNick[12]:BYTE
LOCAL lpTo[128]:BYTE
LOCAL lpMsg[548]:BYTE
local ptd:DATETIME
local   pszDateTime[48]:BYTE

    lea     edi, lpNick
    mov     esi, offset szIncoming
    inc     esi
    
GetName:
    mov     al, byte ptr [esi]
    cmp     al, "!"
    je      GotName
    mov     byte ptr [edi], al
    inc     esi
    inc     edi
    jmp     GetName
GotName:
    mov     byte ptr[edi], 0
    
SkipServer:
    mov     al, byte ptr [esi]
    cmp     al, 32
    je      GetTo
    inc     esi
    jmp     SkipServer

GetTo:
    lea     edi, lpTo
    add     esi, 9
Next:
    mov     al, byte ptr [esi]
    cmp     al, 32
    je      GetMsg
    mov     byte ptr [edi], al
    inc     esi
    inc     edi
    jmp     Next
    
GetMsg:    
    mov     byte ptr[edi], 0
    add     esi, 2
    invoke  memfill, addr lpMsg, sizeof lpMsg, 0
    .if byte ptr [esi] == "!"
        ; must be for the bot
        invoke  szLower, esi
	    .if dword ptr [esi] == "nug!"
	        add     esi, 5  ; skip !Gun<space>
	        invoke  Cmpi, esi, offset szShowQuit ; showquit
	        .if eax == 0
	            invoke  HeapAlloc, hHeap, HEAP_ZERO_MEMORY, MAX_PATH
	            mov     edi, eax
	            invoke  GetQuitMsg, edi
                lea     eax, lpTo
                inc     eax
                invoke  Cmpi, eax, offset lpChannel
                .if eax != 0
                    ; user /msg'd bot
                    invoke  szLen, addr lpNick
                    inc     eax
                    invoke  MemCopy, addr lpNick, addr lpTo, eax
                .endif
		        invoke  szMultiCat, 6, addr lpMsg, offset szChatMsg, addr lpTo, offset szSpace, offset szColon, edi, offset szCRLF
		        invoke  szLen, addr lpMsg
		        invoke  send, dwSocket, addr lpMsg, eax, 0    
		        invoke  UpdateText, addr lpMsg, MainHandles.hChatOut
	            invoke  HeapFree, hHeap, 0, edi
	            jmp     Done
	        .endif

            invoke  InString, 1, esi, offset szTextToMorse ; Text To Morse
	        .if eax == 1
	            add     esi, sizeof szTextToMorse
	            invoke  szTrim, esi
	            invoke  szLen, esi
	            .if eax == 0
	                jmp     Done
	            .endif
	            
	            invoke  toMorseCode, esi
		        mov     edi, eax
                lea     eax, lpTo
                inc     eax
                invoke  Cmpi, eax, offset lpChannel
                .if eax != 0
                    invoke  szLen, addr lpNick
                    inc     eax
                    invoke  MemCopy, addr lpNick, addr lpTo, eax
                .endif
                
		        invoke  szMultiCat, 6, addr lpMsg, offset szChatMsg, addr lpTo, offset szSpace, offset szColon, edi, offset szCRLF
		        invoke  szLen, addr lpMsg
		        invoke  send, dwSocket, addr lpMsg, eax, 0    
		        invoke  UpdateText, addr lpMsg, MainHandles.hChatOut
	            invoke  HeapFree, hHeap, 0, edi
	            jmp     Done
	        .endif	 
	    
            invoke  InString, 1, esi, offset szMorseToText ; Morse to Text
	        .if eax == 1	            
	            add     esi, sizeof szMorseToText
	            invoke  szTrim, esi
	            invoke  szLen, esi
	            .if eax == 0
	                jmp     Done
	            .endif
	            
	            invoke  szappend, esi, offset szSpace, eax
		        invoke  toPlainText, esi
		        mov     edi, eax
                lea     eax, lpTo
                inc     eax
                invoke  Cmpi, eax, offset lpChannel
                .if eax != 0
                    invoke  szLen, addr lpNick
                    inc     eax
                    invoke  MemCopy, addr lpNick, addr lpTo, eax
                .endif
                
		        invoke  szMultiCat, 6, addr lpMsg, offset szChatMsg, addr lpTo, offset szSpace, offset szColon, edi, offset szCRLF
		        invoke  szLen, addr lpMsg
		        invoke  send, dwSocket, addr lpMsg, eax, 0    
		        invoke  UpdateText, addr lpMsg, MainHandles.hChatOut
	            invoke  HeapFree, hHeap, 0, edi
	            jmp     Done
	        .endif	   
	    .endif
	    
    .elseif byte ptr [esi] == 1 ; CTCP
        inc     esi             ; skip leading 1 ASCII char
        invoke  szLower, esi
        .if dword ptr [esi] == "srev" ;version
            invoke  DoCTCP, addr lpNick, offset szVersion, chr$("GunnerBot 1.0 'Bot created in Assembly!'")
	        
	    .elseif dword ptr [esi] == "gnif" ;finger  
	        invoke  DoCTCP, addr lpNick, offset szFinger, chr$("Excuse me?  Go finger yourself!")
	    
	    .elseif dword ptr [esi] == "itca" ; action
	        add     esi, 7
            invoke  szMultiCat, 4, addr lpMsg, offset szStars, addr lpNick, offset szSpace, esi
            invoke  UpdateText, addr lpMsg, MainHandles.hChatOut
        
        .elseif dword ptr [esi] == "emit" ; Time
            invoke  GetLocalDateTime, addr ptd
            invoke  DateTimeToStringFormat, addr ptd, offset szDateFormat, offset szTimeFormat, addr pszDateTime
            invoke  DoCTCP, addr lpNick, offset szTime, eax
        
        .else  
            invoke  szTrim, esi
            invoke  DoCTCP, addr lpNick, esi, chr$(" - CTCP command not understood")
        .endif
        
    .else
        invoke  InString, 1, esi, offset szMyNick
        .if sdword ptr eax > 0
            Invoke  MessageBeep,0FFFFFFFFh
            jmp     @F
        .endif
            invoke  InString, 1, esi, offset szMyNick2
            .if sdword ptr eax > 0
                    Invoke  MessageBeep, 0FFFFFFFFh
            .endif
        
        @@:
        ; not for bot, chat message  - display  
        invoke  szMultiCat, 5, addr lpMsg, offset szNickL, addr lpNick, offset szNickR, offset szSpace, esi
        invoke  UpdateText, addr lpMsg, MainHandles.hChatOut    
    .endif
    
Done:
    ret
ShowMessage endp

DoCTCP proc uses esi ebx lpTo:DWORD, lpCommand:DWORD, lpText:DWORD
LOCAL lpMsg[548]:BYTE   
    
    xor     ebx, ebx
    lea     esi, lpMsg
    mov     dword ptr [esi], ebx
   
	invoke  szMultiCat, 11, esi, offset szNotice, offset szSpace, lpTo, offset szSpace, offset szColon, offset szCTCPChar, lpCommand, offset szSpace, lpText, offset szCTCPChar, offset szCRLF
	invoke  szLen, esi
	invoke  send, dwSocket, esi, eax, ebx 

    mov     dword ptr [esi], ebx    
	invoke  szMultiCat, 8, esi, offset szStars, offset szNotice, offset szColon, offset szSpace, lpCommand, offset szSpace, chr$("request from: "), lpTo 
	invoke  UpdateText, esi, MainHandles.hServerOut
	    ret
DoCTCP endp

include MorseCode.asm
end GunBot
