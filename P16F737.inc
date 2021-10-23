LIST
;==========================================================================
;  MPASM PIC16F737 processor include
;
;  (c) Copyright 1999-2013 Microchip Technology, All rights reserved
;==========================================================================
NOLIST
;==========================================================================
;  This header file defines configurations, registers, and other useful
;  bits of information for the PIC16F737 microcontroller.  These names
;  are taken to match the data sheets as closely as possible.
 ;
;  Note that the processor must be selected before this file is included.
;  The processor may be selected the following ways:
;
;
;
;
;
;
;
;==========================================================================
;==========================================================================
;
;       Verify Processor
;
;==========================================================================
        IFNDEF __16F737
           MESSG "Processor-header file mismatch.  Verify selected processor."
ENDIF
;==========================================================================
;
;       Register Definitions
;
;==========================================================================
W                EQU  H'0000'
F                EQU  H'0001'
;----- Register Files -----------------------------------------------------
;-----Bank0------------------
INDF
TMR0
PCL
STATUS
FSR
PORTA
PORTB
PORTC
PORTE
EQU  H'0000'
EQU  H'0001'
EQU  H'0002'
EQU  H'0003'
EQU  H'0004'
EQU  H'0005'
EQU  H'0006'
EQU  H'0007'
EQU  H'0009'
1. Command line switch:
        C:\MPASM MYFILE.ASM /PIC16F737
2. LIST directive in the source file
        LIST   P=PIC16F737
3. Processor Type entry in the MPASM full-screen interface
4. Setting the processor in the MPLAB Project Dialog
1

PCLATH
INTCON
PIR1
PIR2
TMR1
TMR1L
TMR1H
T1CON
TMR2
T2CON
SSPBUF
SSPCON
CCPR1
CCPR1L
CCPR1H
CCP1CON
RCSTA
TXREG
RCREG
CCPR2
CCPR2L
CCPR2H
CCP2CON
ADRESH
ADCON0
EQU  H'000A'
EQU  H'000B'
EQU  H'000C'
EQU  H'000D'
EQU  H'000E'
EQU  H'000E'
EQU  H'000F'
EQU  H'0010'
EQU  H'0011'
EQU  H'0012'
EQU  H'0013'
EQU  H'0014'
EQU  H'0015'
EQU  H'0015'
EQU  H'0016'
EQU  H'0017'
EQU  H'0018'
EQU  H'0019'
EQU  H'001A'
EQU  H'001B'
EQU  H'001B'
EQU  H'001C'
EQU  H'001D'
EQU  H'001E'
EQU  H'001F'
 ;-----Bank1------------------
OPTION_REG
TRISA
TRISB
TRISC
PIE1
PIE2
PCON
OSCCON
OSCTUNE
SSPCON2
PR2
SSPADD
SSPSTAT
CCPR3
CCPR3L
CCPR3H
CCP3CON
TXSTA
SPBRG
ADCON2
CMCON
CVRCON
ADRESL
ADCON1
EQU  H'0081'
EQU  H'0085'
EQU  H'0086'
EQU  H'0087'
EQU  H'008C'
EQU  H'008D'
EQU  H'008E'
EQU  H'008F'
EQU  H'0090'
EQU  H'0091'
EQU  H'0092'
EQU  H'0093'
EQU  H'0094'
EQU  H'0095'
EQU  H'0095'
EQU  H'0096'
EQU  H'0097'
EQU  H'0098'
EQU  H'0099'
EQU  H'009B'
EQU  H'009C'
EQU  H'009D'
EQU  H'009E'
EQU  H'009F'
;-----Bank2------------------
WDTCON
LVDCON
PMDATA
PMADR
PMDATH
EQU  H'0105'
EQU  H'0109'
EQU  H'010C'
EQU  H'010D'
EQU  H'010E'
2

