;This program runs on the Exercise PC board.
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

; Variable declarations
Mode equ 20h ; saves the current/ last mode
Temp equ 21h ; a temporary register
State equ 22h ; the program state register
Timer2 equ 21h ; timer storage variable
Timer1 equ 22h ; timer storage variable
Timer0 equ 23h ; timer storage variable
ADCH equ 110h
org 00h ; interrupt vector
goto SwitchCheck ; goto interrupt service routine (dummy)
org 04h ; interrupt vector
goto isrService ; goto interrupt service routine (dummy)
 org 15h ; Beginning of program storage
SwitchCheck

call initPort ; initialize ports -> needs fixing

;*****************************************************
;Will need this for the potentiometer
;AtoD
;call initAD ; call to initialize A/D
;call SetupDelay ; delay for Tad (see data sheet) prior to A/D start
;bsf ADCON0,GO ; start A/D conversion
goto ModeOne
;starting loop to choose mode
waitPress ; at the start we wait for a press to trigger a mode
	 btfss PORTC,0 ; see if green button pressed
	goto GreenPress ; green button is pressed - goto routine
	goto waitPress ; keep checking

GreenPress ; we run this when the green button is pressed and check
	call SwitchDelay ; let switch debounce
	 btfsc PORTC,0 ; see if green button still pressed
	goto goToMode; noise - not pressed go back **********
	GreenRelease
	;tuen off thetransistor
	 btfss PORTC,0 ; see if green button released
	goto GreenRelease ; no - keep waiting
	 goto readDial ; increment the counter & output

RedPress; CALL this to see if the red has been pressed
	btfsc PORTC, 0 ; see if red button pressed
		return;If button is not pressed
		; here we want to return 0 for the z bit

	call SwitchDelay ; let switch debounce

	btfsc PORTC,6 ; see if red button still pressed
		return; noise - not pressed - keep checking
		; here we want to return 0 for the z bit
	
	RedRelease1
	btfss PORTC,6 ; see if red button released
		goto RedRelease1 ; no - keep waiting
	return ; here we want to return 1 for the z bit
	
	
ReadDial ; needs some checking out

	Octal equ 30h ;declare the octal var
	comf PORTE, w ; put the compliment of the dial 
	andlw B'00000111' 
	movwf Octal
	goto GoToMode


goToMode
	;if statments checking status 
		;compare octal with the modes.
	
	movlw B'00000000'
	subwf Octal, 0 ; change octal to mode 
	btfsc Status, Z
	goto modeOne
	btfss PortC,0 ;Check to see if the button has not been released
	goto GreenPress

 	;read the dial.
	Octal equ 30h ;declare the octal var
	comf PORTE, 0 ; put the compliment of the dial 
	andlw B'00000111'
	movwf Octal

	;compare octal with the modes ****************************************** We need all the modes here. 
	; mode 1
	movlw B'00000000'
	subwf Octal, 0
	btfsc Status, Z
		goto mode2Check
	movwf PORTB; Set LED
	goto ModeOne
	
	mode2Check
	movlw B'00000001'
	subwf Octal, 0
	btfsc Status, Z
		goto mode3Check
	movwf PORTB; Set LED
	goto Mode2
	
	mode3Check
	movlw B'00000010'
	subwf Octal, 0
	btfsc Status, Z
		goto mode4Check
	movwf PORTB;Set LED
	goto Mode2
 
	mode4Check
	movlw B'00000011'
	subwf Octal, 0
	btfsc Status, Z
	movwf PORTB; Set LED
	goto Mode2

	mode5Check
	movlw B'00000011'
	subwf Octal, 0
	btfsc Status, Z
	movwf PORTB; Set LED
	goto Mode2
 	

	movwf PORTB
	
SwitchDelay ; called after each button press for  debouncing
movlw D'20' ; load Temp with decimal 20
movwf Temp
delay
decfsz Temp, F ; 60 usec delay loop
goto delay ; loop until count equals zero

return ; return to calling routine	

Timer ; for 1 second 
movlw 06h ; get most significant hex value + 1
movwf Timer2 ; store it in count register
movlw 16h ; get next most significant hex value
movwf Timer1 ; store it in count register
movlw 15h ; get least significant hex value
movwf Timer0 ; store it in count register
delay
decfsz Timer0, F ; Delay loop Timer0
goto delay
decfsz Timer1, F ; Delay loop Timer1
goto delay
decfsz Timer2, F ; Delay loop Timer2
goto delay
return
 
ToggleTransistor ; subroutine to toggle the transistor
	btfsc PORTD, 6;if trans on
	bcf PORTD, 6 ; turn off the small trans
	call turnOnSolenoid
return

TurnOnSolenoid ; turns on big trans and little trans, delays, turns off big
	bsf PORTD,7	;turn on big transistor
	bsf PORTD, 6 ; turn on reduced transistor
	call Timer ; waits 1 second
	bcf PORTD,7 ;turn off big transistor	
return

ReadADC 

	bsf ADCON0,GO ;restart A/D conversion
	waitLoopADC
	btfsc ADCON0,GO ; check if A/D is finished
 		goto waitLoopADC ; loop right here until A/D finished
	movf ADRESH, 0
	Movwf ADCH
	
return

