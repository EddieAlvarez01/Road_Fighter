include c:\MASM\road\macros.asm
.model small
.stack 200h
.data

;--------------------------ENCABEZADO
university db 10, 10, 13, "UNIVERSIDAD DE SAN CARLOS DE GUATEMALA", "$"
faculty db 10, 13, "FACULTAD DE INGENIERIA", "$"
school db 10, 13, "CIENCIAS Y SISTEMAS", "$"
course db 10, 13, "ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1", "$"
studentName db 10, 13, "NOMBRE: EDDIE AUGUSTO ALVAREZ SALAZAR", "$"
card db 10, 13, "201700326", "$"
section db 10, 13, "SECCION: A", "$"

;--------------------------MENU ADMIN
menuAdminOption1 db 10, 10, 13, "1) Top 10 puntos", "$"
menuAdminOption2 db 10, 13, "2) Top 10 tiempos", "$"
menuAdminOption3 db 10, 13, "3) Salir", 10, 13, "$"

;--------------------------MENU GENERAL
option1 db 10, 10, 13, "1) Ingresar", "$"
option2 db 10, 13, "2) Registrar", "$"
option3 db 10, 13, "3) Salir", 10, 13, "$"

;--------------------------MENU USUARIO
menuUserOption1 db 10, 10, 13, "1) Iniciar Juego", "$"
menuUserOption2 db 10, 13, "2) Cargar Juego", "$"
menuUserOption3 db 10, 13, "3) Salir", 10, 13, "$"

;------------------------MENU ORDENAMIENTOS
ordinationOption1 db 10, 13, "1) Ordenamiento BubbleSort", "$"
ordinationOption2 db 10, 13, "2) Ordenamiento QuickSort", "$"
ordinationOption3 db 10, 13, "3) Ordenamiento ShellSort", 10, 13, "$"

;-------------------------VARIABLES GENERALES
top10PtsArray db 110 dup(" "), "$"
usersAvailablePoints db 220 dup(" "), "$"
usersWithTimes db 240 dup(" "), "$"
timeArray db 60 dup(" "), "$"

scoreFromArray1 db 00
scoreFromArray2 db 00

timeFromArray2 dw 0000
timeFromArray1 dw 0000

usernameFromArray db 7 dup(" "), "$"
levelFromArray db 00
barWidth dw 0000
barHeigth dw 0000

downwardTravel dw 0000
barTotal dw 0000
coordenateXVideoMode dw 0000
coordenateYVideoMode dw 0000

coordenateXCursor db 00
coordenateYCursor db 00

maximunScore db 00
colorBar db 00

initialPosition dw 0000
finalPosition dw 0000

hundredthNumber db 00
tenthNumber db 00
unitNumber db 00

sortingSpeed db 00

typeOfSystem db 00

orderingStyle db 00

varDelay dw 0000

pivotNumber db 00
pivotNumberTime dw 0000
startNumberDirection dw 0000
finalIndex db 00
finalNumberDirection dw 0000

leap db 00

numberWord dw 0000
maximunTime dw 0000

levelTime db 3 dup(0), "$"
obstacleTime db 3 dup(0), "$"
awardTime db 3 dup(0), "$"
obstaclePoints db 2 dup(0), "$"
awardPoints db 2 dup(0), "$"

nameLevel1 db 6 dup(0), "$"
timeLevel1 dw 0000
obstacleTimeLevel1 dw 0000
awardTimeLevel1 dw 0000
obstaclePointsLevel1 dw 0000
awardPointsLevel1 dw 0000
colorLevel1 db 6 dup(" "), "$"

nameLevel2 db 6 dup(0), "$"
timeLevel2 dw 0000
obstacleTimeLevel2 dw 0000
awardTimeLevel2 dw 0000
obstaclePointsLevel2 dw 0000
awardPointsLevel2 dw 0000
colorLevel2 db 6 dup(" "), "$"

nameLevel3 db 6 dup(0), "$"
timeLevel3 dw 0000
obstacleTimeLevel3 dw 0000
awardTimeLevel3 dw 0000
obstaclePointsLevel3 dw 0000
awardPointsLevel3 dw 0000
colorLevel3 db 6 dup(" "), "$"

nameLevel4 db 6 dup(0), "$"
timeLevel4 dw 0000
obstacleTimeLevel4 dw 0000
awardTimeLevel4 dw 0000
obstaclePointsLevel4 dw 0000
awardPointsLevel4 dw 0000
colorLevel4 db 6 dup(" "), "$"

nameLevel5 db 6 dup(0), "$"
timeLevel5 dw 0000
obstacleTimeLevel5 dw 0000
awardTimeLevel5 dw 0000
obstaclePointsLevel5 dw 0000
awardPointsLevel5 dw 0000
colorLevel5 db 6 dup(" "), "$"

nameLevel6 db 6 dup(0), "$"
timeLevel6 dw 0000
obstacleTimeLevel6 dw 0000
awardTimeLevel6 dw 0000
obstaclePointsLevel6 dw 0000
awardPointsLevel6 dw 0000
colorLevel6 db 6 dup(" "), "$"

nameFileLoad db 20 dup(0), "$"
readGameLoad db 234 dup (" "), "$"

validDigits db 00

startPositionLevelNamePointer dw 0000
vehiculeColor dw 0000

timeVariable dw 0000
displayTime dw 0000
iCart dw 0000
jCart dw 0000
cartVelocity dw 000Ah
currentColor dw 0000
currentLevel db 00
currentTimeLevel dw 0000


;----------------------COMPARACION DE COLORES
redWord db "rojo  ", "$"
greenWord db "verde ", "$"
blueWord db "azul  ", "$"
whiteWord db "blanco", "$"

;--------------------------VARIABLES PARA VERIFICACION DE USUARIOS
usernameMsg db 10, 10, 13, "Nombre de usuario: ", "$"
passwordMsg db 10, 13, "Contrasena: ", "$"
username db 7 dup(" "), "$"
password db 4 dup(" "), "$"
defaultUser db "admin", "$"
defaultPassword db "1234", "$"
point db ".", "$"
numberForWrite db 00 

;--------------------------MENSAJES DEL SISTEMA
pressAKeyMsg db 10, 13, "Presiona una tecla para continuar....", "$"
registeredUserMsg db 10, 13, "Usuario registrado correctamente", "$"
pressSpaceForContinue db 10, 13, "Presiona espacio para continuar..", "$"
fileMessageReadSuccessfully db 10, 13, "Archivo leido exitosamente", "$"

orderingBubbleSortMsg db "ORDENAMIENTO: BUBBLESORT ", "$"
orderingQuickSortMsg db "ORDENAMIENTO: QUICKSORT ", "$"
orderingShellSortMsg db "ORDENAMIENTO: SHELLSORT ", "$"