PMADRH           EQU  H'010F'
;-----Bank3------------------
PMCON1           EQU  H'018C'
;----- STATUS Bits -----------------------------------------------------
C                EQU  H'0000'
DC               EQU  H'0001'
Z                EQU  H'0002'
NOT_PD           EQU  H'0003'
NOT_TO           EQU  H'0004'
IRP              EQU  H'0007'
RP0              EQU  H'0005'
RP1              EQU  H'0006'
;----- PORTA Bits -----------------------------------------------------
RA0              EQU  H'0000'
RA1              EQU  H'0001'
RA2              EQU  H'0002'
RA3              EQU  H'0003'
RA4              EQU  H'0004'
RA5              EQU  H'0005'
RA6              EQU  H'0006'
RA7              EQU  H'0007'
;----- PORTB Bits -----------------------------------------------------
RB0              EQU  H'0000'
RB1              EQU  H'0001'
RB2              EQU  H'0002'
RB3              EQU  H'0003'
RB4              EQU  H'0004'
RB5              EQU  H'0005'
RB6              EQU  H'0006'
RB7              EQU  H'0007'
;----- PORTC Bits -----------------------------------------------------
RC0              EQU  H'0000'
RC1              EQU  H'0001'
RC2              EQU  H'0002'
RC3              EQU  H'0003'
RC4              EQU  H'0004'
RC5              EQU  H'0005'
RC6              EQU  H'0006'
RC7              EQU  H'0007'
;----- PORTE Bits -----------------------------------------------------
RE3              EQU  H'0003'
;----- INTCON Bits -----------------------------------------------------
RBIF             EQU  H'0000'
INTF             EQU  H'0001'
TMR0IF           EQU  H'0002'
 3

RBIE             EQU  H'0003'
INTE             EQU  H'0004'
TMR0IE           EQU  H'0005'
PEIE             EQU  H'0006'
GIE              EQU  H'0007'
INT0IF           EQU  H'0001'
T0IF             EQU  H'0002'
INT0IE           EQU  H'0004'
T0IE             EQU  H'0005'
;----- PIR1 Bits -----------------------------------------------------
 TMR1IF
TMR2IF
CCP1IF
SSPIF
TXIF
RCIF
ADIF
PSPIF
EQU  H'0000'
EQU  H'0001'
EQU  H'0002'
EQU  H'0003'
EQU  H'0004'
EQU  H'0005'
EQU  H'0006'
EQU  H'0007'
;----- PIR2 Bits -----------------------------------------------------
CCP2IF
CCP3IF
BCLIF
LVDIF
CMIF
OSFIF
EQU  H'0000'
EQU  H'0001'
EQU  H'0003'
EQU  H'0005'
EQU  H'0006'
EQU  H'0007'
;----- T1CON Bits -----------------------------------------------------
TMR1ON
TMR1CS
NOT_T1SYNC
T1OSCEN
T1RUN
T1SYNC
T1CKPS0
T1CKPS1
T1INSYNC
;----- T2CON Bits -----------------------------------------------------
TMR2ON
T2CKPS0
T2CKPS1
TOUTPS0
TOUTPS1
TOUTPS2
TOUTPS3
EQU H'0002'
EQU  H'0000'
EQU  H'0001'
EQU  H'0003'
EQU  H'0004'
EQU  H'0005'
EQU  H'0006'
EQU  H'0000'
EQU  H'0001'
EQU  H'0002'
EQU  H'0003'
EQU  H'0006'
EQU  H'0002'
EQU  H'0004'
EQU  H'0005'
EQU H'0002'
;----- SSPCON Bits -----------------------------------------------------
4

CKP
SSPEN
SSPOV
WCOL
SSPM0
SSPM1
SSPM2
SSPM3
EQU  H'0004'
EQU  H'0005'
EQU  H'0006'
EQU  H'0007'
EQU  H'0000'
EQU  H'0001'
EQU  H'0002'
EQU  H'0003'
 ;----- CCP1CON Bits -----------------------------------------------------
CCP1Y CCP1X
CCP1M0
CCP1M1
CCP1M2
CCP1M3
EQU  H'0004'
EQU  H'0005'
EQU  H'0000'
EQU  H'0001'
EQU  H'0002'
EQU  H'0003'
;----- RCSTA Bits -----------------------------------------------------
RX9D             EQU  H'0000'
OERR             EQU  H'0001'
FERR             EQU  H'0002'
ADDEN            EQU  H'0003'
CREN             EQU  H'0004'
SREN             EQU  H'0005'
RX9              EQU  H'0006'
SPEN             EQU  H'0007'
RCD8             EQU  H'0000'
RC9              EQU  H'0006'
NOT_RC8          EQU  H'0006'
RC8_9            EQU  H'0006'
;----- CCP2CON Bits -----------------------------------------------------
CCP2Y CCP2X
CCP2M0
CCP2M1
CCP2M2
CCP2M3
EQU  H'0004'
EQU  H'0005'
EQU  H'0000'
EQU  H'0001'
EQU  H'0002'
EQU  H'0003'
;----- ADCON0 Bits -----------------------------------------------------
ADON             EQU  H'0000'
CHS3             EQU  H'0001'
GO_NOT_DONE      EQU  H'0002'
GO               EQU  H'0002'
CHS0             EQU  H'0003'
CHS1             EQU  H'0004'
CHS2             EQU  H'0005'
5

