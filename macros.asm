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
    LOCAL noFileErro
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
        INC di
        JMP newUserLine

    finishFilling:
endm

;-----------------------ORDENAR ARRAY
dottedOrder macro
    LOCAL arrayPath, vacuumComparison, cycleIn, vacuumComparisonCycleIn, preStartCycleY, startCycleY, fillOutName, memoryExchange, memoryExchange2, increaseCycleOne, getOutBigPicture
    MOV bl, 00h
    MOV bh, 00h
    LEA di, usersAvailablePoints
    MOV si, di

    arrayPath:
        CMP bl, 14h
        JNE vacuumComparison
        JMP getOutBigPicture
    
    vacuumComparison:
        MOV al, [di]
        CMP al, 20h
        JNE cycleIn
        JMP getOutBigPicture
    
    cycleIn:
        INC bh
        ADD si, 000Bh
        CMP bh, 14h
        JNE vacuumComparisonCycleIn
        JMP increaseCycleOne
    
    vacuumComparisonCycleIn:
        MOV al, [si]
        CMP al, 20h
        JNE preStartCycleY
        JMP increaseCycleOne 

    preStartCycleY:
        ADD si, 09h
        MOV ah, [si]
        INC si
        MOV al, [si]
        AAD
        MOV scoreFromArray2, al
        ADD di, 09h
        MOV ah, [di]
        INC di
        MOV al, [di]
        AAD
        MOV scoreFromArray1, al
        DEC si
        DEC di
        SUB si, 09h
        SUB di, 09h
    
    startCycleY:
        MOV al, scoreFromArray1
        CMP al, scoreFromArray2
        JAE cycleIn
        PUSH si
        LEA si, usernameFromArray
        MOV cx, 0007h
    
    fillOutName:
        MOV al, [di]
        MOV [si], al
        INC di
        INC si
        LOOP fillOutName
        MOV ah, [di]
        INC di
        MOV al, [di]
        AAD
        MOV levelFromArray, al
        SUB di, 0008h
        MOV cx, 000Bh
        POP si

    memoryExchange:
        MOV al, [si]
        MOV [di], al
        INC si
        INC di
        LOOP memoryExchange
        SUB di, 000Bh
        SUB si, 000Bh
        PUSH di
        LEA di, usernameFromArray
        MOV cx, 0007h

    memoryExchange2:
        MOV al, [di]
        MOV [si], al
        INC di
        INC si
        LOOP memoryExchange2
        MOV al, levelFromArray
        AAM
        MOV [si], ah
        INC si
        MOV [si], al
        MOV al, scoreFromArray1
        AAM
        INC si
        MOV [si], ah
        INC si
        MOV [si], al
        INC si
        POP di
        SUB si, 000Bh
        JMP cycleIn


    increaseCycleOne:
        INC bl
        ADD di, 000Bh
        MOV si, di
        MOV bh, bl
        JMP arrayPath
    
    getOutBigPicture:
endm