timeMsg db "TIEMPO: 00:00  ", "$"

punctuationMsg db "03", "$"
timeGameMsg db "00:00", "$"

speedMsg db "VELOCIDAD: ", "$"

speedInputMsg db 10, 10, 13, "INGRESE UNA VELOCIDAD (0-9)", 10, 13, "$"

enterFileNameMsg db 10, 10, 13, "Ingrese el nombre del archivo a cargar: ", "$" 

;-------------------------MENU DE TIPO DE ORDENADO
upwardOption db 10, 10, 13, "1) Descendente", "$"
topDownOption db 10, 13, "2) Ascendente", 10, 13, "$"

;-------------------------MENSAJES DE ERROR
passwordErrorIncorrectSyntax db 10, 10, 13, "Error la contrasena debe ser de 4 numeros unicamente", "$"
errorOpeningFileMsg db 10, 10, 13, "Error al leer el archivo", "$"
fileCreationErrorMsg db 10, 10, 13, "Error no se puede crear el archivo", "$"
fseekErrorMsg db 10, 10, 13, "Error no se puede desplazar el puntero", "$"
writeFileErrorMsg db 10, 10, 13, "Error no se puede escribir en archivo", "$"
authenticationMsg db 10, 10, 13, "Error contrasena o usuario incorrecto", "$"
equalUsersMsg db 10, 10, 13, "Error el usuario ya esta registrado", "$"
emptyArrayMsg db 10, 10, 13, "La lista de jugadores esta vacia, no se generara el reporte", "$"

;--------------------------VARIABLES DE MANEJO DE ARCHIVOS
handle dw ?
userFileName db "usr.txt", 00
pointsReportFileName db "Puntos.rep", 00
timesReportFileName db "tiempos.rep", 00
delimiter db 59, "$"
defaultLevel db "00", "$"
defaultScore db "00", "$"
defaultTime db "000", "$"
newLine db 10, "$" 
readTxt db 460 dup(" "), "$"
usernameFromFile db 7 dup(" "), "$"
passwordFromFile db 4 dup(" "), "$"

;-------------------------REPORTES
startDesign db 10, 10, 10, 13, "--------------------------------------------------------------------------------", "$"
finalDesign db 10, 13, "--------------------------------------------------------------------------------", "$"
top10TimesSign db 10, 13, "                                 Top 10 tiempos                                  ", "$"
top10Sign db 10, 13, "                                 Top 10 puntos                                  ", "$"
spaceBetweenNumberUser db "              ", "$"
nameLevelSpacing db "                       ", "$"
levelScoreSpacing db "                       ", "$"