ADCS0 ADCS1
NOT_DONE
GO_DONE
EQU  H'0006'
EQU  H'0007'
EQU  H'0002'
EQU  H'0002'
 ;----- OPTION_REG Bits -----------------------------------------------------
PSA              EQU  H'0003'
T0SE             EQU  H'0004'
T0CS             EQU  H'0005'
INTEDG           EQU  H'0006'
NOT_RBPU         EQU  H'0007'
PS0              EQU  H'0000'
PS1              EQU  H'0001'
PS2              EQU  H'0002'
;----- TRISA Bits -----------------------------------------------------
TRISA0
TRISA1
TRISA2
TRISA3
TRISA4
TRISA5
TRISA6
TRISA7
EQU  H'0000'
EQU  H'0001'
EQU  H'0002'
EQU  H'0003'
EQU  H'0004'
EQU  H'0005'
EQU  H'0006'
EQU  H'0007'
;----- TRISB Bits -----------------------------------------------------
TRISB0
TRISB1
TRISB2
TRISB3
TRISB4
TRISB5
TRISB6
TRISB7
EQU  H'0000'
EQU  H'0001'
EQU  H'0002'
EQU  H'0003'
EQU  H'0004'
EQU  H'0005'
EQU  H'0006'
EQU  H'0007'
;----- TRISC Bits -----------------------------------------------------
TRISC0
TRISC1
TRISC2
TRISC3
TRISC4
TRISC5
TRISC6
TRISC7
EQU  H'0000'
EQU  H'0001'
EQU  H'0002'
EQU  H'0003'
EQU  H'0004'
EQU  H'0005'
EQU  H'0006'
EQU  H'0007'
;----- PIE1 Bits -----------------------------------------------------
TMR1IE
TMR2IE
CCP1IE
SSPIE
EQU  H'0000'
EQU  H'0001'
EQU  H'0002'
EQU  H'0003'
6

TXIE             EQU  H'0004'
RCIE             EQU  H'0005'
ADIE             EQU  H'0006'
PSPIE            EQU  H'0007'
;----- PIE2 Bits -----------------------------------------------------
 CCP2IE
CCP3IE
BCLIE
LVDIE
CMIE
OSFIE
EQU  H'0000'
EQU  H'0001'
EQU  H'0003'
EQU  H'0005'
EQU  H'0006'
EQU  H'0007'
;----- PCON Bits -----------------------------------------------------
NOT_BOR
NOT_POR
SBOREN
NOT_BO
EQU  H'0000'
EQU  H'0001'
EQU  H'0002'
EQU H'0000'
;----- OSCCON Bits -----------------------------------------------------
IOFS             EQU  H'0002'
OSTS             EQU  H'0003'
SCS0             EQU  H'0000'
SCS1             EQU  H'0001'
IRCF0            EQU  H'0004'
IRCF1            EQU  H'0005'
IRCF2            EQU  H'0006'
;----- OSCTUNE Bits -----------------------------------------------------
TUN0             EQU  H'0000'
TUN1             EQU  H'0001'
TUN2             EQU  H'0002'
TUN3             EQU  H'0003'
TUN4             EQU  H'0004'
TUN5             EQU  H'0005'
;----- SSPCON2 Bits -----------------------------------------------------
SEN              EQU  H'0000'
RSEN             EQU  H'0001'
PEN              EQU  H'0002'
RCEN             EQU  H'0003'
ACKEN            EQU  H'0004'
ACKDT            EQU  H'0005'
ACKSTAT          EQU  H'0006'
GCEN             EQU  H'0007'
;----- SSPSTAT Bits -----------------------------------------------------
BF               EQU  H'0000'
UA               EQU  H'0001'
R_NOT_W          EQU  H'0002'
7

S
P
D_NOT_A
CKE
SMP
R D
I2C_READ
I2C_START
I2C_STOP
I2C_DATA
NOT_W NOT_A
NOT_WRITE
NOT_ADDRESS
R_W D_A
READ_WRITE
DATA_ADDRESS
EQU  H'0003'
EQU  H'0004'
EQU  H'0005'
EQU  H'0006'
EQU  H'0007'
EQU  H'0002'
EQU  H'0005'
EQU  H'0002'
EQU  H'0003'
EQU  H'0004'
EQU  H'0005'
EQU  H'0002'
EQU  H'0005'
EQU  H'0002'
EQU  H'0005'
EQU  H'0002'
EQU  H'0005'
EQU  H'0002'
EQU  H'0005'
 ;----- CCP3CON Bits -----------------------------------------------------