; &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
; Mode 1 ALTERNATIVE Lucas
ModeOne ; Mode one checks the status of the red pin and toggles the Main Transistor
	btfss PORTC,0 ; see if green button pressed
	goto GreenPress ; green button is pressed - goto routine
	
	btfsc PORTC, 0 ; see if red button pressed
	goto ModeOne ;If button is not pressed, go to ModeOne

	call SwitchDelay ; let switch debounce
	btfsc PORTC,6 ; see if red button still pressed
	goto ModeOne ; noise - not pressed - keep checking
	
	RedRelease1
	btfss PORTC,6 ; see if red button released
	goto RedRelease1 ; no - keep waiting
	call toggleTransistor
	goto ModeOne ; Go back to Mode one

TurnOnSolenoid ; turns on big trans and little trans, delays, turns off big
	bsf PORTD,7	;turn on big transistor
	bsf PORTD, 6 ; turn on reduced transistor
	call Timer ; waits 1 second
	bcf PORTD,7 ;turn off big transistor	
return
	


; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
; Mode 2
Mode2 
	bsf ADCON0,GO ;restart A/D conversion

  waitLoop2 ;this is for waiting till A?D is done and red press
	btfss PORTC,0 ; see if green button pressed
		goto GreenPress ; green button is pressed - goto routine
	
	btfsc ADCON0,GO ; check if A/D is finished
  		goto waitLoop2 ; loop right here until A/D finished

	call RedPressed ;see if red button pressed
	btfsc STATUS, z;check z bit, it will tell us if we should loop back ********************************************************
		
	movf ADRESH,W ; get A/D value

	; x/4 = ((x/2)/2)
	rrf w,0 ; divide by 2
	rrf w,0 ; divide by 2
	andlw B'00111111' n ; kill the leading 2 dig

	mode2Loop ; timer loop
	dec ;deincriment 1 **********************************************************************************
	call Timer ;GLOBAL delay for one second
	btfsc PORTC, 0 ; see if red button pressed
	goto ModeOne ;If button is not pressed, go t

	call SwitchDelay ; let switch debounce
	btfsc PORTC,6 ; see if red button still pressed

	goto mode2Loop ; noise - not pressed - keep checking

	goto Mode2

; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
; Mode 3 - AC thermostat
	mode3Loop
	
	
;read the control pot - > represents the thermostat
;if below 70h solinoid engages
;if red press again control is inactive\
;solidnoid off
; if pot is 0 then we send to an error mode


; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
; Mode 4

; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ErrorMode
	;set LEDS
	movf octal,W ; move the count to the W register
 	movwf PORTB ; display count on port B LEDs
	;get trapped in a loop.

; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ReadAD
	bsf ADCON0,GO ;restart A/D conversion
	; read the Port A Pin 0 
	btfsc ADCON0,GO ; check if A/D is finished
	; Get value and display on LEDs
	goto ReadAD  ; A/D not finished, continue to loop
	movf ADRESH,W ; get A/D value
	andlw B'11111111'
	mode2Loop
	btfsc
	return

;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;
; InitializeAD - initializes and sets up the A/D hardware.
; Select AN0 to AN3 as analog inputs, proper clock period, and read AN0.
initAD
bsf STATUS,RP0 ; select register bank 1
movlw B'00001110' ; RA0 analog input, all other digital
movwf ADCON1 ; move to special function A/D register
bcf STATUS,RP0 ; select register bank 0
movlw B'01000001' ; select 8 * oscillator, analog input 0, turn on
movwf ADCON0 ; move to special function A/D register
return
;
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; Port Initialization Subroutine
;PORT A pin 0:control pot(input)
;PORT B pin 0-3:LED(output)
;PORT C pin 7:green  button(input)
	   ;pin 6:red button(input)
;PORT D pin 7:main TIP(output)
       ;pin 6:reduced TIP(output)
	   ;pin 2 :sensor(input)
;PORT E pin 0-2:octal switch(input)

initPort
clrf PORTB ; Clear Port B output latches LEDs
clrf PORTC 
clrf PORTD
clrf PORTE

bsf STATUS,RP0 ; Set bit in STATUS register for bank 1

movlw	B'11110000';
movwf	TRISB

movlw	B'01111100';
movwf	TRISD

movlw	B'11111111'
movwf	TRISC

movlw	B'00000111'				
movwf	TRISE

movlw B'00001110' ; RA0 analog input, all other digital
movwf ADCON1 ; move to special function A/D register

bcf STATUS,RP0 ; Clear bit in STATUS register for bank 0
 return
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;
; This routine is a software delay of 10uS required for the A/D setup.
; At a 4Mhz clock, the loop takes 3uS, so initialize the register Temp with
; a value of 3 to give 9uS, plus the move etc. should result in
; a total time of > 10uS.
SetupDelay
movlw 03h ; load Temp with hex 3
movwf Temp
delay2

decfsz Temp, F ; Delay loop
goto delay2
return
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;
; Note: this is a dummy interrupt service routine. It is good programming
; practice to have it. If interrupts are enabled (which they should not be)
; and if an interrupt occurs (which should not happen), this routine safely
; hangs up the microcomputer in an infinite loop.
isrService
goto isrService ; error - - stay here
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
end