.code
main proc
    MOV ax, @data
    MOV ds, ax

    ;----------------------------CREACION DE ARCHIVO DE USUARIOS
    ;createFile userFileName
    ;closeFile

    mainMenu:
        print option1
        print option2
        print option3
        readOption
        SUB al, 30h
        CMP al, 1
        JE jumpIn
        CMP al, 2
        JE skipRegistration 
    
    exit:
        MOV ax, 4C00h
        INT 21h
    
    jumpIn:
        clearUsernameMemory
        JMP login

    skipRegistration:
        clearUsernameMemory
        JMP register
    
    register:
        print usernameMsg
        readChain 7, username
        CALL clearUsername
        openFile userFileName 0h
        lseek 00h 0000 0000
        readFile 01CCh readTxt
        closeFile
        CALL checkRegistration
        print passwordMsg
        readChain 4, password
        CALL checkPassword
        openFile userFileName 1h
        lseek 02h 0 0
        writeFile 0007, username
        writeFile 0001, delimiter
        writeFile 0004, password
        writeFile 0001, delimiter
        writeFile 0002, defaultLevel
        writeFile 0001, delimiter
        writeFile 0002, defaultScore
        writeFile 0001, delimiter
        writeFile 0003, defaultTime
        writeFile 0001, newLine
        closeFile
        print registeredUserMsg
        print pressAKeyMsg
        readCharacterWithoutPrinting
        clearUsernameMemory
        JMP mainMenu

    login:
        print usernameMsg
        readChain 0007, username
        CALL clearUsername
        print passwordMsg
        readChain 0004, password
        openFile userFileName 0h
        lseek 00h 0000 0000
        readFile 01CCh readTxt
        closeFile
        CALL checkLogin
        CMP bl, 01h
        JE administrationMenu
        CMP bl, 02h
        JE userMenu
        JMP mainMenu
    
    administrationMenu:
        print university
        print faculty
        print school
        print course
        print studentName
        print card
        print section
        print menuAdminOption1
        print menuAdminOption2
        print menuAdminOption3
        readOption
        SUB al, 30h
        CMP al, 01h
        JE jumpTop10Points
        CMP al, 02h
        JE jumpTop10Times
        JMP mainMenu
    
    userMenu:
        print university
        print faculty
        print school
        print course
        print studentName
        print card
        print section
        print menuUserOption1
        print menuUserOption2
        print menuUserOption3
        readOption
        SUB al, 30h
        CMP al, 01h
        JE jumpPlay
        CMP al, 02h
        JE jumpLoadFile
        JMP mainMenu

    jumpTop10Points:
        JMP getTop10Points
    
    jumpTop10Times:
        JMP getTop10Times

    jumpPlay:
        JMP check

    jumpLoadFile:
        JMP loadFile
    
    check:
        LEA si, nameLevel1
        MOV al, [si]
        CMP al, 00h
        JNE playGame
        JMP userMenu

    playGame:
        MOV iCart, 009Ah   ;CENTRAR
        MOV jCart, 008Ch    ; EL CARRO
        MOV currentLevel, 01h       ;EMPEZAR DESDE EL NIVEL 1
        MOV ax, timeLevel1
        MOV currentTimeLevel, ax
        updateCartColor colorLevel1     ;ASIGNAR EL COLOR DEL CARRO
    
    launchLevel1:
        getSystemTime   ;TRAER TIEMPO DEL SISTEMA
        MOV al, dl      
        MOV ah, 00h
        CMP ax, timeVariable
        JE launchLevel1
        MOV timeVariable, ax
        CMP timeVariable, 0032h
        JE increaseDisplayTime
        JMP keepGoing

    increaseDisplayTime:
        INC displayTime
        MOV ax, currentTimeLevel
        CMP displayTime, ax
        JNE keepGoing
        JMP preStartLevel2
    
    keepGoing:
        graphicMode     ;ENTRAR AL MODO GRAFICO
        printGameHeader displayTime nameLevel1    ;IMPRMIR CABECERA DEL JUEGO
        printFrame          ;IMPRIMIR MARCO
        detectCarMovement       ;VERIFICA SI SE PRESIONARON LAS FLECHAS PARA MOVER
        drawCart iCart jCart 0028h 0028h currentColor   ;DIBUJAR CARRO
        JMP launchLevel1

    check2:
        LEA si, nameLevel2
        MOV al, [si]
        CMP al, 00h
        JNE preStartLevel2
        JMP endUpSplitting
    
    preStartLevel2:
        updateCartColor colorLevel2
        MOV ax, timeLevel2
        ADD currentTimeLevel, ax
        MOV timeVariable, 0000h

    launchLevel2:
        getSystemTime
        MOV al, dl
        MOV ah, 00h
        CMP ax, timeVariable
        JE launchLevel2
        MOV timeVariable, ax
        CMP timeVariable, 0032h
        JE increaseDisplayTime2
        JMP keepGoing2
    
    increaseDisplayTime2:
        INC displayTime
        MOV ax, currentTimeLevel
        CMP displayTime, ax
        JNE keepGoing2
        JMP check3

    keepGoing2:
        graphicMode
        printGameHeader displayTime nameLevel2
        printFrame
        detectCarMovement
        drawCart iCart jCart 0028h 0028h currentColor   ;DIBUJAR CARRO
        JMP launchLevel2

    check3:
        LEA si, nameLevel3
        MOV al, [si]
        CMP al, 00h
        JNE preStartLevel3
        JMP endUpSplitting

    preStartLevel3:
        updateCartColor colorLevel3
        MOV ax, timeLevel3
        ADD currentTimeLevel, ax
        MOV timeVariable, 0000h
    
    launchLevel3:
        getSystemTime
        MOV al, dl
        MOV ah, 00h
        CMP ax, timeVariable
        JE launchLevel3
        MOV timeVariable, ax
        CMP timeVariable, 0032h
        JE increaseDisplayTime3
        JMP keepGoing3
    
    increaseDisplayTime3:
        INC displayTime
        MOV ax, currentTimeLevel
        CMP displayTime, ax
        JNE keepGoing3
        JMP check4

    keepGoing3:
        graphicMode
        printGameHeader displayTime nameLevel3
        printFrame
        detectCarMovement
        drawCart iCart jCart 0028h 0028h currentColor   ;DIBUJAR CARRO
        JMP launchLevel3

    check4:
        LEA si, nameLevel4
        MOV al, [si]
        CMP al, 00h
        JNE preStartLevel4
        JMP endUpSplitting

    preStartLevel4:
        updateCartColor colorLevel4
        MOV ax, timeLevel3
        ADD currentTimeLevel, ax
        MOV timeVariable, 0000h
    
    launchLevel4:
        getSystemTime
        MOV al, dl
        MOV ah, 00h
        CMP ax, timeVariable
        JE launchLevel4
        MOV timeVariable, ax
        CMP timeVariable, 0032h
        JE increaseDisplayTime4
        JMP keepGoing4
    
    increaseDisplayTime4:
        INC displayTime
        MOV ax, currentTimeLevel
        CMP displayTime, ax
        JNE keepGoing4
        JMP check5

    keepGoing4:
        graphicMode
        printGameHeader displayTime nameLevel4
        printFrame
        detectCarMovement
        drawCart iCart jCart 0028h 0028h currentColor   ;DIBUJAR CARRO
        JMP launchLevel4

    check5:
        LEA si, nameLevel5
        MOV al, [si]
        CMP al, 00h
        JNE preStartLevel5
        JMP endUpSplitting

    preStartLevel5:
        updateCartColor colorLevel5
        MOV ax, timeLevel3
        ADD currentTimeLevel, ax
        MOV timeVariable, 0000h
    
    launchLevel5:
        getSystemTime
        MOV al, dl
        MOV ah, 00h
        CMP ax, timeVariable
        JE launchLevel5
        MOV timeVariable, ax
        CMP timeVariable, 0032h
        JE increaseDisplayTime5
        JMP keepGoing5

    increaseDisplayTime5:
        INC displayTime
        MOV ax, currentTimeLevel
        CMP displayTime, ax
        JNE keepGoing5
        JMP check6

    keepGoing5:
        graphicMode
        printGameHeader displayTime nameLevel5
        printFrame
        detectCarMovement
        drawCart iCart jCart 0028h 0028h currentColor   ;DIBUJAR CARRO
        JMP launchLevel5

    check6:
        LEA si, nameLevel6
        MOV al, [si]
        CMP al, 00h
        JNE preStartLevel6
        JMP endUpSplitting
    
    preStartLevel6:
        updateCartColor colorLevel6
        MOV ax, timeLevel3
        ADD currentTimeLevel, ax
        MOV timeVariable, 0000h
    
    launchLevel6:
        getSystemTime
        MOV al, dl
        MOV ah, 00h
        CMP ax, timeVariable
        JE launchLevel6
        MOV timeVariable, ax
        CMP timeVariable, 0032h
        JE increaseDisplayTime6
        JMP keepGoing6

    increaseDisplayTime6:
        INC displayTime
        MOV ax, currentTimeLevel
        CMP displayTime, ax
        JNE keepGoing6
        JMP endUpSplitting

    keepGoing6:
        graphicMode
        printGameHeader displayTime nameLevel6
        printFrame
        detectCarMovement
        drawCart iCart jCart 0028h 0028h currentColor   ;DIBUJAR CARRO
        JMP launchLevel6

    endUpSplitting:
        textMode
        MOV currentTimeLevel, 0000h
        MOV timeVariable, 0000h
        MOV displayTime, 0000h
        JMP userMenu

    loadFile:
        print enterFileNameMsg
        readChain 0014h nameFileLoad    ;LEER UNA CADENA PARA EL NOMBRE DEL ARCHIVO A CARGAR
        chainClean 0014h nameFileLoad   ;LIMPIAR LA CADENA LEIDA DE LOS SALTOS DE LINEA Y RETORNOS DE CARRO
        openFile nameFileLoad 00h       ;ABRIMOS EL ARCHIVO
        readFile 00EAh readGameLoad     ;LEER EL CONTENIDO
        closeFile         ;CERRAR EL ARCHIVO
        variableCleaner 0006h nameLevel1 00h
        variableCleaner 0006h nameLevel2 00h
        variableCleaner 0006h nameLevel3 00h
        variableCleaner 0006h nameLevel4 00h
        variableCleaner 0006h nameLevel5 00h
        variableCleaner 0006h nameLevel6 00h
        variableCleaner 0006h colorLevel1 20h
        variableCleaner 0006h colorLevel2 20h
        variableCleaner 0006h colorLevel3 20h
        variableCleaner 0006h colorLevel4 20h
        variableCleaner 0006h colorLevel5 20h
        variableCleaner 0006h colorLevel6 20h
        MOV timeLevel1, 0000h
        MOV timeLevel2, 0000h
        MOV timeLevel3, 0000h
        MOV timeLevel4, 0000h
        MOV timeLevel5, 0000h
        MOV timeLevel6, 0000h
        MOV obstacleTimeLevel1, 0000h
        MOV obstacleTimeLevel2, 0000h
        MOV obstacleTimeLevel3, 0000h
        MOV obstacleTimeLevel4, 0000h
        MOV obstacleTimeLevel5, 0000h
        MOV obstacleTimeLevel6, 0000h
        MOV awardTimeLevel1, 0000h
        MOV awardTimeLevel2, 0000h
        MOV awardTimeLevel3, 0000h
        MOV awardTimeLevel4, 0000h
        MOV awardTimeLevel5, 0000h
        MOV awardTimeLevel6, 0000h
        MOV obstaclePointsLevel1, 0000h
        MOV obstaclePointsLevel2, 0000h
        MOV obstaclePointsLevel3, 0000h
        MOV obstaclePointsLevel4, 0000h
        MOV obstaclePointsLevel5, 0000h
        MOV obstaclePointsLevel6, 0000h
        MOV awardPointsLevel1, 0000h
        MOV awardPointsLevel2, 0000h
        MOV awardPointsLevel3, 0000h
        MOV awardPointsLevel4, 0000h
        MOV awardPointsLevel5, 0000h
        MOV awardPointsLevel6, 0000h
        loadLevels        ;DEL STRING LEIDO CARGAR A LOS RESPECTIVOS NIVELES
        print fileMessageReadSuccessfully
        JMP userMenu

    getTop10Points:
        openFile userFileName 0h
        lseek 00h 0000 0000
        readFile 01CCh readTxt
        closeFile
        putUsersArray
        countArrayElements 
        CMP cl, 00h
        JA report
        JMP showErrorEmptyArray
    
    report:
        createFile pointsReportFileName
        dottedOrder
        openFile pointsReportFileName 01h
        print startDesign
        LEA bx, startDesign
        CALL chainLength
        writeFile cx, startDesign
        print top10Sign
        LEA bx, top10Sign
        CALL chainLength
        writeFile cx, top10Sign
        top10Printing
        print finalDesign
        LEA bx, finalDesign
        CALL chainLength
        writeFile cx, finalDesign
        closeFile
        print pressSpaceForContinue
    
    checkKey:
        getKey
        CMP ah, 39h
        JNE checkKey 
        JMP barCalculation
    
    barCalculation:
        countArrayElements
        MOV ch, 00h
        MOV barTotal, cx
        DEC cl
        barWidthCalculation cl
        getTopScore
        saveItemsVideoMode
        graphicMode
        retrieveItemsVideoMode
        frame 0000h 0000h
        putUsersArray
        graphBarReport
        readCharacterVideoMode
        textMode
    
    ordersMenu:
        print ordinationOption1
        print ordinationOption2
        print ordinationOption3
        readOption
        SUB al, 30h
        CMP al, 01h
        JE jumpToBubbleSort
        CMP al, 02h
        JE jumpToQuickSort
        CMP al, 03h
        JE jumpToShellSort
        JMP jumpToBubbleSort

    jumpToBubbleSort:
        print speedInputMsg
        readOption
        SUB al, 30h
        MOV sortingSpeed, al
        JMP bubbleSort
    
    jumpToQuickSort:
        print speedInputMsg
        readOption
        SUB al, 30h
        MOV sortingSpeed, al
        JMP quickSort

    jumpToShellSort:
        print speedInputMsg
        readOption
        SUB al, 30h
        MOV sortingSpeed, al
        JMP shellSort

    bubbleSort:
        MOV orderingStyle, 01h
        print upwardOption
        print topDownOption
        readOption
        SUB al, 30h
        MOV typeOfSystem, al
        graphicMode
        LEA bx, orderingBubbleSortMsg
        CALL chainLength
        printGraphicMode orderingBubbleSortMsg 00h 00h cx
        JMP generalInstruccions

    quickSort:
        MOV orderingStyle, 02h
        print upwardOption
        print topDownOption
        readOption
        SUB al, 30h
        MOV typeOfSystem, al
        graphicMode
        LEA bx, orderingQuickSortMsg
        CALL chainLength
        printGraphicMode orderingQuickSortMsg 00h 00h cx
        JMP generalInstruccions

    shellSort:
        MOV orderingStyle, 03h
        print upwardOption
        print topDownOption
        readOption
        SUB al, 30h
        MOV typeOfSystem, al
        graphicMode
        LEA bx, orderingShellSortMsg
        CALL chainLength
        printGraphicMode orderingShellSortMsg 00h 00h cx

    generalInstruccions:
        getInfoCursor
        LEA bx, timeMsg
        CALL chainLength
        printGraphicMode timeMsg 00h dl cx
        frame 0000h 0010h
        graphBarReport2
    
    checkKey2:
        getKey
        CMP ah, 39h
        JNE checkKey2
        calculateDelayTime sortingSpeed
        CMP orderingStyle, 01h
        JE preludeBubbleAnimation
        CMP orderingStyle, 02h
        JE preludeQuickAnimation
        CMP orderingStyle, 03h
        JE preludeShellAnimation

    preludeBubbleAnimation:
        CMP typeOfSystem, 01h
        JE  jumpTobubbleAnimationDescending
        CMP typeOfSystem, 02h
        JE jumpTobubbleAnimationAscending
        JMP bubbleAnimationDescending

    preludeQuickAnimation:
        CMP typeOfSystem, 01h
        JE jumpToquickAnimationDescending
        CMP typeOfSystem, 02h
        JE jumpToquickAnimationAscending
        JMP quickAnimationDescending

    preludeShellAnimation:
        CMP typeOfSystem, 01h
        JE jumpToshellAnimationDescending
        CMP typeOfSystem, 02h
        JE jumpToshellAnimationAscending
        JMP shellAnimationDescending

    jumpTobubbleAnimationDescending:
        JMP bubbleAnimationDescending

    jumpTobubbleAnimationAscending:
        JMP bubbleAnimationAscending

    jumpToquickAnimationDescending:
        JMP quickAnimationDescending

    jumpToquickAnimationAscending:
        JMP quickAnimationAscending
    
    jumpToshellAnimationDescending:
        JMP shellAnimationDescending
    
    jumpToshellAnimationAscending:
        JMP shellAnimationAscending
    
    bubbleAnimationDescending:
        bubbleDescending
        readCharacterVideoMode
        textMode
        JMP administrationMenu

    bubbleAnimationAscending:
        bubbleAscending
        readCharacterVideoMode
        textMode
        JMP administrationMenu

    quickAnimationDescending:
        calculateFinalArray usersAvailablePoints
        MOV bh, 00h
        MOV bl, finalIndex
        CALL quickSortDescending
        readCharacterVideoMode
        textMode
        JMP administrationMenu

    quickAnimationAscending:
        calculateFinalArray usersAvailablePoints
        MOV bh, 00h
        MOV bl, finalIndex
        CALL quickSortAscending
        readCharacterVideoMode
        textMode
        JMP administrationMenu

    shellAnimationDescending:
        countArrayElementsGeneric usersAvailablePoints
        MOV pivotNumber, cl
        calculateJump usersAvailablePoints
        shellSortDescending usersAvailablePoints
        readCharacterVideoMode
        textMode
        JMP administrationMenu

    shellAnimationAscending:
        countArrayElements usersAvailablePoints
        MOV pivotNumber, cl
        calculateJump usersAvailablePoints
        shellSortAscending usersAvailablePoints
        readCharacterVideoMode
        textMode
        JMP administrationMenu
    
    getTop10Times:
        openFile userFileName 0h
        lseek 00h 0000 0000
        readFile 01CCh readTxt
        closeFile
        putUsersArrayTimes
        countArrayElementsGenericPts usersWithTimes
        CMP cl, 00h
        JA reportPts
        JMP showErrorEmptyArray

    reportPts:
        createFile timesReportFileName
        dottedOrderTimes
        openFile timesReportFileName 01h
        print startDesign
        LEA bx, startDesign
        CALL chainLength
        writeFile cx, startDesign
        print top10TimesSign
        LEA bx, top10TimesSign
        CALL chainLength
        writeFile cx, top10TimesSign
        top10TimesPrinting
        print finalDesign
        LEA bx, finalDesign
        CALL chainLength
        writeFile cx, finalDesign
        closeFile
        print pressSpaceForContinue

    checkKey3:
        getKey
        CMP ah, 39h
        JNE checkKey3 
        JMP barCalculation2

    barCalculation2:
        countArrayElementsGenericPts usersWithTimes
        MOV ch, 00h
        MOV barTotal, cx
        DEC cl
        barWidthCalculation cl
        getTopTime usersWithTimes
        graphicMode
        frame 0000h 0000h
        fillTimeArray
        graphBarReportTimes timeArray 9Eh
        readCharacterVideoMode
        textMode

    ordersMenu2:
        print ordinationOption1
        print ordinationOption2
        print ordinationOption3
        readOption
        SUB al, 30h
        CMP al, 01h
        JE jumpToBubbleSort2
        CMP al, 02h
        JE jumpToQuickSort2
        CMP al, 03h
        JE jumpToShellSort2
        JMP jumpToBubbleSort2
    
    jumpToBubbleSort2:
        print speedInputMsg
        readOption
        SUB al, 30h
        MOV sortingSpeed, al
        JMP bubbleSort2

    jumpToQuickSort2:
        print speedInputMsg
        readOption
        SUB al, 30h
        MOV sortingSpeed, al
        JMP quickSort2

    jumpToShellSort2:
        print speedInputMsg
        readOption
        SUB al, 30h
        MOV sortingSpeed, al
        JMP shellSort2

    bubbleSort2:
        MOV orderingStyle, 01h
        print upwardOption
        print topDownOption
        readOption
        SUB al, 30h
        MOV typeOfSystem, al
        graphicMode
        LEA bx, orderingBubbleSortMsg
        CALL chainLength
        printGraphicMode orderingBubbleSortMsg 00h 00h cx
        JMP generalInstruccions2

    quickSort2:
        MOV orderingStyle, 02h
        print upwardOption
        print topDownOption
        readOption
        SUB al, 30h
        MOV typeOfSystem, al
        graphicMode
        LEA bx, orderingQuickSortMsg
        CALL chainLength
        printGraphicMode orderingQuickSortMsg 00h 00h cx
        JMP generalInstruccions2

    shellSort2:
        MOV orderingStyle, 03h
        print upwardOption
        print topDownOption
        readOption
        SUB al, 30h
        MOV typeOfSystem, al
        graphicMode
        LEA bx, orderingShellSortMsg
        CALL chainLength
        printGraphicMode orderingShellSortMsg 00h 00h cx
    
    generalInstruccions2:
        getInfoCursor
        LEA bx, timeMsg
        CALL chainLength
        printGraphicMode timeMsg 00h dl cx
        frame 0000h 0010h
        graphBarReportTimes timeArray 8Eh

    checkKey4:
        getKey
        CMP ah, 39h
        JNE checkKey4
        calculateDelayTime sortingSpeed
        CMP orderingStyle, 01h
        JE preludeBubbleAnimation2
        CMP orderingStyle, 02h
        JE preludeQuickAnimation2
        CMP orderingStyle, 03h
        JE preludeShellAnimation2
    
    preludeBubbleAnimation2:
        CMP typeOfSystem, 01h
        JE  TobubbleAnimationDescending2
        CMP typeOfSystem, 02h
        JE jumpTobubbleAnimationAscending2
        JMP bubbleAnimationDescending2

    preludeQuickAnimation2:
        CMP typeOfSystem, 01h
        JE jumpToquickAnimationDescending2
        CMP typeOfSystem, 02h
        JE jumpToquickAnimationAscending2
        JMP quickAnimationDescending2

    preludeShellAnimation2:
        CMP typeOfSystem, 01h
        JE jumpToshellAnimationDescending2
        CMP typeOfSystem, 02h
        JE jumpToshellAnimationAscending2
        JMP shellAnimationDescending2

    TobubbleAnimationDescending2:
        JMP bubbleAnimationDescending2
    
    jumpTobubbleAnimationAscending2:
        JMP bubbleAnimationAscending2

    jumpToquickAnimationDescending2:
        JMP quickAnimationDescending2
    
    jumpToquickAnimationAscending2:
        JMP quickAnimationAscending2

    jumpToshellAnimationDescending2:
        JMP shellAnimationDescending2

    jumpToshellAnimationAscending2:
        JMP shellAnimationAscending2

    bubbleAnimationDescending2:
        bubbleDescendingTimes timeArray
        readCharacterVideoMode
        textMode
        JMP administrationMenu
    
    bubbleAnimationAscending2:
        bubbleAscendingTimes timeArray
        readCharacterVideoMode
        textMode
        JMP administrationMenu
    
    quickAnimationDescending2:
        calculateFinalArrayTime timeArray
        MOV bh, 00h
        MOV bl, finalIndex
        CALL quickSortDescendingTimes
        readCharacterVideoMode
        textMode
        JMP administrationMenu

    quickAnimationAscending2:
        calculateFinalArrayTime timeArray
        MOV bh, 00h
        MOV bl, finalIndex
        CALL quickSortAscendingTimes
        readCharacterVideoMode
        textMode
        JMP administrationMenu
    
    shellAnimationDescending2:
        countArrayElementsGenericPts usersWithTimes
        MOV pivotNumber, cl
        calculateJumpTimes usersWithTimes
        shellSortDescendingTime timeArray
        readCharacterVideoMode
        textMode
        JMP administrationMenu

    shellAnimationAscending2:
        countArrayElementsGenericPts usersWithTimes
        MOV pivotNumber, cl
        calculateJumpTimes usersWithTimes
        shellSortAscendingTime timeArray
        readCharacterVideoMode
        textMode
        JMP administrationMenu
    
    showFileError:
        print fileCreationErrorMsg
        print pressAKeyMsg
        readCharacterWithoutPrinting
        JMP mainMenu

    showOpenFileError:
        print errorOpeningFileMsg
        print pressAKeyMsg
        readCharacterWithoutPrinting
        JMP mainMenu

    fseekError:
        print fseekErrorMsg
        print pressAKeyMsg
        readCharacterWithoutPrinting
        JMP mainMenu

    showWriteFileError:
        print writeFileErrorMsg
        print pressAKeyMsg
        readCharacterWithoutPrinting
        JMP mainMenu
    
    showErrorEmptyArray:
        print emptyArrayMsg
        print pressAKeyMsg
        readCharacterWithoutPrinting
        JMP administrationMenu
