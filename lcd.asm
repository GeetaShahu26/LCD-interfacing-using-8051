ORG 0000H
LJMP MAIN

ORG 0030H
MAIN:
    ACALL DELAY_15MS    ; Wait for LCD power-on initialization
    
    MOV A, #38H         ; Function set: 2 lines, 5x7 matrix
    ACALL COM_WRITE
    
    MOV A, #0EH         ; Display on, cursor off
    ACALL COM_WRITE
    
    MOV A, #06H         ; Entry mode: increment cursor, no shift
    ACALL COM_WRITE
    
    MOV A, #01H         ; Clear display
    ACALL COM_WRITE
    
    MOV A, #80H         ; Set DDRAM address: first line, first position
    ACALL COM_WRITE
    
    MOV DPTR, #MY_STR   ; Load string address into data pointer

DISPLAY_LOOP:
    MOV A, #00H         ; Clear accumulator
    MOVC A, @A+DPTR     ; Get character from code memory
    JZ FINISH           ; If null terminator, jump to finish
    ACALL DATA_WRITE    ; Write character to LCD
    INC DPTR            ; Point to next character
    SJMP DISPLAY_LOOP   ; Repeat loop

FINISH:
    SJMP $              ; Infinite loop (end of program)

;----- Command Write Subroutine ------
COM_WRITE:
    MOV P1, A           ; Send command to data pins (D0-D7)
    CLR P2.1            ; RS = 0 (Command mode)
    SETB P2.2           ; E = 1
    ACALL SHORT_DELAY   ; Enable pulse width delay
    CLR P2.2            ; E = 0 (Creates falling edge)
    ACALL DELAY_ROUTINE ; Command processing delay
    RET

;----- Data Write Subroutine ------
DATA_WRITE:
    MOV P1, A           ; Send data to data pins (D0-D7)
    SETB P2.1           ; RS = 1 (Data mode)
    SETB P2.2           ; E = 1
    ACALL SHORT_DELAY   ; Enable pulse width delay
    CLR P2.2            ; E = 0 (Creates falling edge)
    ACALL DELAY_ROUTINE ; Data processing delay
    RET

;----- Short Delay for Enable Pulse ------
SHORT_DELAY:
    MOV R7, #50
    SD_LOOP:
        DJNZ R7, SD_LOOP
    RET

;----- Main Delay Routine ------
DELAY_ROUTINE:
    MOV R5, #0FFH
DL_LOOP1:
    MOV R6, #0FFH
DL_LOOP2:
    DJNZ R6, DL_LOOP2
    DJNZ R5, DL_LOOP1
    RET

;----- 15ms Power-On Delay ------
DELAY_15MS:
    MOV R4, #100
PWR_LOOP:
    ACALL DELAY_ROUTINE
    DJNZ R4, PWR_LOOP
    RET

;----- String Data ------
MY_STR: 
    DB 'Geeta Shahu', 0   ; Null-terminated string

END