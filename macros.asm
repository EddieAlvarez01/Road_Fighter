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

;-------METER USUARIOS EN EL ARRAY CON LOS TIEMPOS
putUsersArrayTimes macro
    LOCAL newUserLine, comparisonThereUser, insertUser, finishFilling
    LEA si, readTxt
    LEA di, usersWithTimes
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
        ADD si, 0005h
        ADD bx, 0005h
        MOV al, [si]
        SUB al, 30h
        MOV [di], al
        INC di
        INC si
        INC bx
        MOV al, [si]
        SUB al, 30h
        MOV [di], al
        INC di
        INC si
        INC bx
        MOV al, [si]
        SUB al, 30h
        MOV [di], al
        INC di
        ADD si, 0002h
        ADD bx, 0002h
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

top10TimesPrinting macro
    LOCAL checkCount, checkVoidArray, printTour, print10, printUsernameTop, comeOutPrint
    MOV bl, 00h
    LEA si, usersWithTimes

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
frame macro xInitial, yInitial
    LOCAL buildTopHeader, armLeftSide, buildDownHeader, armRightSide
    MOV cx, 0140h
    MOV coordenateYVideoMode, yInitial
    MOV coordenateXVideoMode, xInitial

    buildTopHeader:
        paintPixel 0Fh, coordenateXVideoMode, coordenateYVideoMode
        INC coordenateXVideoMode
        LOOP buildTopHeader
        MOV coordenateXVideoMode, 0000h
        MOV bx, 00C8h
        SUB bx, yInitial
        MOV cx, bx
    
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
        MOV bx, 00C8h
        SUB bx, yInitial
        MOV cx, bx
        DEC coordenateXVideoMode
    
    armRightSide:
        paintPixel 0Fh, coordenateXVideoMode, coordenateYVideoMode
        DEC coordenateYVideoMode
        LOOP armRightSide
endm

;--------------------GRAFICAR BARRA
plotBar macro color, width, heigth
    LOCAL barX, barY
    PUSH bx
    MOV cx, heigth
    MOV coordenateYVideoMode, cx
    MOV cx, width

    barX:
        PUSH cx
        MOV cx, downwardTravel
    
    barY:
        paintPixel color, coordenateXVideoMode, coordenateYVideoMode
        INC coordenateYVideoMode
        LOOP barY
        POP cx
        INC coordenateXVideoMode
        MOV bx, heigth
        MOV coordenateYVideoMode, bx
        LOOP barX
        DEC coordenateXVideoMode
        POP bx
endm


;----------------GRAFICAR BARRAS PARA ORDENAMIENTO
graphBarReport2 macro
    LOCAL totalBarComparison2, finishBarReport2, continueBar2
    MOV bx, 0000h
    LEA si, usersAvailablePoints
    ADD si, 0009h
    MOV coordenateXVideoMode, 0012h
    MOV coordenateXCursor, 16h

    totalBarComparison2:
        CMP bx, barTotal
        JNE continueBar2
        JMP finishBarReport2

    continueBar2:
        MOV ah, [si]
        ADD ah, 30h
        MOV tenthNumber, ah
        SUB ah, 30h
        INC si
        MOV al, [si]
        ADD al, 30h
        MOV unitNumber, al
        SUB al, 30h
        AAD
        MOV numberForWrite, al
        calculateBarHeight 8Eh
        setBarColor numberForWrite
        MOV cx, coordenateXVideoMode
        MOV initialPosition, cx
        plotBar colorBar, barWidth, barHeigth
        MOV cx, coordenateXVideoMode
        MOV finalPosition, cx
        calculateBarNumberPosition
        printCharacterVideoMode tenthNumber
        printCharacterVideoMode unitNumber
        ADD coordenateXVideoMode, 0008h
        ADD si, 000Ah
        ADD coordenateYCursor, 04h
        INC bx
        JMP totalBarComparison2
    
    finishBarReport2:
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
        MOV ah, [si]
        ADD ah, 30h
        MOV tenthNumber, ah
        SUB ah, 30h
        INC si
        MOV al, [si]
        ADD al, 30h
        MOV unitNumber, al
        SUB al, 30h
        AAD
        MOV numberForWrite, al
        calculateBarHeight 9Eh
        setBarColor numberForWrite
        MOV cx, coordenateXVideoMode
        MOV initialPosition, cx
        plotBar colorBar, barWidth, barHeigth
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

;---------------CONTAR ELEMENTOS GENERICO PARA PUNTEOS
countArrayElementsGeneric macro array
    LOCAL accountPath2, exitMacro2
    PUSH si
    PUSH ax
    MOV cl, 00h
    LEA si, array

    accountPath2:
        MOV al, [si]
        CMP al, 20h
        JE exitMacro2
        CMP cl, 14h
        JE exitMacro2
        ADD si, 000Bh
        INC cl
        JMP accountPath2
    
    exitMacro2:
        POP ax
        POP si
endm

;---------------CONTAR ELEMENTOS GENERICO PARA TOP 10 TIEMPOS
countArrayElementsGenericPts macro array
    LOCAL accountPath2, exitMacro2
    PUSH si
    PUSH ax
    MOV cl, 00h
    LEA si, array

    accountPath2:
        MOV al, [si]
        CMP al, 20h
        JE exitMacro2
        CMP cl, 14h
        JE exitMacro2
        ADD si, 000Ch
        INC cl
        JMP accountPath2
    
    exitMacro2:
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