main endp

;--------------------VERIFICAR QUE LA CONTRASEÑA INGRESADA SEA DE ACURDO CON EL FORMATO
checkPassword proc near
    LEA si, password
    MOV cx, 4

    numericalVerification:
        MOV al, [si]
        CMP al, 57                     ;SI ES MAYOR QUE 57 (9) ERROR
        JA syntaxError
        CMP al, 48                     ;SI ES MENOR QUE 48 (1) ERROR
        JB syntaxError
        INC si
        LOOP numericalVerification
        RET

    syntaxError:
        print passwordErrorIncorrectSyntax
        print pressAKeyMsg
        readCharacterWithoutPrinting
        JMP register
checkPassword endp

;-------------------LIMPIAR NOMBRE DE USUARIO
clearUsername proc near
    PUSH si
    PUSH ax
    PUSH bx
    LEA si, username
    MOV bl, 0

    loop1:
        CMP bl, 7
        JE exitClear
        MOV al, [si]
        CMP al, 10
        JE correctJump
        CMP al, 13
        JE correctJump
        INC bl
        INC si
        JMP loop1
    
    correctJump:
        MOV ah, 32
        MOV [si], ah
        INC bl
        INC si
        JMP loop1

    exitClear:
        POP bx
        POP ax
        POP si
        RET