;-------------------------IMPRESIÓN DE TOP 10
top10Printing macro
    LOCAL checkCount, checkVoidArray, printTour, print10, printUsernameTop, comeOutPrint
    MOV bl, 00h
    LEA si, usersAvailablePoints

    checkCount:
        CMP bl, 0Ah
        JNE checkVoidArray
        JMP comeOutPrint

    checkVoidArray:
        MOV al, [si]
        CMP al, 20h
        JNE printTour
        JMP comeOutPrint
    
    printTour:
        LEA di, usernameFromArray
        printCharacter 0Ah
        printCharacter 0Dh
        PUSH bx
        writeFile 0001h newLine
        POP bx
        ADD bl, 01h
        CMP bl, 0Ah
        JE print10
        ADD bl, 30h
        MOV numberForWrite, bl
        printCharacter bl
        PUSH bx
        writeFile 0001h numberForWrite
        POP bx
        printCharacter 2Eh
        PUSH bx
        writeFile 0001h point
        POP bx
        SUB bl, 30h
        DEC bl
        print spaceBetweenNumberUser
        PUSH bx
        LEA bx, spaceBetweenNumberUser
        CALL chainLength
        writeFile cx, spaceBetweenNumberUser
        POP bx
        MOV cx, 0007h
        JMP printUsernameTop

    print10:
        MOV al, bl
        AAM
        ADD ah, 30h
        ADD al, 30h
        PUSH bx
        MOV bh, ah
        MOV bl, al
        printCharacter bh
        printCharacter bl
        printCharacter 2Eh
        PUSH bx
        MOV numberForWrite, bh
        writeFile 0001h numberForWrite
        POP bx
        PUSH bx
        MOV numberForWrite, bl
        writeFile 0001h numberForWrite
        POP bx
        POP bx
        SUB bl, 01h
        print spaceBetweenNumberUser
        PUSH bx
        LEA bx, spaceBetweenNumberUser
        CALL chainLength
        writeFile cx, spaceBetweenNumberUser
        POP bx
        MOV cx, 0007h

    printUsernameTop:
        MOV al, [si]
        MOV [di], al
        INC si
        INC di
        LOOP printUsernameTop
        print usernameFromArray
        PUSH bx
        writeFile 0007h usernameFromArray
        POP bx
        print nameLevelSpacing
        PUSH bx
        LEA bx, nameLevelSpacing
        CALL chainLength
        writeFile cx, nameLevelSpacing
        POP bx
        MOV bh, [si]
        ADD bh, 30h
        printCharacter bh
        PUSH bx
        MOV numberForWrite, bh
        writeFile 0001h numberForWrite
        POP bx
        INC si
        MOV bh, [si]
        ADD bh, 30h
        printCharacter bh
        PUSH bx
        MOV numberForWrite, bh
        writeFile 0001h numberForWrite
        POP bx
        print levelScoreSpacing
        PUSH bx
        LEA bx, levelScoreSpacing
        CALL chainLength
        writeFile cx, levelScoreSpacing
        POP bx
        INC si
        MOV bh, [si]
        ADD bh, 30h
        printCharacter bh
        PUSH bx
        MOV numberForWrite, bh
        writeFile 0001h numberForWrite
        POP bx
        INC si
        MOV bh, [si]
        ADD bh, 30h
        printCharacter bh
        PUSH bx
        MOV numberForWrite, bh
        writeFile 0001h numberForWrite
        POP bx
        INC si
        INC bl
        JMP checkCount
    
    comeOutPrint:
endm

;------------LEER TECLA DEL TECLADO
getKey macro
    MOV ah, 00h
    INT 16h
endm

;-----------ENTRAR AL MODO GRAFICO
graphicMode macro
    MOV ax, 0013h     ;   RESOLUCION: 320 * 200
    INT 10h
    ;MOV ax, 0A000h
    ;MOV ds, ax
endm

;----------ENTRAR AL MODO TEXTO
textMode macro
    MOV ax, 0003h
    INT 10h
    ;MOV ax, @data
    ;MOV ds, ax
endm

;----------CALCULAR PIXELES POR BARRA (ANCHO)
barWidthCalculation macro num
    PUSH ax
    PUSH bx
    PUSH dx
    MOV al, num
    MOV bl, 08h
    MUL bl
    MOV bx, 011Ch
    SUB bx, ax
    MOV ax, bx
    MOV dx, 0000h
    MOV bl, num
    INC bl
    MOV bh, 00h
    DIV bx
    MOV barWidth, ax
    POP dx
    POP bx
    POP ax
endm

;-----------PINTAR PIXEL
paintPixel macro color, x, y
    PUSH ax
    PUSH bx
    PUSH cx
    PUSH dx
    MOV ah, 0Ch
    MOV al, color
    MOV bh, 00h
    MOV cx, x
    MOV dx, y
    INT 10h
    POP dx
    POP cx
    POP bx
    POP ax  
endm

;-----------ARMAR MARCO DE REPORTE
frame macro
    LOCAL buildTopHeader, armLeftSide, buildDownHeader, armRightSide
    MOV cx, 0140h
    MOV coordenateYVideoMode, 0000h
    MOV coordenateXVideoMode, 0000h

    buildTopHeader:
        paintPixel 0Fh, coordenateXVideoMode, coordenateYVideoMode
        INC coordenateXVideoMode
        LOOP buildTopHeader
        MOV coordenateXVideoMode, 0000h
        MOV cx, 00C8h
    
    armLeftSide:
        paintPixel 0Fh, coordenateXVideoMode, coordenateYVideoMode
        INC coordenateYVideoMode
        LOOP armLeftSide
        MOV cx, 0140h
        DEC coordenateYVideoMode

    buildDownHeader:
        paintPixel 0Fh, coordenateXVideoMode, coordenateYVideoMode
        INC coordenateXVideoMode
        LOOP buildDownHeader
        MOV cx, 00C8h
        DEC coordenateXVideoMode
    
    armRightSide:
        paintPixel 0Fh, coordenateXVideoMode, coordenateYVideoMode
        DEC coordenateYVideoMode
        LOOP armRightSide
endm

