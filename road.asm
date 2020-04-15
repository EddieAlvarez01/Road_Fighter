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

;-------------------------VARIABLES GENERALES
top10PtsArray db 110 dup(" "), "$"
usersAvailablePoints db 220 dup(" "), "$"
scoreFromArray1 db 00
scoreFromArray2 db 00
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

initialPosition dw 0000
finalPosition dw 0000

tenthNumber db 0
unitNumber db 0

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

;-------------------------MENSAJES DE ERROR
passwordErrorIncorrectSyntax db 10, 10, 13, "Error la contrasena debe ser de 4 numeros unicamente", "$"
errorOpeningFileMsg db 10, 10, 13, "Error al escribir el archivo", "$"
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
        JMP login

    skipRegistration:
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
        JMP mainMenu

    jumpTop10Points:
        JMP getTop10Points
    
    jumpTop10Times:
        
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
        frame
        graphBarReport
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

end main