clearUsername endp

;CALCULA EL LARGO DE UNA CADENA ANTES DEL SIMBOLO DE TERMINACION DE CADENA
chainLength proc near
    PUSH si           ; GUARDAR REGISTROS
    PUSH ax             ; GUARDAR REGISTROS
    MOV si, bx          ; LE PASAMOS LA CADENA POR BX
    MOV cx, 00

    loop0:
        MOV al, [si]
        CMP al, 36               ;CUANDO ENCUENTRA $ 
        JE exitLength
        INC cx                   ;SE GUARDA EL LARGO EN CX
        INC si
        JMP loop0
    
    exitLength:
        POP ax
        POP si
        RET
chainLength endp

;-------VERIFICACION DE USUARIO Y CONTRASEÑA
checkLogin proc near
    chainComparison 0005 defaultUser username
    REPE CMPSB
    JE userIdentifiedAdmin
    JMP identificationProcess

    userIdentifiedAdmin:
        MOV bl, 01h
        RET

    identificationProcess:
        MOV bx, 0000
        LEA si, readTxt
        LEA di, usernameFromFile

    cyclicalWord:
        CMP bx, 1CCh
        JAE authenticationError
        MOV cx, 0007h
        JMP usernameCycle

    authenticationError:
        MOV bl, 00h
        print authenticationMsg
        print pressAKeyMsg
        readCharacterWithoutPrinting
        RET

    usernameCycle:
        MOV al, [si]
        MOV [di], al
        INC di
        INC si
        INC bx
        LOOP usernameCycle
        INC si 
        INC bx
        MOV cx, 4
        LEA di, passwordFromFile
    
    passwordCycle:
        MOV al, [si]
        MOV [di], al
        INC di
        INC si
        INC bx
        LOOP passwordCycle
        PUSH bx
        PUSH si
        PUSH ax
        chainComparison 0007 username usernameFromFile
        REPE CMPSB
        JE comparePasswords
        JMP trackComparisons
    
    comparePasswords:
        chainComparison 0004 password passwordFromFile
        REPE CMPSB
        JE properlyLogged
        JMP trackComparisons
    
    properlyLogged:
        POP ax
        POP si
        POP bx
        MOV bl, 02h
        RET
    
    trackComparisons:
        POP ax
        POP si
        POP bx
        LEA di, usernameFromFile
        ADD bx, 11
        ADD si, 11
        JMP cyclicalWord