;--------------------GRAFICAR BARRA
plotBar macro color, width
    LOCAL barX, barY
    MOV coordenateYVideoMode, 000Ah
    MOV cx, width

    barX:
        PUSH cx
        MOV cx, 009Eh
    
    barY:
        paintPixel color, coordenateXVideoMode, coordenateYVideoMode
        INC coordenateYVideoMode
        LOOP barY
        POP cx
        INC coordenateXVideoMode
        MOV coordenateYVideoMode, 000Ah
        LOOP barX
        DEC coordenateXVideoMode
endm

;---------------CALCULAR LA POSICION DE UN NUMERO PARA LA BARRA
calculateBarNumberPosition macro
    PUSH ax
    PUSH bx
    PUSH dx
    MOV ax, finalPosition
    ADD ax, initialPosition
    MOV bx, 0002h
    MOV dx, 0000h
    DIV bx
    MOV bx, 0028h
    MUL bx
    MOV dx, 0000h
    MOV bx, 0140h
    DIV bx
    MOV coordenateYCursor, al
    moveCursor coordenateXCursor, coordenateYCursor
    POP dx
    POP bx
    POP ax
endm


;----------------CREAR REPORTE DE TOP 20 MAYORES PUNTUACIONES
graphBarReport macro
    LOCAL totalBarComparison, finishBarReport, continueBar
    MOV bx, 0000h
    LEA si, usersAvailablePoints
    ADD si, 0009h
    MOV coordenateXVideoMode, 0012h
    MOV coordenateXCursor, 16h

    totalBarComparison:
        CMP bx, barTotal
        JNE continueBar
        JMP finishBarReport

    continueBar:
        MOV al, [si]
        ADD al, 30h
        MOV tenthNumber, al
        INC si
        MOV al, [si]
        ADD al, 30h
        MOV unitNumber, al
        MOV cx, coordenateXVideoMode
        MOV initialPosition, cx
        plotBar 04h, barWidth
        MOV cx, coordenateXVideoMode
        MOV finalPosition, cx
        calculateBarNumberPosition
        printCharacterVideoMode tenthNumber
        printCharacterVideoMode unitNumber
        ADD coordenateXVideoMode, 0008h
        ADD si, 000Ah
        ADD coordenateYCursor, 04h
        INC bx
        JMP totalBarComparison
    
    finishBarReport:
endm

;--------LECTURA DE UN CARACTER EN MODO VIDEO
readCharacterVideoMode macro
    PUSH ax
    MOV ah, 10h
    INT 16h
    POP ax
endm

;---------PUSHEAR ELEMENTOS PARA QUE SE GUARDEN AL PASAR AL MODO VIDEO
saveItemsVideoMode macro
    PUSH barWidth
    PUSH barTotal
    ;PUSH usersAvailablePoints
endm

;---------POPEAR ELEMENTOS EN EL MODOD VIDEO
retrieveItemsVideoMode macro
    ;POP usersAvailablePoints
    POP barTotal
    POP barWidth
endm

;------------CONTAR ELEMETOS DEL ARRAY
countArrayElements macro
    LOCAL accountPath, exitMacro
    PUSH si
    PUSH ax
    MOV cl, 00h
    LEA si, usersAvailablePoints

    accountPath:
        MOV al, [si] 
        CMP al, 20h
        JE exitMacro
        CMP cl, 14h
        JE exitMacro
        ADD si, 000Bh
        INC cl
        JMP accountPath
    
    exitMacro:
        POP ax
        POP si
endm

;--------------TRAER INFORMACION DE DONDE ESTA EL CURSOR  dh = row  dl = column
getInfoCursor macro
    PUSH ax
    PUSH bx
    MOV ah, 03h
    MOV bh, 00h
    INT 10h
    POP bx
    POP ax
endm

;--------------MOVER EL CURSOR
moveCursor macro row, column
    PUSH ax
    PUSH bx
    PUSH dx
    MOV ah, 02h
    MOV bh, 00h
    MOV dh, row
    MOV dl, column
    INT 10h
    POP dx
    POP bx
    POP ax
endm

;-------------REGRESAR EL CURSOR AL ORIGEN
setOriginCursor macro
    PUSH ax
    PUSH bx
    PUSH dx
    MOV ah, 02h
    MOV bh, 00h
    MOV dh, 00h
    MOV dl, 00h
    INT 10h
    POP dx
    POP bx
    POP ax
endm

;-----------ESCRIBIR CARACTER EN MODO VIDEO
printCharacterVideoMode macro asci
    PUSH ax
    PUSH bx
    MOV ah, 0Eh
    MOV al, asci
    MOV bh, 00h
    MOV bl, 0Fh
    INT 10h
    POP bx
    POP ax
endm