COMMENT !
#############################################################
toMorseCode - Converts text to morse code

In:     lpszText = Pointer to buffer containing string to convert      
Returns:
        Pointer to buffer containing morse code
        **Free with HeapFree when done.
############################################################!  
toMorseCode proc uses esi edi ebx lpszText:DWORD
    
    mov     esi, lpszText
    invoke  szUpper, esi                        ; Convert string to uppercase
    invoke  szLen, esi                          ; get length
    shl     eax, 3                              ; multiply length by 8
    invoke  HeapAlloc, hHeap, HEAP_ZERO_MEMORY, eax
    xchg    eax, edi                            ; save pointer
    lea     ebx, MorseTable                     ; get address of lookup table
    
ConvertNext:
    movzx   eax, byte ptr [esi]                 ; get char at current pointer
    test    eax, eax                            ; is it zero?
    jz      Done                                ; yup, goodbye
    cmp     eax, 32                             ; is it a space
    je      DoSpace                             ; must be
    
    mov     ecx, [ebx + 4 * eax]                ; get pointer to morse char from table index in eax
    test    ecx, ecx                            ; is it a valid pointer
    jz      NextChar                            ; nope
    jmp     GoodChar
    
DoSpace:
    invoke  szCatStr, edi, offset szSpace       ; must be a space, append a space to our out buffer
    jmp     NextChar                            ;
    
GoodChar:
    invoke  szMultiCat, 2, edi, ecx, offset szSpace ; append morse char and space to our out buffer

NextChar:
    inc     esi                                 ; increase our string pointer
    jmp     ConvertNext

Done:
    xchg    edi, eax                            ; move converted morse buffer pointer to eax for return
    ret
toMorseCode endp  


COMMENT !
#############################################################
toPlainText - Converts morse code to text

In:     lpszMorse_Code = Pointer to buffer containing morse code to convert      
Returns:
        Pointer to buffer containing morse code
        **Free with HeapFree when done.
############################################################! 
toPlainText proc uses esi edi ebx lpszMorse_Code
local   RetBuf:DWORD ; pointer to converted buffer
local   TempBuf[8]:BYTE ; temp buf to hold current morse char

    mov     esi, lpszMorse_Code         ; put addres of morse sting in esi
    lea     ebx, TempBuf                ; get address of TempBuf
    
    invoke  szLen, esi                  ; get lenght of morse string
    invoke  HeapAlloc, hHeap, HEAP_ZERO_MEMORY, eax ; and create buffer to hold it
    xchg    eax, edi                    ; buffer pointer
    mov     RetBuf, edi                 ; buffer pointer for return
    
NextCode:
    movzx   eax, byte ptr [esi]         ; get current byte at current pointer
    cmp     eax, 32                     ; is it a space?
    je      GetMorseIndex               ; yes, got morse letter
    test    eax, eax                    ; byte a zero?
    jz      MorseDone                   ; yep, end of buffer
    mov     byte ptr [ebx], al          ; move byte to our buffer
    inc     esi                         ; increase morse pointer
    inc     ebx                         ; increase return pointer
    jmp     NextCode                    ; get next byte
    
GetMorseIndex:                          
    mov     byte ptr [ebx], 0           ; NULL term our temp buffer
    lea     ebx, TempBuf                ; get start address of buffer
    
    push    ebx                         ; get index of morse char, will be ASCII code for letter
    call    GetIndex                    ;
    mov     byte ptr [edi], al          ; move letter to our ret buffer
    inc     edi                         ; increase return buffer pointer
    
    lea     ebx, TempBuf                ; get start address of buffer
    inc     esi                         ; increase string pointer
    cmp     byte ptr [esi], 32          ; is next char a space?
    jne     @F                          ; no, get next morse char
    inc     esi                         ; yes, increase string pointer
    mov     byte ptr [edi], 32          ; move space char to return buffer
    inc     edi                         ; increase ret pointer
@@:    
    jmp     NextCode
    
MorseDone:
    mov     eax, RetBuf                 ; move converted buffer pointer to eax for return
    ret
toPlainText endp


COMMENT !
#############################################################
GetIndex - Searches Morse Code lookup table for match

In:     lpszMorseChar = Pointer to buffer with morse code character      
Returns:
        0 for no match
        Index of match = ASCII code of morse code char
############################################################! 
GetIndex proc uses esi edi ebx lpszMorseChar:DWORD
    xor     esi, esi                    ; zero our counter
    mov     edi, offset MorseTable      ; load up lookup table
MorseSearch:
    mov     ebx, [edi + 4 * esi]        ; get char pointer at index in esi
    test    ebx, ebx                    ; if zero - not a valid char
    jz      NotFound                    ;

    invoke  Cmpi, lpszMorseChar, ebx    ; are Lookup table char and MorseChar the same?
    test    eax, eax
    jnz     NotFound

    xchg    esi, eax                    ; yup, put counter value in eax for return
    jmp     SearchDone
    
NotFound:
    inc     esi                         ; increase our counter
    cmp     esi, MorseTableSize         ; are we at end of table?
    jne     MorseSearch                 ; nope, get next lookup pointer
    
MorseNotFound:                          
    xor     eax, eax                    ; not found, return 0

SearchDone:
    ret
GetIndex endp