checkLogin endp

;----------------------------VERIFICAR NOMBRE DE USUARIO DE REGISTRO
checkRegistration proc near
    MOV bx, 0000
    LEA si, readTxt
    LEA di, usernameFromFile

    meterCycle:
        CMP bx, 1CCh
        JAE userAvailable
        MOV cx, 0007h
        JMP usernameAssembly

    userAvailable:
        RET

    usernameAssembly:
        MOV al, [si]
        MOV [di], al
        INC di
        INC si
        INC bx
        LOOP usernameAssembly
        PUSH bx
        PUSH si
        PUSH ax
        chainComparison 0007h username usernameFromFile
        REPE CMPSB
        JE duplicateUserError
        POP ax
        POP si
        POP bx
        ADD si, 16
        ADD bx, 16
        LEA di, usernameFromFile
        JMP meterCycle 
    
    duplicateUserError:
        POP ax
        POP si
        POP bx
        print equalUsersMsg
        print pressAKeyMsg
        readCharacterWithoutPrinting
        JMP mainMenu
checkRegistration endp

;----------------------ORDENA EL ARRAY CON QUICKSORT DE FORMA DESCENDENTE  ARRAY = AL ARRAY A ORDENAR  (BH) SE LE PASA EL PRIMERO, 
;(BL) EL ULTIMO
quickSortDescending proc near
    MOV ch, bh                        ;CH = I
    MOV cl, bl                        ;CL = J
    setPointer usersAvailablePoints bh
    setPointerFinal usersAvailablePoints bl                        
    calculatePivot usersAvailablePoints bh bl    ;DEVUELVE EL NUMERO PIVOTE
    MOV si, startNumberDirection
    MOV di, finalNumberDirection

    doWhile:
    
    cycleForMore:
        MOV ah, [si]
        INC si
        MOV al, [si]
        AAD
        DEC si
        CMP al, pivotNumber
        JNA juniorCycle
        INC ch
        ADD si, 000Bh
        JMP cycleForMore
    
    juniorCycle:
        MOV al, [di]
        DEC di
        MOV ah, [di]
        INC di
        AAD
        CMP al, pivotNumber
        JNB checkExchange
        DEC cl
        SUB di, 000Bh
        JMP juniorCycle

    checkExchange:
        CMP ch, cl
        JLE preparesExchange
        JMP whileCheck
    
    preparesExchange:
        SUB si, 0009h
        SUB di, 000Ah
        PUSH cx
        PUSH di
        MOV cx, 0007h
        LEA di, usernameFromArray

    saveName:
        MOV al, [si]
        MOV [di], al
        INC si
        INC di
        LOOP saveName
        MOV ah, [si]
        INC si
        MOV al, [si]
        AAD
        MOV levelFromArray, al
        INC si
        MOV ah, [si]
        INC si
        MOV al, [si]
        AAD
        MOV scoreFromArray1, al
        SUB si, 000Ah
        POP di
        POP cx
        PUSH cx
        MOV cx, 000Bh
    
    jToI:
        MOV al, [di]
        MOV [si], al
        INC si
        INC di
        LOOP jToI
        SUB si, 0002h
        SUB di, 000Bh
        PUSH si
        MOV cx, 0007h
        LEA si, usernameFromArray

    iToJusername:
        MOV al, [si]
        MOV [di], al
        INC di
        INC si
        LOOP iToJusername
        MOV al, levelFromArray
        AAM
        MOV [di], ah
        INC di
        MOV [di], al
        INC di
        MOV al, scoreFromArray1
        AAM
        MOV [di], ah
        INC di
        MOV [di], al
        POP si
        POP cx
        INC ch
        DEC cl
        ADD si, 000Bh
        SUB di, 000Bh
        PUSH cx
        PUSH bx
        PUSH si
        PUSH di
        textMode
        graphicMode
        frame 0000h 0010h
        LEA bx, orderingQuickSortMsg
        CALL chainLength
        printGraphicMode orderingQuickSortMsg 00h 00h cx
        getInfoCursor
        LEA bx, timeMsg
        CALL chainLength
        printGraphicMode timeMsg 00h dl cx
        graphBarReport2
        delay varDelay
        POP di
        POP si
        POP bx
        POP cx

    whileCheck:
        CMP ch, cl
        JNLE checkLargeNumbers
        JMP doWhile
    
    checkLargeNumbers:
        CMP bh, cl
        JNL checkSmallNumbers
        PUSH si
        PUSH di
        PUSH cx
        PUSH bx
        MOV bh, bh
        MOV bl, cl
        CALL quickSortDescending
        POP bx
        POP cx
        POP di
        POP si
    
    checkSmallNumbers:
        CMP ch, bl
        JNL exitProc
        PUSH si
        PUSH di
        PUSH cx
        PUSH bx
        MOV bh, ch
        MOV bl, bl
        CALL quickSortDescending
        POP bx
        POP cx
        POP di
        POP si
    
    exitProc:
        RET