;------------SACAR EL PUNTAJE MAXIMO 100%
getTopScore macro
    PUSH si
    PUSH ax
    LEA si, usersAvailablePoints
    ADD si, 0009h
    MOV ah, [si]
    INC si
    MOV al, [si]
    AAD
    MOV maximunScore, al
    POP ax
    POP si
endm

;------------SACAR EL TIEMPO MAXIMO 100%
getTopTime macro array
    PUSH si
    PUSH ax
    LEA si, usersWithTimes
    ADD si, 0009h
    MOV al, [si]
    MOV hundredthNumber, al
    INC si
    MOV al, [si]
    MOV tenthNumber, al
    INC si
    MOV al, [si]
    MOV unitNumber, al
    form3DigitNumber hundredthNumber, tenthNumber, unitNumber
    MOV ax, numberWord
    MOV maximunTime, ax
    POP ax
    POP si
endm

;------------------ CALCULA LA ALTURA DE LA BARRA
calculateBarHeight macro heigth
    PUSH ax
    PUSH bx
    PUSH dx
    MOV al, numberForWrite
    MOV bl, 64h
    MUL bl
    MOV dx, 0000h
    MOV bl, maximunScore
    MOV bh, 00h
    DIV bx
    MOV bl, heigth
    MUL bl
    MOV dx, 0000h
    MOV bx, 0064h
    DIV bx
    MOV bl, 0A8h
    MOV ah, 00h
    MOV downwardTravel, ax
    SUB bl, al
    MOV bh, 00h
    MOV barHeigth, bx
    POP dx
    POP bx
    POP ax 
endm

;---------------------- CALCULAR LA ALTURA DE LA BARRA PARA LOS TIEMPOS
calculateBarHeight2 macro heigth
    PUSH ax
    PUSH bx
    PUSH dx
    MOV ax, numberWord
    MOV bl, 64h
    MOV bh, 00h
    MUL bx
    MOV bx, maximunTime
    DIV bx
    MOV bl, heigth
    MUL bl
    MOV dx, 0000h
    MOV bx, 0064h
    DIV bx
    MOV bl, 0A8h
    MOV ah, 00h
    MOV downwardTravel, ax
    SUB bl, al
    MOV bh, 00h
    MOV barHeigth, bx
    POP dx
    POP bx
    POP ax
endm

;----------------CALCULAR COLOR
setBarColor macro number
    LOCAL assignRed, assignedBlue, assignedYellow, assignedGreen, assignedWhite, exitColors
    CMP number, 14h
    JBE assignRed
    CMP number, 28h
    JBE assignedBlue
    CMP number, 3Ch
    JBE assignedYellow
    CMP number, 50h
    JBE assignedGreen
    JMP assignedWhite

    assignRed:
        MOV colorBar, 04h
        JMP exitColors

    assignedBlue:
        MOV colorBar, 01h
        JMP exitColors
    
    assignedYellow:
        MOV colorBar, 0Eh
        JMP exitColors
    
    assignedGreen:
        MOV colorBar, 02h
        JMP exitColors

    assignedWhite:
        MOV colorBar, 0Fh
    
    exitColors:
endm

;-------------GENERA UN RETRASO
delay macro const
    LOCAL d1, d2, finDelay
    PUSH si
    MOV si, const
    
    d1:
        DEC si
        JZ finDelay
        MOV di, const

    d2:
        DEC di
        JNZ d2
        JMP d1

    finDelay:
        POP si 
endm

;--------------EMITE UN SONIDO
sound macro time
    PUSH ax
    PUSH bx
    PUSH dx
    MOV al, 0B6h
    OUT 43h, al
    ;MOV dx, 0012h
    MOV ax, 11D0h
    ;MOV bx, hz
    ;DIV bx
    OUT 42h, al
    MOV al, ah
    OUT 42h, al
    IN al, 61h
    OR al, 00000011b
    OUT 61h, al
    delay time
    IN al, 61h
    AND al, 11111100b
    OUT 61h, al
    POP dx
    POP bx
    POP ax 
endm

;-----------------IMPRIMIR CADENA EN MODO GRAFICO
printGraphicMode macro chain, row, column, length
    PUSH ax
    PUSH es
    PUSH bp
    PUSH cx
    PUSH dx
    MOV ax, @data
    MOV es, ax
    LEA bp, chain
    MOV ah, 13h
    MOV al, 01h
    MOV bh, 00h
    MOV bl, 0Fh
    MOV cx, length
    MOV dh, row
    MOV dl, column
    INT 10h
    POP dx
    POP cx
    POP bp
    POP es
    POP ax
endm

;------------------CALCULAR TIEMPO DEL DELAY SEGUN LA VELOCIDAD ESCOJIDA
calculateDelayTime macro velocity
    PUSH ax
    PUSH bx
    PUSH dx
    MOV ax, 012Ch
    MOV bl, velocity
    MOV bh, 00h
    MUL bx
    MOV bx, 0E74h
    SUB bx, ax
    MOV varDelay, bx
    POP dx
    POP bx
    POP ax
endm