CCP3Y CCP3X
CCP3M0
CCP3M1
CCP3M2
CCP3M3
EQU  H'0004'
EQU  H'0005'
EQU  H'0000'
EQU  H'0001'
EQU  H'0002'
EQU  H'0003'
;----- TXSTA Bits -----------------------------------------------------
TX9D             EQU  H'0000'
TRMT             EQU  H'0001'
BRGH             EQU  H'0002'
SYNC             EQU  H'0004'
TXEN             EQU  H'0005'
TX9              EQU  H'0006'
CSRC             EQU  H'0007'
TXD8             EQU  H'0000'
NOT_TX8          EQU  H'0006'
TX8_9            EQU  H'0006'
;----- ADCON2 Bits -----------------------------------------------------
ACQT0
ACQT1
ACQT2
EQU  H'0003'
EQU  H'0004'
EQU  H'0005'
8

;----- CMCON Bits -----------------------------------------------------
CIS              EQU  H'0003'
C1INV            EQU  H'0004'
C2INV            EQU  H'0005'
C1OUT            EQU  H'0006'
C2OUT            EQU  H'0007'
CM0              EQU  H'0000'
CM1              EQU  H'0001'
CM2              EQU  H'0002'
;----- CVRCON Bits -----------------------------------------------------
CVRR             EQU  H'0005'
CVROE            EQU  H'0006'
CVREN            EQU  H'0007'
CVR0             EQU  H'0000'
CVR1             EQU  H'0001'
CVR2             EQU  H'0002'
CVR3             EQU  H'0003'
;----- ADCON1 Bits -----------------------------------------------------
 ADCS2 ADFM
PCFG0
PCFG1
PCFG2
PCFG3
VCFG0
VCFG1
EQU  H'0006'
EQU  H'0007'
EQU  H'0000'
EQU  H'0001'
EQU  H'0002'
EQU  H'0003'
EQU  H'0004'
EQU  H'0005'
;----- WDTCON Bits -----------------------------------------------------
SWDTEN
SWDTE
WDTPS0
WDTPS1
WDTPS2
WDTPS3
EQU H'0000'
EQU  H'0000'
EQU  H'0001'
EQU  H'0002'
EQU  H'0003'
EQU  H'0004'
;----- LVDCON Bits -----------------------------------------------------
LVDEN IRVST
LVDL0
LVDL1
LVDL2
LVDL3
EQU  H'0004'
EQU  H'0005'
EQU  H'0000'
EQU  H'0001'
EQU  H'0002'
EQU  H'0003'
;----- PMCON1 Bits -----------------------------------------------------
RD               EQU  H'0000'
9

 ;==========================================================================
;
;       RAM Definitions
;
;==========================================================================
       __MAXRAM  H'01FF'
       __BADRAM  H'0008'
       __BADRAM  H'0088'-H'0089'
       __BADRAM  H'009A'
       __BADRAM  H'0107'-H'0108'
       __BADRAM  H'0185'
       __BADRAM  H'0187'-H'0189'
       __BADRAM  H'018D'-H'018F'
;==========================================================================
;
;       Configuration Bits
;
;   NAME
;   CONFIG1
;   CONFIG2
;
;==========================================================================
; The following is an assignment of address values for all of the
; configuration registers for the purpose of table reads
_CONFIG1         EQU  H'2007'
_CONFIG2         EQU  H'2008'
;----- CONFIG1 Options --------------------------------------------------
Address
  2007h
  2008h
_FOSC_LP
_LP_OSC
_FOSC_XT
_XT_OSC
_FOSC_HS
_HS_OSC
_FOSC_EC
_EXTCLK
_FOSC_INTOSCIO
OSC1/CLKI/RA7 and OSC2/CLKO/RA6
_INTRC_IO            EQU  H'3FFC'
OSC1/CLKI/RA7 and OSC2/CLKO/RA6
_FOSC_INTOSCCLK      EQU  H'3FFD'
OSC2/CLKO/RA6 and port I/O function on OSC1/CLKI/RA7
_INTRC_CLKOUT        EQU  H'3FFD'    ; INTRC oscillator; CLKO function on
OSC2/CLKO/RA6 and port I/O function on OSC1/CLKI/RA7
_FOSC_EXTRCIO
OSC2/CLKO/RA6
_EXTRC_IO
OSC2/CLKO/RA6
_FOSC_EXTRCCLK
OSC2/CLKO/RA6
_EXTRC_CLKOUT
OSC2/CLKO/RA6
EQU  H'3FFE'
EQU  H'3FFE'
EQU  H'3FFF'
EQU  H'3FFF'
; EXTRC oscillator; port I/O function on
; EXTRC oscillator; port I/O function on
; EXTRC oscillator; CLKO function on
; EXTRC oscillator; CLKO function on
EQU  H'3FEC'
EQU  H'3FEC'
EQU  H'3FED'
EQU  H'3FED'
EQU  H'3FEE'
EQU  H'3FEE'
EQU  H'3FEF'
EQU  H'3FEF'
EQU  H'3FFC'
; LP oscillator
; LP oscillator
; XT oscillator
; XT oscillator
; HS oscillator
; HS oscillator
; EXTCLK; port I/O function on OSC2/CLKO/RA6
; EXTCLK; port I/O function on OSC2/CLKO/RA6
; INTRC oscillator; port I/O function on
; INTRC oscillator; port I/O function on
; INTRC oscillator; CLKO function on
10

