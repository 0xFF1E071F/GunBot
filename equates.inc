; Resource equates
DLG_MAIN                equ 1000
EDT_SERVER              equ 1001
EDT_PORT                equ 1002
EDT_CHANNEL             equ 1003
BTN_CONNECT             equ 1004
RED_SERVER_OUTPUT       equ 1005
RED_CHAT_OUTPUT         equ 1006
EDT_COMMANDS            equ 1007
LSV_USERS               equ 1008
EDT_NICK                equ 1009
LAST_RESOURCE           equ EDT_NICK


;WM_USER		equ 	0400H
;WM_WSAASYNC	equ 	WM_USER+100

; Message equates
WM_WSAASYNC	            equ WM_APP + 100
WM_RESOLVE_SERVER       equ WM_WSAASYNC + 1
 
CONNECTED			    equ	1
DISCONNECTED		    equ	0
MAX_STRLEN              equ 0200h   ; 512 char string buffers 
MAX_BUFFER              equ 100*MAX_STRLEN	; increase to get bigger scrollback

ERR_NICKNAMEINUSE       equ 433
RPL_ENDOFMOTD           equ 376
ERR_YOUREBANNEDCREEP    equ 465
RPL_NAMREPLY            equ 353
ERR_UNKNOWNCOMMAND      equ 421
ERR_NEEDMOREPARAMS      equ 461
ERR_NOPRIVILEGES        equ 481
ERR_NOADMININFO         equ 423