;-------------------BURBUJA DE FORMA DESCENDENTE
bubbleDescending macro
    LOCAL arrayPath2, vacuumComparison2, cycleIn2, vacuumComparisonCycleIn2, preStartCycleY2, startCycleY2, fillOutName2, memoryExchange3, memoryExchange4, increaseCycleOne2, getOutBigPicture2
    MOV bl, 00h
    MOV bh, 00h
    LEA di, usersAvailablePoints
    MOV si, di

    arrayPath2:
        CMP bl, 14h
        JNE vacuumComparison2
        JMP getOutBigPicture2
    
    vacuumComparison2:
        MOV al, [di]
        CMP al, 20h
        JNE cycleIn2
        JMP getOutBigPicture2
    
    cycleIn2:
        INC bh
        ADD si, 000Bh
        CMP bh, 14h
        JNE vacuumComparisonCycleIn2
        JMP increaseCycleOne2
    
    vacuumComparisonCycleIn2:
        MOV al, [si]
        CMP al, 20h
        JNE preStartCycleY2
        JMP increaseCycleOne2

    preStartCycleY2:
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
    
    startCycleY2:
        MOV al, scoreFromArray1
        CMP al, scoreFromArray2
        JAE cycleIn2
        PUSH si
        LEA si, usernameFromArray
        MOV cx, 0007h
    
    fillOutName2:
        MOV al, [di]
        MOV [si], al
        INC di
        INC si
        LOOP fillOutName2
        MOV ah, [di]
        INC di
        MOV al, [di]
        AAD
        MOV levelFromArray, al
        SUB di, 0008h
        MOV cx, 000Bh
        POP si

    memoryExchange3:
        MOV al, [si]
        MOV [di], al
        INC si
        INC di
        LOOP memoryExchange3
        SUB di, 000Bh
        SUB si, 000Bh
        PUSH di
        LEA di, usernameFromArray
        MOV cx, 0007h

    memoryExchange4:
        MOV al, [di]
        MOV [si], al
        INC di
        INC si
        LOOP memoryExchange4
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
        PUSH bx
        PUSH si
        PUSH di
        textMode
        graphicMode
        frame 0000h 0010h
        LEA bx, orderingBubbleSortMsg
        CALL chainLength
        printGraphicMode orderingBubbleSortMsg 00h 00h cx
        getInfoCursor
        LEA bx, timeMsg
        CALL chainLength
        printGraphicMode timeMsg 00h dl cx
        graphBarReport2
        delay varDelay
        POP di
        POP si
        POP bx
        JMP cycleIn2


    increaseCycleOne2:
        INC bl
        ADD di, 000Bh
        MOV si, di
        MOV bh, bl
        JMP arrayPath2
    
    getOutBigPicture2:
        textMode
        graphicMode
        frame 0000h 0010h
        LEA bx, orderingBubbleSortMsg
        CALL chainLength
        printGraphicMode orderingBubbleSortMsg 00h 00h cx
        getInfoCursor
        LEA bx, timeMsg
        CALL chainLength
        printGraphicMode timeMsg 00h dl cx
        graphBarReport2
endm

;---------------------BURBUJA ASCENDENTE
bubbleAscending macro
    LOCAL arrayPath3, vacuumComparison3, cycleIn3, vacuumComparisonCycleIn3, preStartCycleY3, startCycleY3, fillOutName3, memoryExchange5, memoryExchange6, increaseCycleOne3, getOutBigPicture3
    MOV bl, 00h
    MOV bh, 00h
    LEA di, usersAvailablePoints
    MOV si, di

    arrayPath3:
        CMP bl, 14h
        JNE vacuumComparison3
        JMP getOutBigPicture3
    
    vacuumComparison3:
        MOV al, [di]
        CMP al, 20h
        JNE cycleIn3
        JMP getOutBigPicture3
    
    cycleIn3:
        INC bh
        ADD si, 000Bh
        CMP bh, 14h
        JNE vacuumComparisonCycleIn3
        JMP increaseCycleOne3
    
    vacuumComparisonCycleIn3:
        MOV al, [si]
        CMP al, 20h
        JNE preStartCycleY3
        JMP increaseCycleOne3

    preStartCycleY3:
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
    
    startCycleY3:
        MOV al, scoreFromArray1
        CMP al, scoreFromArray2
        JBE cycleIn3
        PUSH si
        LEA si, usernameFromArray
        MOV cx, 0007h
    
    fillOutName3:
        MOV al, [di]
        MOV [si], al
        INC di
        INC si
        LOOP fillOutName3
        MOV ah, [di]
        INC di
        MOV al, [di]
        AAD
        MOV levelFromArray, al
        SUB di, 0008h
        MOV cx, 000Bh
        POP si

    memoryExchange5:
        MOV al, [si]
        MOV [di], al
        INC si
        INC di
        LOOP memoryExchange5
        SUB di, 000Bh
        SUB si, 000Bh
        PUSH di
        LEA di, usernameFromArray
        MOV cx, 0007h

    memoryExchange6:
        MOV al, [di]
        MOV [si], al
        INC di
        INC si
        LOOP memoryExchange6
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
        PUSH bx
        PUSH si
        PUSH di
        textMode
        graphicMode
        frame 0000h 0010h
        LEA bx, orderingBubbleSortMsg
        CALL chainLength
        printGraphicMode orderingBubbleSortMsg 00h 00h cx
        getInfoCursor
        LEA bx, timeMsg
        CALL chainLength
        printGraphicMode timeMsg 00h dl cx
        graphBarReport2
        delay varDelay
        POP di
        POP si
        POP bx
        JMP cycleIn3

    increaseCycleOne3:
        INC bl
        ADD di, 000Bh
        MOV si, di
        MOV bh, bl
        JMP arrayPath3
    
    getOutBigPicture3:
        textMode
        graphicMode
        frame 0000h 0010h
        LEA bx, orderingBubbleSortMsg
        CALL chainLength
        printGraphicMode orderingBubbleSortMsg 00h 00h cx
        getInfoCursor
        LEA bx, timeMsg
        CALL chainLength
        printGraphicMode timeMsg 00h dl cx
        graphBarReport2
