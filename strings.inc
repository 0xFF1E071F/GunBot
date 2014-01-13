.data
szRichEditDll       db  "RichEd20",0
szAppName           db  "Gunners IRC Bot", 0
szErrNoRichEdit     db  "Uh Oh, I cannot find riched20.dll, so I cannot start!",0
szCRLF              db  13, 10, 0
szLocalHost         db  "localhost", 0
szDefPort           db  "6667", 0
szDefNick           db  "SomeBot", 0
szConnecting        db  "Connecting to ", 0
szDotDotDot         db  "...", 0
szDefChannel        db  "Test", 0
szNICK              db  'NICK %s', 13, 10, "USER MyName 0 0 ItsMe", 13, 10, 0 
szJustNICK          db  "NICK ", 0
szJoin              db  "JOIN #", 0
szAction            db  "ACTION ", 0
szNotice            db  "NOTICE", 0
szFinger            db  "FINGER", 0
szTime              db  "TIME", 0
szChatMsg           db  "PRIVMSG ", 0
szVersion           db  "VERSION", 0
szShowQuit          db  "showquit", 0
szTextToMorse       db  "ttm", 0
szMorseToText       db  "mtt", 0
szDateFormat        db  "dddd, MMMM dd, yyy", 0
szTimeFormat        db  "HH:mm:ss", 0
szQuit              db  "QUIT ", 0
szSQLSelect         db  "SELECT ", 0
szSQLFrom           db  " FROM ", 0
szCTCPChar          db  1, 0
szColon             db  ":", 0
szStars             db  "*** ", 0
szNickL             db  "<", 0
szNickR             db  ">", 0
szPound             db  "#", 0
szError             db  "*** ERROR *** ", 0
szLeave             db  "<-- ", 0
szEnter             db  "--> ", 0
szLeftServer        db  " has left the room ", 0
szJoined            db  " has joined the room ", 0
szNickChange        db  " is now known as ", 0
sin 		        sockaddr_in <AF_INET, ?, <>, 8 dup(0)>
szSQLDB             db  "GunBot.db3", 0
szMyNick            db  "Gunner", 0
szMyNick2            db  "gunner", 0
;               Alpha
szA             db  ".-", 0
szB             db  "-...", 0
szC             db  "-.-.", 0
szD             db  "-..", 0
szE             db  ".", 0
szF             db  "..-.", 0
szG             db  "--.", 0
szH             db  "....", 0
szI             db  "..", 0
szJ             db  ".---", 0
szK             db  "-.-", 0
szL             db  ".-..", 0
szM             db  "--", 0
szN             db  "-.", 0
szO             db  "---", 0
szP             db  ".--.", 0
szQ             db  "--.-", 0
szR             db  ".-.", 0
szS             db  "...", 0
szT             db  "-", 0
szU             db  "..-", 0
szV             db  "...-", 0
szW             db  ".--", 0
szX             db  "-..-", 0
szY             db  "-.--", 0
szZ             db  "--..", 0
;               Numeric
sz0             db  "-----", 0
sz1             db  ".----", 0
sz2             db  "..---", 0
sz3             db  "...--", 0
sz4             db  "....-", 0
sz5             db  ".....", 0
sz6             db  "-....", 0
sz7             db  "--...", 0
sz8             db  "---..", 0
sz9             db  "----.", 0
;               Special
szDot           db  ".-.-.-", 0
szComma         db  "--..--", 0
szQuestion      db  "..--..", 0
szApost         db  ".----.", 0
szSpace         db  32, 0

;               Lookup table - pointers to valid chars
MorseTable      dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                dd offset szSpace,0,0,0,0,0,0,offset szApost,0,0,0,0, offset szComma,0, offset szDot,0
			    dd offset sz0, offset sz1, offset sz2, offset sz3, offset sz4, offset sz5, offset sz6, offset sz7, offset sz8, offset sz9,0,0,0,0,0, offset szQuestion 
			    dd 0,offset szA, offset szB, offset szC, offset szD, offset szE, offset szF, offset szG, offset szH, offset szI, offset szJ, offset szK, offset szL, offset szM, offset szN, offset szO
			    dd offset szP, offset szQ, offset szR, offset szS, offset szT, offset szU, offset szV, offset szW, offset szX, offset szY, offset szZ,0,0,0,0,0
			    dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			    dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			    dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			    dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			    dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			    dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			    dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			    dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			    dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			    dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
MorseTableSize  equ ($ - MorseTable) /4