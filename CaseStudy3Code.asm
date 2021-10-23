;***********************************************************
; This program runs on the Exercise PC board.
; 
;
;
; This routine produces 3 Messages when assembled.
;
;***********************************************************
#include <P16F737.INC>
 __config _CONFIG1, _FOSC_HS & _CP_OFF & _DEBUG_OFF & _VBOR_2_0 & _BOREN_0 & _MCLR_ON & _PWRTE_ON & _WDT_OFF
 __config _CONFIG2, _BORSEN_0 & _IESO_OFF & _FCMEN_OFF

; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;Connections 
; Green --> PORT C, pin 0
; RED ---> PORT C, pin 1
; Main Transistor --> PORT D, pin 7 
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



call initPort ; initialize ports

;GreenPressLoop, we want to loop this forever and keep checking the triggers
GreenPressLoop
btfsc PORTC,0 ; See if the green button has been pressed
goto GreenPress ; goto greenpress
goto GreenPressLoop

GreenPress ; we run this when the green button is pressed and check
			; to see if the button is released
btfss PortC,0 ;Check to see if the button has not been released
	goto GreenPress
 	;read the dial.
	Octal equ 30h ;declare the octal var
	comf PORTE, w ; put the compliment of the dial 
	andlw B'00000111, w
	movwf Octal
	;compare octal with the modes
	movlw B'00000000
	subwf Octal, w
	btfsc Status, Z
	; call it a day
	goto modeOne
 

	movwf PORTB
	
	
; &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
; Mode 1
ModeOne ; Mode one checks the status of the red pin and toggles the Main Transistor
btfsc PORTC,0 ; See if the green button has been pressed
bcf PORTD,7   ; If the green button is pressed, turn transistor off	
btfss STATUS,Z ;If the Status Z bit is 1, then skip
goto GreenPress ; Exit Mode 1 and go to Green Press
btfss PORTC, 0 ; Skip if red button is pressed
goto ModeOne ;If button is not pressed, go to ModeOne
redRelease ;Label to keep checking until red is released
btfsc PORTC, 0 ; Skip if red button is released
goto redRelease ;Keep checking if the button has been released
bsf PORTD,7   ; If the green button is pressed, turn transistor on
goto ModeOne ; Go back to Mode one





; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
; Mode 2

; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
; Mode 3

; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
; Mode 4

; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%







;
; &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;
; Port Initialization Subroutine
initPort
clrf PORTB ; Clear Port B output latches
clrf PORTC ; Clear Port C output latches
bsf STATUS,RP0 ; Set bit in STATUS register for bank 1
clrf TRISB ; Configure Port B as all outputs
 movlw B'11111111' ; move hex value FF into W register
 movwf TRISC ; Configure Port C as all inputs
 movlw B'00001110' ; RA0 analog input, all other digital
movwf ADCON1 ; move to special function A/D register
 bcf STATUS,RP0 ; Clear bit in STATUS register for bank 0
 return
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