endm

;-------CALCULAR FINAL DEL ARRAY
calculateFinalArray macro array
    LOCAL cycle, exitMacro
    PUSH cx
    PUSH si
    countArrayElementsGeneric array
    DEC cl
    MOV finalIndex, cl
    LEA si, array
    ADD si, 000Ah
    MOV cl, 00h

    cycle:
        MOV finalNumberDirection, si
        CMP cl, finalIndex
        JE exitMacro
        INC cl
        ADD si, 000Bh
        JMP cycle

    exitMacro:
        POP si
        POP cx
endm

;------------CALCULAR EL FINAL DEL ARRAY DE NUMEROS
calculateFinalArrayTime macro array
    LOCAL cycle, exitMacro
    PUSH cx
    PUSH si
    countArrayElementsGenericPts usersWithTimes
    DEC cl
    MOV finalIndex, cl
    LEA si, array
    MOV cl, 00h

    cycle:
        MOV finalNumberDirection, si
        CMP cl, finalIndex
        JE exitMacro
        INC cl
        ADD si, 0003h
        JMP cycle
    
    exitMacro:
        POP si
        POP cx
endm

;---------CALCULAR PIVOTE DE UN ARREGLO O RECORTE DE ARREGLO
calculatePivot macro array, start, final
    LOCAL cycle, exitMacro
    PUSH ax
    PUSH si
    PUSH cx
    PUSH bx
    MOV al, start
    ADD al, final
    MOV ah, 00h
    MOV bl, 02h
    DIV bl
    LEA si, array
    ADD si, 0009h
    MOV cl, 00h

    cycle:
        CMP cl, al
        JE exitMacro
        INC cl
        ADD si, 000Bh
        JMP cycle
    
    exitMacro:
        MOV ah, [si]
        INC si
        MOV al, [si]
        AAD
        MOV pivotNumber, al
        POP bx
        POP cx
        POP si
        POP ax
endm

;---------CALCULAR PIVOTE DE UN ARREGLO O RECORTE DE ARREGLO
calculatePivotTime macro array, start, final
    LOCAL cycle, exitMacro
    PUSH ax
    PUSH si
    PUSH cx
    PUSH bx
    MOV al, start
    ADD al, final
    MOV ah, 00h
    MOV bl, 02h
    DIV bl
    LEA si, array
    MOV cl, 00h

    cycle:
        CMP cl, al
        JE exitMacro
        INC cl
        ADD si, 0003h
        JMP cycle
    
    exitMacro:
        MOV al, [si]
        MOV hundredthNumber, al
        INC si
        MOV al, [si]
        MOV tenthNumber, al
        INC si
        MOV al, [si]
        MOV unitNumber, al
        form3DigitNumber hundredthNumber tenthNumber unitNumber
        MOV ax, numberWord
        MOV pivotNumberTime, ax
        POP bx
        POP cx
        POP si
        POP ax
endm

;----------------------MOVER PUNTERO DEL INICIO
setPointer macro array, index
    LOCAL cycle, exitMacro
    PUSH si
    PUSH cx
    LEA si, array
    MOV cl, 00h
    ADD si, 0009h

    cycle:
        CMP cl, index
        JE exitMacro
        INC cl
        ADD si, 000Bh
        JMP cycle
    
    exitMacro:
        MOV startNumberDirection, si
        POP cx
        POP si
endm

;------------------- MOVER PUNTERO DESDE EL INDICE INICIAL HACIA LA POSICION DE MEMORIA QUE REPRESENTA
setPointerTime macro array, index
    LOCAL cycle, exitMacro
    PUSH si
    PUSH cx
    LEA si, array
    MOV cl, 00h
    
    cycle:
        CMP cl, index
        JE exitMacro
        INC cl
        ADD si, 0003h
        JMP cycle

    exitMacro:
        MOV startNumberDirection, si
        POP cx
        POP si
endm

setPointerFinal macro array, index
    LOCAL cycle, exitMacro
    PUSH si
    PUSH cx
    LEA si, array
    MOV cl, 00h
    ADD si, 000Ah

    cycle:
        CMP cl, index
        JE exitMacro
        INC cl
        ADD si, 000Bh
        JMP cycle
    
    exitMacro:
        MOV finalNumberDirection, si
        POP cx
        POP si
endm

;----------------------CALCULAR EL SEGUNDO NUMERO (SU POSICION DE MEMORIA)
setPointerFinalTime macro array, index
    LOCAL cycle, exitMacro
    PUSH si
    PUSH cx
    LEA si, array
    MOV cl, 00h

    cycle:
        CMP cl, index
        JE exitMacro
        INC cl
        ADD si, 0003h
        JMP cycle
    
    exitMacro:
        MOV finalNumberDirection, si
        POP cx
        POP si
endm


;-----------------------CALCULAR SALTO PARA SHELL
calculateJump macro array
    PUSH ax
    PUSH bx
    PUSH cx
    countArrayElementsGeneric array
    MOV ah, 00h
    MOV al, cl
    MOV bl, 02h
    DIV bl
    MOV leap, al
    POP cx
    POP bx
    POP ax
endm

;--------------------------CALCULAR SALTO SHELL DE TIEMPOS
calculateJumpTimes macro array
    PUSH ax
    PUSH bx
    PUSH cx
    countArrayElementsGenericPts array
    MOV ah, 00h
    MOV al, cl
    MOV bl, 02h
    DIV bl
    MOV leap, al
    POP cx
    POP bx
    POP ax
