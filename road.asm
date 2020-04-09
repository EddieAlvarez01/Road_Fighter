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
menuAdminOption2 db 10, 10, 13, "2) Top 10 tiempos", "$"
menuAdminOption3 db 10, 10, 13, "3) Salir", "$"

;--------------------------MENU GENERAL
option1 db 10, 10, 13, "1) Ingresar", "$"
option2 db 10, 13, "2) Registrar", "$"
option3 db 10, 13, "3) Salir", 10, 13, "$"

;--------------------------MENU USUARIO
menuUserOption1 db 10, 10, 13, "1) Iniciar Juego", "$"
menuUserOption2 db 10, 13, "2) Cargar Juego", "$"
menuUserOption3 db 10, 13, "3) Salir", "$"

;--------------------------VARIABLES PARA VERIFICCION DE USUARIOS
usernameMsg db 10, 10, 13, "Nombre de usuario: ", "$"
passwordMsg db 10, 13, "Contrasena: ", "$"
username db 7 dup(" "), "$"
password db 4 dup(" "), "$"

;--------------------------MENSAJES DEL SISTEMA
pressAKeyMsg db 10, 13, "Presiona una tecla para continuar....", "$"
registeredUserMsg db 10, 13, "Usuario registrado correctamente", "$" 

;-------------------------MENSAJES DE ERROR
passwordErrorIncorrectSyntax db 10, 10, 13, "Error la contrasena debe ser de 4 numeros unicamente", "$"
errorOpeningFileMsg db 10, 10, 13, "Error al escribir el archivo", "$"
fileCreationErrorMsg db 10, 10, 13, "Error no se puede crear el archivo", "$"
fseekErrorMsg db 10, 10, 13, "Error no se puede desplazar el puntero", "$"
writeFileErrorMsg db 10, 10, 13, "Error no se puede escribir en archivo", "$"

;--------------------------VARIABLES DE MANEJO DE ARCHIVOS
handle dw ?
userFileName db "usr.txt", 00
delimiter db 59, "$"
defaultLevel db "00", "$"
defaultScore db "00", "$"
defaultTime db "000", "$"
newLine db 10, "$" 


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

    skipRegistration:
        JMP register
    
    register:
        print usernameMsg
        readChain 7, username
        CALL clearUsername
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
        CMP bl, 6
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

;CALCULA EL LARGO DE UNA CADENA ANTES DEL SIMBOLODE TERMINACION DE CADENA
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

end main