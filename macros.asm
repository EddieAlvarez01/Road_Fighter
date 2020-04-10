;-------IMPRESION DE CADENAS
print macro chain
    LEA dx, chain
    MOV ah, 09h
    INT 21h
endm

;--------LECTURA DE UN CARACTER SOLO 1, PARA UNA OPCION (ALMACENA LO QUE LEYO EN AL)
readOption macro
    MOV ah, 01h
    INT 21h
endm

;-------LECTURA DE UN CARATCER SIN QUE SE MUESTRE EN PANTALLA EL CARACTER
readCharacterWithoutPrinting macro
    MOV ah, 08h
    INT 21h
endm

;-------IMPRESION DE UN CARACTER
printCharacter macro ch
    MOV ah, 02h
    MOV dl, ch
    INT 21h
endm

;--------LECTURA DE UNA CADENA RECIBE (LEGTH = LONGITUD A LEER,  SAVEDCHAIN = VARIABLE DONDE SE GUARDA)
readChain macro length, savedChain
    MOV ah, 3Fh
    MOV bx, 00
    MOV cx, length
    LEA dx, savedChain
    INT 21h
endm

;---------CREAR UN ARCHIVO DE REPORTE
createFile macro fileName
    ;LOCAL noFileErro
    MOV ah, 3Ch
    MOV cx, 0
    LEA dx, fileName
    INT 21h
    JNC noFileErro
    JMP showFileError

    noFileErro:
        MOV handle, ax
        closeFile
endm

;----------ABRIR UN ARCHIVO
openFile macro fileName, mode
    LOCAL noShowPenFileError
    MOV ah, 3Dh
    MOV al, mode
    LEA dx, fileName
    INT 21h
    JNC noShowPenFileError
    JMP showOpenFileError

    noShowPenFileError:
        MOV handle, ax
endm

;---------ESCRIBIR EN ARCHIVO
writeFile macro length, content
    LOCAL noErrorWiteFile
    MOV bx, handle
    MOV cx, length
    LEA dx, content
    MOV ah, 40h
    INT 21h
    CMP cx, ax
    JE noErrorWiteFile
    JMP showWriteFileError

    noErrorWiteFile:
endm

;------------LEER DE ARCHIVO
readFile macro length, savedChain 
    MOV ah, 3Fh
    MOV bx, handle
    MOV cx, length
    LEA dx, savedChain
    INT 21h
endm

;---------MOVER PUNTERO DE UN ARCHIVO LSEEK
lseek macro displacement, moreIm, lessIm
    LOCAL noErrorFseek
    MOV ah, 42h
    MOV al, displacement
    MOv bx, handle
    MOV cx, moreIm
    MOV dx, lessIm
    INT 21h
    JNC noErrorFseek
    JMP fseekError

    noErrorFseek:
endm

;-------CERRAR UN ARCHIVO ACTIVO EN EL HANDLE
closeFile macro
    MOV bx, handle
    MOV ah, 3Eh
    INT 21h
endm

;------COMPARACION DE CADENAS
chainComparison macro length, chain1, chain2
    MOV cx, length
    MOV ax, ds
    MOV es, ax
    LEA si, chain1
    LEA di, chain2
endm

;-------METER USUSARIOS EN EL ARRAY
putUsersArray macro
    LOCAL newUserLine, comparisonThereUser, insertUser, finishFilling
    LEA si, readTxt
    LEA di, usersAvailablePoints
    MOV bx, 0000h

    newUserLine:
        MOV cx, 0007h
        CMP bx, 01CCh
        JNAE comparisonThereUser
        JMP finishFilling

    comparisonThereUser: 
        MOV al, [si]
        CMP al, 20h
        JNE insertUser
        JMP finishFilling
    
    insertUser:
        MOV al, [si]
        MOV [di], al
        INC si
        INC bx
        INC di
        LOOP insertUser
        ADD si, 0006h
        ADD bx, 0006h
        MOV al, [si]
        SUB al, 30h
        MOV [di], al
        INC si
        INC bx
        INC di
        MOV al, [si]
        SUB al, 30h
        MOV [di], al
        INC di
        ADD si, 0002h
        ADD bx, 0002h
        MOV al, [si]
        SUB al, 30h
        MOV [di], al
        INC di
        INC si
        INC bx
        MOV al, [si]
        SUB al, 30h
        MOV [di], al
        ADD si, 0006h
        ADD bx, 0006h
        JMP newUserLine

    finishFilling:
endm