endm

;----------------------METODO DE ORDENAMIENTO SHELL DESCENDENTE
shellSortDescending macro array ;-------------------------ch = i,  bh = j   bl = k
    LOCAL while, enterCycle, for, enterFor, while2, enterWhile2, meetsCondition, exchange, postFor, beforeCheckingWhile, exitMacro

    while:
        CMP leap, 00h
        JA enterCycle
        JMP exitMacro
    
    enterCycle:
        MOV ch, leap
    
    for:
        CMP ch, pivotNumber
        JL enterFor
        JMP beforeCheckingWhile

    enterFor:
        MOV bh, ch
        SUB bh, leap
    
    while2:
        CMP bh, 00h
        JGE enterWhile2
        JMP postFor

    enterWhile2:
        setPointer array bh
        MOV si, startNumberDirection
        MOV bl, bh
        ADD bl, leap
        setPointerFinal array bl
        MOV di, finalNumberDirection
        MOV ah, [si]
        INC si
        MOV al, [si]
        AAD
        DEC si
        MOV scoreFromArray1, al
        MOV al, [di]
        DEC di
        MOV ah, [di]
        AAD
        INC di
        CMP scoreFromArray1, al
        JAE meetsCondition
        JMP exchange

    meetsCondition:
        MOV bh, 0FFh
        JMP while2

    exchange:
        DEC di
        MOV al, [di]
        MOV [si], al
        INC di
        INC si
        MOV al, [di]
        MOV [si], al
        DEC di
        MOV al, scoreFromArray1
        AAM
        MOV [di], ah
        INC di
        MOV [di], al
        DEC si
        SUB bh, leap
        PUSH si
        PUSH di
        PUSH cx
        PUSH bx
        textMode
        graphicMode
        frame 0000h 0010h
        LEA bx, orderingShellSortMsg
        CALL chainLength
        printGraphicMode orderingShellSortMsg 00h 00h cx
        getInfoCursor
        LEA bx, timeMsg
        CALL chainLength
        printGraphicMode timeMsg 00h dl cx
        graphBarReport2
        delay varDelay
        POP bx
        POP cx
        POP di
        POP si
        JMP while2

    postFor:
        INC ch
        JMP for

    beforeCheckingWhile:
        MOV ah, 00h
        MOV al, leap
        MOV cl, 02h
        DIV cl
        MOV leap, al
        JMP while
    
    exitMacro:
endm

;----------------------METODO DE ORDENAMIENTO SHELL ASCENDENTE
shellSortAscending macro array ;-------------------------ch = i,  bh = j   bl = k
    LOCAL while, enterCycle, for, enterFor, while2, enterWhile2, meetsCondition, exchange, postFor, beforeCheckingWhile, exitMacro

    while:
        CMP leap, 00h
        JA enterCycle
        JMP exitMacro
    
    enterCycle:
        MOV ch, leap
    
    for:
        CMP ch, pivotNumber
        JL enterFor
        JMP beforeCheckingWhile

    enterFor:
        MOV bh, ch
        SUB bh, leap
    
    while2:
        CMP bh, 00h
        JGE enterWhile2
        JMP postFor

    enterWhile2:
        setPointer array bh
        MOV si, startNumberDirection
        MOV bl, bh
        ADD bl, leap
        setPointerFinal array bl
        MOV di, finalNumberDirection
        MOV ah, [si]
        INC si
        MOV al, [si]
        AAD
        DEC si
        MOV scoreFromArray1, al
        MOV al, [di]
        DEC di
        MOV ah, [di]
        AAD
        INC di
        CMP scoreFromArray1, al
        JLE meetsCondition
        JMP exchange

    meetsCondition:
        MOV bh, 0FFh
        JMP while2

    exchange:
        DEC di
        MOV al, [di]
        MOV [si], al
        INC di
        INC si
        MOV al, [di]
        MOV [si], al
        DEC di
        MOV al, scoreFromArray1
        AAM
        MOV [di], ah
        INC di
        MOV [di], al
        DEC si
        SUB bh, leap
        PUSH si
        PUSH di
        PUSH cx
        PUSH bx
        textMode
        graphicMode
        frame 0000h 0010h
        LEA bx, orderingShellSortMsg
        CALL chainLength
        printGraphicMode orderingShellSortMsg 00h 00h cx
        getInfoCursor
        LEA bx, timeMsg
        CALL chainLength
        printGraphicMode timeMsg 00h dl cx
        graphBarReport2
        delay varDelay
        POP bx
        POP cx
        POP di
        POP si
        JMP while2

    postFor:
        INC ch
        JMP for

    beforeCheckingWhile:
        MOV ah, 00h
        MOV al, leap
        MOV cl, 02h
        DIV cl
        MOV leap, al
        JMP while
    
    exitMacro:
endm

