list P=16F737
 title "Case Study 3"
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
; Main Transistor --> PORT D, 
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



call initPort ; initialize ports

;GreenPressLoop, we want to loop this forever and keep checking the triggers
GreenPressLoop
btfss PORTC,0 ; See if the green button has been pressed
goto GreenPress ; goto greenpress
goto Loop

GreenPress ; we run this when the green button is pressed
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