quickSortDescending endp

;----------------------ORDENA EL ARRAY CON QUICKSORT DE FORMA DESCENDENTE  ARRAY = AL ARRAY A ORDENAR  (BH) SE LE PASA EL PRIMERO, 
;(BL) EL ULTIMO
quickSortAscending proc near
    MOV ch, bh                        ;CH = I
    MOV cl, bl                        ;CL = J
    setPointer usersAvailablePoints bh
    setPointerFinal usersAvailablePoints bl                        
    calculatePivot usersAvailablePoints bh bl    ;DEVUELVE EL NUMERO PIVOTE EN PIVOT NUMBER
    MOV si, startNumberDirection
    MOV di, finalNumberDirection

    doWhile2:
    
    cycleForMore2:
        MOV ah, [si]
        INC si
        MOV al, [si]
        AAD
        DEC si
        CMP al, pivotNumber
        JNB juniorCycle2
        INC ch
        ADD si, 000Bh
        JMP cycleForMore2
    
    juniorCycle2:
        MOV al, [di]
        DEC di
        MOV ah, [di]
        INC di
        AAD
        CMP al, pivotNumber
        JNA checkExchange2
        DEC cl
        SUB di, 000Bh
        JMP juniorCycle2

    checkExchange2:
        CMP ch, cl
        JLE preparesExchange2
        JMP whileCheck2
    
    preparesExchange2:
        SUB si, 0009h
        SUB di, 000Ah
        PUSH cx
        PUSH di
        MOV cx, 0007h
        LEA di, usernameFromArray

    saveName2:
        MOV al, [si]
        MOV [di], al
        INC si
        INC di
        LOOP saveName2
        MOV ah, [si]
        INC si
        MOV al, [si]
        AAD
        MOV levelFromArray, al
        INC si
        MOV ah, [si]
        INC si
        MOV al, [si]
        AAD
        MOV scoreFromArray1, al
        SUB si, 000Ah
        POP di
        POP cx
        PUSH cx
        MOV cx, 000Bh
    
    jToI2:
        MOV al, [di]
        MOV [si], al
        INC si
        INC di
        LOOP jToI2
        SUB si, 0002h
        SUB di, 000Bh
        PUSH si
        MOV cx, 0007h
        LEA si, usernameFromArray

    iToJusername2:
        MOV al, [si]
        MOV [di], al
        INC di
        INC si
        LOOP iToJusername2
        MOV al, levelFromArray
        AAM
        MOV [di], ah
        INC di
        MOV [di], al
        INC di
        MOV al, scoreFromArray1
        AAM
        MOV [di], ah
        INC di
        MOV [di], al
        POP si
        POP cx
        INC ch
        DEC cl
        ADD si, 000Bh
        SUB di, 000Bh
        PUSH cx
        PUSH bx
        PUSH si
        PUSH di
        textMode
        graphicMode
        frame 0000h 0010h
        LEA bx, orderingQuickSortMsg
        CALL chainLength
        printGraphicMode orderingQuickSortMsg 00h 00h cx
        getInfoCursor
        LEA bx, timeMsg
        CALL chainLength
        printGraphicMode timeMsg 00h dl cx
        graphBarReport2
        delay varDelay
        POP di
        POP si
        POP bx
        POP cx

    whileCheck2:
        CMP ch, cl
        JNLE checkLargeNumbers2
        JMP doWhile2
    
    checkLargeNumbers2:
        CMP bh, cl
        JNL checkSmallNumbers2
        PUSH si
        PUSH di
        PUSH cx
        PUSH bx
        MOV bh, bh
        MOV bl, cl
        CALL quickSortAscending
        POP bx
        POP cx
        POP di
        POP si
    
    checkSmallNumbers2:
        CMP ch, bl
        JNL exitProc2
        PUSH si
        PUSH di
        PUSH cx
        PUSH bx
        MOV bh, ch
        MOV bl, bl
        CALL quickSortAscending
        POP bx
        POP cx
        POP di
        POP si
    
    exitProc2:
        RET
