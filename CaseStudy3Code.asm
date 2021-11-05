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
; Sensor ADC ---> PORT A , pin 
; LED -----> PORT 
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
bsf PORTD,7   ; If the red button is released, turn transistor on
goto ModeOne ; Go back to Mode one
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
; Mode 2
ModeTwo ;ModeTwo checks the value of the ADC then starts a counter until interuptted
btfsc PORTC,0 ; See if the green button has been pressed
goto GreenPress ; Exit Mode 1 and go to Green Press
btfss PORTC, 0 ; Skip if red button is pressed
goto ModeOne ;If button is not pressed, go to ModeOne
redRelease ;Label to keep checking until red is released
btfsc PORTC, 0 ; Skip if red button is released
goto redRelease ;Keep checking if the button has been released
;We need to prompt the ADC to do the conversion
;TODO: Need to figure out a way to store 10 bits of data

; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
; Mode 3
ModeThree
btfsc PORTC,0 ; See if the green button has been pressed
	goto GreenPress ; Exit Mode 3 and go to Green Press
btfss PORTC, 0 ; Skip if red button is pressed
	goto Modethree ;If button is not pressed, go to ModeThree
redRelease ;Label to keep checking until red is released
btfsc PORTC, 0 ; Skip if red button is released
	goto redRelease ;Keep checking if the button has been released
movlw B'00000011' ;Move the led indicator config to working 
movwf PORTB ; Set the Indicator LED
ADCRead
goto ReadADC ; Read the value from the ADC
movf ADCH,0 ; This will move the value fo ADCH to W
andlw B'11111111' ; Check if the ADC value is zero
btfss STATUS,Z ;if this value is zero, then the ADC read zero so throw an error
	goto ModeThreeError
;Subtract 70hex from the ADC value
sublw H'70' 
;Now we want to check to see if the Value of C and Z is zero (Less than 70h)
btfss STATUS, C ; Skips if the value is 1
	bcf PORTD,7 ;Turns off the Transistor
bsf PORTD,7 ;Turns on the Transistor
btfsc PORTC,1 ;Skips if Red button is pressed
	goto ADCRead
RedReleaseTwo ;Label to check to see if the Red button is released
btfss PORTC,1 ;Skips if the Red is still pressed
	goto RedReleaseTwo ;keep checking if red is released
;Red is released
bcf PORTD,7 ;Turns off the Transistor
movlw B'00000000' ;Move the led indicator config to working 
movwf PORTB ; Set the Indicator LED
goto ModeThree

	


ModeThreeError
goto ModeThreeError ; If we have an error we want to continue to loop


; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
; Mode 4

; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

;
; &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; READ ADC and store the values
ReadADC
ADCH equ 110h ;Create a memory location for ADCRESH
;TODO: Need to actually read the register value

;
; &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;




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