;-----------------------ORDENAR ARRAY POR MAYOR TIEMPO
dottedOrderTimes macro
    LOCAL arrayPath, vacuumComparison, cycleIn, vacuumComparisonCycleIn, preStartCycleY, startCycleY, fillOutName, memoryExchange, memoryExchange2, increaseCycleOne, getOutBigPicture
    MOV bl, 00h
    MOV bh, 00h
    LEA di, usersWithTimes
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
        ADD si, 000Ch
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
        MOV al, [si]
        MOV hundredthNumber, al
        INC si
        MOV al, [si]
        MOV tenthNumber, al
        INC si
        MOV al, [si]
        MOV unitNumber, al
        form3DigitNumber hundredthNumber, tenthNumber, unitNumber
        MOV ax, numberWord
        MOV timeFromArray2, ax
        ADD di, 09h
        MOV al, [di]
        MOV hundredthNumber, al
        INC di
        MOV al, [di]
        MOV tenthNumber, al
        INC di
        MOV al, [di]
        MOV unitNumber, al
        form3DigitNumber hundredthNumber, tenthNumber, unitNumber
        MOV ax, numberWord
        MOV timeFromArray1, ax
        SUB si, 000Bh
        SUB di, 000Bh
    
    startCycleY:
        MOV ax, timeFromArray1
        CMP ax, timeFromArray2
        JNAE stt1
        JMP cycleIn

    stt1:
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
        MOV cx, 000Ch
        POP si

    memoryExchange:
        MOV al, [si]
        MOV [di], al
        INC si
        INC di
        LOOP memoryExchange
        SUB di, 000Ch
        SUB si, 000Ch
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
        separate3DigitNumber timeFromArray1
        INC si
        MOV al, hundredthNumber
        MOV [si], al
        INC si
        MOV al, tenthNumber
        MOV [si], al
        INC si
        MOV al, unitNumber
        MOV [si], al
        POP di
        SUB si, 000Bh
        JMP cycleIn


    increaseCycleOne:
        INC bl
        ADD di, 000Ch
        MOV si, di
        MOV bh, bl
        JMP arrayPath
    
    getOutBigPicture:
endm

;---------------------SEPARA UN NUMERO DE 3 CIFRAS   SUPONGAMOS 600   C= 6 D= 0 U = 0
;---------------------DEVUELVE EN  c = hundrethnumber, d = tenthNUmber,  u = unitNumber
separate3DigitNumber macro number
    PUSH ax
    PUSH dx
    PUSH bx
    MOV ax, number
    MOV dx, 0000h
    MOV bx, 000Ah
    DIV bx
    MOV unitNumber, dl
    AAM
    MOV hundredthNumber, ah
    MOV tenthNumber, al
    POP bx
    POP dx
    POP ax
endm


;-------------------UNIR 3 NUMEROS EN UN NUMERO DE 3 DIGITOS MAYOR A 255
form3DigitNumber macro c, d, u
    PUSH ax
    PUSH bx
    MOV al, c
    MOV bl, 64h
    MUL bl
    MOV numberWord, ax
    MOV al, d
    MOV bl, 0Ah
    MUL bl
    ADD numberWord, ax
    MOV al, u
    MOV ah, 00h
    ADD numberWord, ax
    POP bx
    POP ax
endm

;---------------------LLENA EL ARRAY UNICAMENTE DE TIEMPOS PARA LA GRAFICACION DE LAS BARRAS
fillTimeArray macro array
    LOCAL newUserLine, comparisonThereUser, insertUser, finishFilling
    LEA si, readTxt
    LEA di, timeArray
    MOV bx, 0000h

    newUserLine:
        ADD si, 0013h
        ADD bx, 0013h
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
        SUB al, 30h
        MOV [di], al
        INC si
        INC bx
        INC di
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
        JMP newUserLine

    finishFilling:
endm

;-------------------------GRAFICAR BARRAS DE TIEMPOS
graphBarReportTimes macro array, barH
    LOCAL totalBarComparison, finishBarReport, continueBar
    MOV bx, 0000h
    LEA si, array
    MOV coordenateXVideoMode, 0012h
    MOV coordenateXCursor, 16h

    totalBarComparison:
        CMP bx, barTotal
        JNE continueBar
        JMP finishBarReport

    continueBar:
        MOV al, [si]
        MOV hundredthNumber, al
        INC si
        MOV al, [si]
        MOV tenthNumber, al
        INC si
        MOV al, [si]
        MOV unitNumber, al
        form3DigitNumber hundredthNumber tenthNumber unitNumber
        calculateBarHeight2 barH
        setBarColor numberWord
        MOV cx, coordenateXVideoMode
        MOV initialPosition, cx
        plotBar colorBar, barWidth, barHeigth
        MOV cx, coordenateXVideoMode
        MOV finalPosition, cx
        calculateBarNumberPosition
        ADD hundredthNumber, 30h
        ADD tenthNumber, 30h
        ADD unitNumber, 30h
        printCharacterVideoMode hundredthNumber
        printCharacterVideoMode tenthNumber
        printCharacterVideoMode unitNumber
        ADD coordenateXVideoMode, 0008h
        INC si
        ADD coordenateYCursor, 04h
        INC bx
        JMP totalBarComparison
    
    finishBarReport:
endm