quickSortAscending endp

;----------------------ORDENA EL ARRAY CON QUICKSORT DE FORMA DESCENDENTE  ARRAY = EL ARRAY A ORDENAR  (BH) SE LE PASA EL PRIMERO, 
;(BL) EL ULTIMO
quickSortDescendingTimes proc near
    MOV ch, bh                        ;CH = I
    MOV cl, bl                        ;CL = J
    setPointerTime timeArray bh
    setPointerFinalTime timeArray bl                        
    calculatePivotTime timeArray bh bl    ;DEVUELVE EL NUMERO PIVOTE
    MOV si, startNumberDirection
    MOV di, finalNumberDirection

    doWhile3:
    
    cycleForMore3:
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
        SUB si, 0002h
        CMP ax, pivotNumberTime
        JNA juniorCycle3
        INC ch
        ADD si, 0003h
        JMP cycleForMore3
    
    juniorCycle3:
        MOV al, [di]
        MOV hundredthNumber, al
        INC di
        MOV al, [di]
        MOV tenthNumber, al
        INC di
        MOV al, [di]
        MOV unitNumber, al
        form3DigitNumber hundredthNumber tenthNumber unitNumber
        MOV ax, numberWord
        SUB di, 0002h
        CMP ax, pivotNumberTime
        JNB checkExchange3
        DEC cl
        SUB di, 0003h
        JMP juniorCycle3

    checkExchange3:
        CMP ch, cl
        JLE memoryExchange
        JMP whileCheck3
    
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
        MOV al, hundredthNumber
        MOV [si], al
        INC si
        MOV al, tenthNumber
        MOV [si], al
        INC si
        MOV al, unitNumber
        MOV [si], al
        INC ch
        DEC cl
        INC si
        SUB di, 0003h 
        PUSH cx
        PUSH bx
        PUSH si
        PUSH di
        textMode
        graphicMode
        frame 0000h 0010h
        LEA bx, orderingQuickSortMsg
        CALL chainLength
        printGraphicMode orderingQuickSortMsg 00h 00h cx
        getInfoCursor
        LEA bx, timeMsg
        CALL chainLength
        printGraphicMode timeMsg 00h dl cx
        graphBarReportTimes timeArray 8Eh
        delay varDelay
        POP di
        POP si
        POP bx
        POP cx

    whileCheck3:
        CMP ch, cl
        JNLE checkLargeNumbers3
        JMP doWhile3
    
    checkLargeNumbers3:
        CMP bh, cl
        JNL checkSmallNumbers3
        PUSH si
        PUSH di
        PUSH cx
        PUSH bx
        MOV bh, bh
        MOV bl, cl
        CALL quickSortDescendingTimes
        POP bx
        POP cx
        POP di
        POP si
    
    checkSmallNumbers3:
        CMP ch, bl
        JNL exitProc3
        PUSH si
        PUSH di
        PUSH cx
        PUSH bx
        MOV bh, ch
        MOV bl, bl
        CALL quickSortDescendingTimes
        POP bx
        POP cx
        POP di
        POP si
    
    exitProc3:
        RET
quickSortDescendingTimes endp

;----------------------ORDENA EL ARRAY CON QUICKSORT DE FORMA ASCENDENTE  ARRAY = EL ARRAY A ORDENAR  (BH) SE LE PASA EL PRIMERO, 
;(BL) EL ULTIMO
quickSortAscendingTimes proc near
    MOV ch, bh                        ;CH = I
    MOV cl, bl                        ;CL = J
    setPointerTime timeArray bh
    setPointerFinalTime timeArray bl                        
    calculatePivotTime timeArray bh bl    ;DEVUELVE EL NUMERO PIVOTE
    MOV si, startNumberDirection
    MOV di, finalNumberDirection

    doWhile4:
    
    cycleForMore4:
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
        SUB si, 0002h
        CMP ax, pivotNumberTime
        JNB juniorCycle4
        INC ch
        ADD si, 0003h
        JMP cycleForMore4
    
    juniorCycle4:
        MOV al, [di]
        MOV hundredthNumber, al
        INC di
        MOV al, [di]
        MOV tenthNumber, al
        INC di
        MOV al, [di]
        MOV unitNumber, al
        form3DigitNumber hundredthNumber tenthNumber unitNumber
        MOV ax, numberWord
        SUB di, 0002h
        CMP ax, pivotNumberTime
        JNA checkExchange4
        DEC cl
        SUB di, 0003h
        JMP juniorCycle4

    checkExchange4:
        CMP ch, cl
        JLE memoryExchange2
        JMP whileCheck4
    
    memoryExchange2:
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
        MOV al, hundredthNumber
        MOV [si], al
        INC si
        MOV al, tenthNumber
        MOV [si], al
        INC si
        MOV al, unitNumber
        MOV [si], al
        INC ch
        DEC cl
        INC si
        SUB di, 0003h 
        PUSH cx
        PUSH bx
        PUSH si
        PUSH di
        textMode
        graphicMode
        frame 0000h 0010h
        LEA bx, orderingQuickSortMsg
        CALL chainLength
        printGraphicMode orderingQuickSortMsg 00h 00h cx
        getInfoCursor
        LEA bx, timeMsg
        CALL chainLength
        printGraphicMode timeMsg 00h dl cx
        graphBarReportTimes timeArray 8Eh
        delay varDelay
        POP di
        POP si
        POP bx
        POP cx

    whileCheck4:
        CMP ch, cl
        JNLE checkLargeNumbers4
        JMP doWhile4
    
    checkLargeNumbers4:
        CMP bh, cl
        JNL checkSmallNumbers4
        PUSH si
        PUSH di
        PUSH cx
        PUSH bx
        MOV bh, bh
        MOV bl, cl
        CALL quickSortAscendingTimes
        POP bx
        POP cx
        POP di
        POP si
    
    checkSmallNumbers4:
        CMP ch, bl
        JNL exitProc4
        PUSH si
        PUSH di
        PUSH cx
        PUSH bx
        MOV bh, ch
        MOV bl, bl
        CALL quickSortAscendingTimes
        POP bx
        POP cx
        POP di
        POP si
    
    exitProc4:
        RET
quickSortAscendingTimes endp

end main