_WDTE_OFF
_WDT_OFF
_WDTE_ON
_WDT_ON
_PWRTE_ON
_PWRTE_OFF
_MCLRE_OFF
only, MCLR gated to '1'
_MCLR_OFF            EQU  H'3FDF'
only, MCLR gated to '1'
_CCP2MX_RB3
_CCP2_RB3
_CCP2MX_RC1
_CCP2_RC1
_CP_ON
_CP_ALL
_CP_OFF
EQU  H'2FFF'
EQU  H'2FFF'
EQU  H'3FFF'
EQU  H'3FFF'
EQU  H'1FFF'
EQU  H'1FFF'
EQU  H'3FFF'
EQU  H'3FFB'
EQU  H'3FFB'
EQU  H'3FFF'
EQU  H'3FFF'
EQU  H'3FF7'
EQU  H'3FFF'
; WDT disabled
; WDT disabled
; WDT enabled
; WDT enabled
; PWRT enabled
; PWRT disabled
; MCLR/VPP/RE3 pin function is digital input
; MCLR/VPP/RE3 pin function is digital input
; MCLR/VPP/RE3 pin function is MCLR
; MCLR/VPP/RE3 pin function is MCLR
; Disabled
; Disabled
; Enabled
; Enabled
; VBOR set to 4.5V
; VBOR set to 4.5V
; VBOR set to 4.2V
; VBOR set to 4.2V
; VBOR set to 2.7V
; VBOR set to 2.7V
; VBOR set to 2.0V
; VBOR set to 2.0V
; In-Circuit Debugger enabled, RB6 and RB7 are
; In-Circuit Debugger disabled, RB6 and RB7 are
;CCP2isonRB3 ;CCP2isonRB3 ;CCP2isonRC1 ;CCP2isonRC1
; 0000h to 0FFFh code-protected
; 0000h to 0FFFh code-protected
; Code protection off
 _MCLRE_ON
_MCLR_ON
_BOREN_OFF
_BOREN_0
_BOREN_ON
_BOREN_1
_BORV_45
_VBOR_4_5
_BORV_42
_VBOR_4_2
_BORV_27
_VBOR_2_7
_BORV_20
_VBOR_2_0
_DEBUG_ON
dedicated to the debugger
_DEBUG_OFF           EQU  H'3FFF'
general purpose I/O pins
EQU H'3FDF'
EQU  H'3FFF'
EQU  H'3FFF'
EQU  H'3FBF'
EQU  H'3FBF'
EQU  H'3FFF'
EQU  H'3FFF'
EQU  H'3E7F'
EQU  H'3E7F'
EQU  H'3EFF'
EQU  H'3EFF'
EQU  H'3F7F'
EQU  H'3F7F'
EQU  H'3FFF'
EQU  H'3FFF'
EQU H'37FF'
;----- CONFIG2 Options --------------------------------------------------
_FCMEN_OFF
_FCMEN_ON
_IESO_OFF
_IESO_ON
_BORSEN_OFF
_BORSEN_0
_BORSEN_ON
_BORSEN_1
EQU  H'3FFE'
EQU  H'3FFF'
EQU  H'3FFD'
EQU  H'3FFF'
EQU  H'3FBF'
EQU  H'3FBF'
EQU  H'3FFF'
EQU  H'3FFF'
; Fail-Safe Clock Monitor disabled
; Fail-Safe Clock Monitor enabled
; Internal External Switchover mode disabled
; Internal External Switchover mode enabled
; Disabled
; Disabled
; Enabled
; Enabled
;----- DEVID Equates --------------------------------------------------
_DEVID1          EQU  H'2006'
11

;----- IDLOC Equates --------------------------------------------------
 _IDLOC0
_IDLOC1
_IDLOC2
_IDLOC3
EQU  H'2000'
EQU  H'2001'
EQU  H'2002'
EQU  H'2003'
LIST
12