;-------------------ORDENAMIENTO BURBUJA DESCENDENTE PARA LOS TIEMPOS
bubbleDescendingTimes macro array
    LOCAL arrayPath, vacuumComparison, cycleIn, vacuumComparisonCycleIn, preStartCycleY, startCycleY, memoryExchange, increaseCycleOne, getOutBigPicture
    MOV bl, 00h
    MOV bh, 00h
    LEA di, array
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
        ADD si, 0003h
        CMP bh, 14h
        JNE vacuumComparisonCycleIn
        JMP increaseCycleOne
    
    vacuumComparisonCycleIn:
        MOV al, [si]
        CMP al, 20h
        JNE preStartCycleY
        JMP increaseCycleOne 

    preStartCycleY:
        MOV al, [si]
        MOV hundredthNumber, al
        INC si
        MOV al, [si]
        MOV tenthNumber, al
        INC si
        MOV al, [si]
        MOV unitNumber, al
        form3DigitNumber hundredthNumber, tenthNumber, unitNumber
        MOV ax, numberWord
        MOV timeFromArray2, ax
        MOV al, [di]
        MOV hundredthNumber, al
        INC di
        MOV al, [di]
        MOV tenthNumber, al
        INC di
        MOV al, [di]
        MOV unitNumber, al
        form3DigitNumber hundredthNumber, tenthNumber, unitNumber
        MOV ax, numberWord
        MOV timeFromArray1, ax
        SUB si, 0002h
        SUB di, 0002h
    
    startCycleY:
        MOV ax, timeFromArray1
        CMP ax, timeFromArray2
        JNAE memoryExchange
        JMP cycleIn

    memoryExchange:
        MOV al, [si]
        MOV [di], al
        INC si
        INC di
        MOV al, [si]
        MOV [di], al
        INC si
        INC di
        MOV al, [si]
        MOV [di], al
        SUB di, 0002h
        SUB si, 0002h
        separate3DigitNumber timeFromArray1
        MOV al, hundredthNumber
        MOV [si], al
        INC si
        MOV al, tenthNumber
        MOV [si], al
        INC si
        MOV al, unitNumber
        MOV [si], al
        SUB si, 0002h
        PUSH bx
        PUSH si
        PUSH di
        textMode
        graphicMode
        frame 0000h 0010h
        LEA bx, orderingBubbleSortMsg
        CALL chainLength
        printGraphicMode orderingBubbleSortMsg 00h 00h cx
        getInfoCursor
        LEA bx, timeMsg
        CALL chainLength
        printGraphicMode timeMsg 00h dl cx
        graphBarReportTimes array 8Eh
        delay varDelay
        POP di
        POP si
        POP bx
        JMP cycleIn

    increaseCycleOne:
        INC bl
        ADD di, 0003h
        MOV si, di
        MOV bh, bl
        JMP arrayPath
    
    getOutBigPicture:
endm

;-------------------ORDENAMIENTO BURBUJA ASCENDENTE PARA LOS TIEMPOS
bubbleAscendingTimes macro array
    LOCAL arrayPath, vacuumComparison, cycleIn, vacuumComparisonCycleIn, preStartCycleY, startCycleY, memoryExchange, increaseCycleOne, getOutBigPicture
    MOV bl, 00h
    MOV bh, 00h
    LEA di, array
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
        ADD si, 0003h
        CMP bh, 14h
        JNE vacuumComparisonCycleIn
        JMP increaseCycleOne
    
    vacuumComparisonCycleIn:
        MOV al, [si]
        CMP al, 20h
        JNE preStartCycleY
        JMP increaseCycleOne 

    preStartCycleY:
        MOV al, [si]
        MOV hundredthNumber, al
        INC si
        MOV al, [si]
        MOV tenthNumber, al
        INC si
        MOV al, [si]
        MOV unitNumber, al
        form3DigitNumber hundredthNumber, tenthNumber, unitNumber
        MOV ax, numberWord
        MOV timeFromArray2, ax
        MOV al, [di]
        MOV hundredthNumber, al
        INC di
        MOV al, [di]
        MOV tenthNumber, al
        INC di
        MOV al, [di]
        MOV unitNumber, al
        form3DigitNumber hundredthNumber, tenthNumber, unitNumber
        MOV ax, numberWord
        MOV timeFromArray1, ax
        SUB si, 0002h
        SUB di, 0002h
    
    startCycleY:
        MOV ax, timeFromArray1
        CMP ax, timeFromArray2
        JNBE memoryExchange
        JMP cycleIn

    memoryExchange:
        MOV al, [si]
        MOV [di], al
        INC si
        INC di
        MOV al, [si]
        MOV [di], al
        INC si
        INC di
        MOV al, [si]
        MOV [di], al
        SUB di, 0002h
        SUB si, 0002h
        separate3DigitNumber timeFromArray1
        MOV al, hundredthNumber
        MOV [si], al
        INC si
        MOV al, tenthNumber
        MOV [si], al
        INC si
        MOV al, unitNumber
        MOV [si], al
        SUB si, 0002h
        PUSH bx
        PUSH si
        PUSH di
        textMode
        graphicMode
        frame 0000h 0010h
        LEA bx, orderingBubbleSortMsg
        CALL chainLength
        printGraphicMode orderingBubbleSortMsg 00h 00h cx
        getInfoCursor
        LEA bx, timeMsg
        CALL chainLength
        printGraphicMode timeMsg 00h dl cx
        graphBarReportTimes array 8Eh
        delay varDelay
        POP di
        POP si
        POP bx
        JMP cycleIn

    increaseCycleOne:
        INC bl
        ADD di, 0003h
        MOV si, di
        MOV bh, bl
        JMP arrayPath
    
    getOutBigPicture:
endm


;----------------------METODO DE ORDENAMIENTO SHELL DESCENDENTE PARA TIEMPOS
shellSortDescendingTime macro array ;-------------------------ch = i,  bh = j   bl = k
    LOCAL while, enterCycle, for, enterFor, while2, enterWhile2, meetsCondition, exchange, postFor, beforeCheckingWhile, exitMacro

    while:
        CMP leap, 00h
        JA enterCycle
        JMP exitMacro
    
    enterCycle:
        MOV ch, leap
    
    for:
        CMP ch, pivotNumber
        JL enterFor
        JMP beforeCheckingWhile

    enterFor:
        MOV bh, ch
        SUB bh, leap
    
    while2:
        CMP bh, 00h
        JGE enterWhile2
        JMP postFor

    enterWhile2:
        setPointerTime array bh
        MOV si, startNumberDirection
        MOV bl, bh
        ADD bl, leap
        setPointerFinalTime array bl
        MOV di, finalNumberDirection
        MOV al, [si]
        MOV hundredthNumber, al
        INC si
        MOV al, [si]
        MOV tenthNumber, al
        INC si
        MOV al, [si]
        MOV unitNumber, al
        form3DigitNumber hundredthNumber tenthNumber unitNumber
        SUB si, 0002h
        MOV ax, numberWord
        MOV pivotNumberTime, ax
        MOV al, [di]
        MOV hundredthNumber, al
        INC di
        MOV al, [di]
        MOV tenthNumber, al
        INC di
        MOV al, [di]
        MOV unitNumber, al
        SUB di, 0002h
        form3DigitNumber hundredthNumber tenthNumber unitNumber
        MOV ax, pivotNumberTime
        CMP ax, numberWord
        JAE meetsCondition
        JMP exchange

    meetsCondition:
        MOV bh, 0FFh
        JMP while2

    exchange:
        MOV al, [si]
        MOV [di], al
        INC di
        INC si
        MOV al, [si]
        MOV [di], al
        INC di
        INC si
        MOV al, [si]
        MOV [di], al
        SUB si, 0002h
        MOV al, hundredthNumber
        MOV [si], al
        INC si
        MOV al, tenthNumber
        MOV [si], al
        INC si
        MOV al, unitNumber
        MOV [si], al
        SUB si, 0002h
        SUB di, 0002h
        SUB bh, leap
        PUSH si
        PUSH di
        PUSH cx
        PUSH bx
        textMode
        graphicMode
        frame 0000h 0010h
        LEA bx, orderingShellSortMsg
        CALL chainLength
        printGraphicMode orderingShellSortMsg 00h 00h cx
        getInfoCursor
        LEA bx, timeMsg
        CALL chainLength
        printGraphicMode timeMsg 00h dl cx
        graphBarReportTimes array 8Eh
        delay varDelay
        POP bx
        POP cx
        POP di
        POP si
        JMP while2

    postFor:
        INC ch
        JMP for

    beforeCheckingWhile:
        MOV ah, 00h
        MOV al, leap
        MOV cl, 02h
        DIV cl
        MOV leap, al
        JMP while
    
    exitMacro:
endm


;----------------------METODO DE ORDENAMIENTO SHELL ASCENDENTE PARA TIEMPOS
shellSortAscendingTime macro array ;-------------------------ch = i,  bh = j   bl = k
    LOCAL while, enterCycle, for, enterFor, while2, enterWhile2, meetsCondition, exchange, postFor, beforeCheckingWhile, exitMacro

    while:
        CMP leap, 00h
        JA enterCycle
        JMP exitMacro
    
    enterCycle:
        MOV ch, leap
    
    for:
        CMP ch, pivotNumber
        JL enterFor
        JMP beforeCheckingWhile

    enterFor:
        MOV bh, ch
        SUB bh, leap
    
    while2:
        CMP bh, 00h
        JGE enterWhile2
        JMP postFor

    enterWhile2:
        setPointerTime array bh
        MOV si, startNumberDirection
        MOV bl, bh
        ADD bl, leap
        setPointerFinalTime array bl
        MOV di, finalNumberDirection
        MOV al, [si]
        MOV hundredthNumber, al
        INC si
        MOV al, [si]
        MOV tenthNumber, al
        INC si
        MOV al, [si]
        MOV unitNumber, al
        form3DigitNumber hundredthNumber tenthNumber unitNumber
        SUB si, 0002h
        MOV ax, numberWord
        MOV pivotNumberTime, ax
        MOV al, [di]
        MOV hundredthNumber, al
        INC di
        MOV al, [di]
        MOV tenthNumber, al
        INC di
        MOV al, [di]
        MOV unitNumber, al
        SUB di, 0002h
        form3DigitNumber hundredthNumber tenthNumber unitNumber
        MOV ax, pivotNumberTime
        CMP ax, numberWord
        JBE meetsCondition
        JMP exchange

    meetsCondition:
        MOV bh, 0FFh
        JMP while2

    exchange:
        MOV al, [si]
        MOV [di], al
        INC di
        INC si
        MOV al, [si]
        MOV [di], al
        INC di
        INC si
        MOV al, [si]
        MOV [di], al
        SUB si, 0002h
        MOV al, hundredthNumber
        MOV [si], al
        INC si
        MOV al, tenthNumber
        MOV [si], al
        INC si
        MOV al, unitNumber
        MOV [si], al
        SUB si, 0002h
        SUB di, 0002h
        SUB bh, leap
        PUSH si
        PUSH di
        PUSH cx
        PUSH bx
        textMode
        graphicMode
        frame 0000h 0010h
        LEA bx, orderingShellSortMsg
        CALL chainLength
        printGraphicMode orderingShellSortMsg 00h 00h cx
        getInfoCursor
        LEA bx, timeMsg
        CALL chainLength
        printGraphicMode timeMsg 00h dl cx
        graphBarReportTimes array 8Eh
        delay varDelay
        POP bx
        POP cx
        POP di
        POP si
        JMP while2

    postFor:
        INC ch
        JMP for

    beforeCheckingWhile:
        MOV ah, 00h
        MOV al, leap
        MOV cl, 02h
        DIV cl
        MOV leap, al
        JMP while
    
    exitMacro:
endm