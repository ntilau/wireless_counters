;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Mar 22 2009) (MINGW32)
; This file was generated Tue Sep 07 18:33:38 2010
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f4620
	__config 0x300001, 0xb8
	__config 0x300002, 0xf9
	__config 0x300003, 0xfe
	__config 0x300005, 0x7d
	__config 0x300006, 0x81

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _checksum
	global _round
	global _fifo
	global _idx
	global _timeOut
	global _Port1
	global _Port2
	global _Port3
	global _Port4
	global _delay_us
	global _delay_ms
	global _delay_s
	global _blinkLed
	global _spi_trx
	global _wr_register
	global _wr_command
	global _en_rx
	global _en_tx
	global _en_idle
	global _timer0_isr
	global _main

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern __gptrput1
	extern _PORTAbits
	extern _PORTBbits
	extern _PORTCbits
	extern _PORTDbits
	extern _PORTEbits
	extern _LATAbits
	extern _LATBbits
	extern _LATCbits
	extern _LATDbits
	extern _LATEbits
	extern _TRISAbits
	extern _TRISBbits
	extern _TRISCbits
	extern _TRISDbits
	extern _TRISEbits
	extern _OSCTUNEbits
	extern _PIE1bits
	extern _PIR1bits
	extern _IPR1bits
	extern _PIE2bits
	extern _PIR2bits
	extern _IPR2bits
	extern _EECON1bits
	extern _RCSTAbits
	extern _TXSTAbits
	extern _T3CONbits
	extern _CMCONbits
	extern _CVRCONbits
	extern _ECCP1ASbits
	extern _PWM1CONbits
	extern _BAUDCONbits
	extern _CCP2CONbits
	extern _CCP1CONbits
	extern _ADCON2bits
	extern _ADCON1bits
	extern _ADCON0bits
	extern _SSPCON2bits
	extern _SSPCON1bits
	extern _SSPSTATbits
	extern _T2CONbits
	extern _T1CONbits
	extern _RCONbits
	extern _WDTCONbits
	extern _HLVDCONbits
	extern _OSCCONbits
	extern _T0CONbits
	extern _STATUSbits
	extern _FSR2Hbits
	extern _BSRbits
	extern _FSR1Hbits
	extern _FSR0Hbits
	extern _INTCON3bits
	extern _INTCON2bits
	extern _INTCONbits
	extern _TBLPTRUbits
	extern _PCLATHbits
	extern _PCLATUbits
	extern _STKPTRbits
	extern _TOSUbits
	extern _stdin
	extern _stdout
	extern _PORTA
	extern _PORTB
	extern _PORTC
	extern _PORTD
	extern _PORTE
	extern _LATA
	extern _LATB
	extern _LATC
	extern _LATD
	extern _LATE
	extern _TRISA
	extern _TRISB
	extern _TRISC
	extern _TRISD
	extern _TRISE
	extern _OSCTUNE
	extern _PIE1
	extern _PIR1
	extern _IPR1
	extern _PIE2
	extern _PIR2
	extern _IPR2
	extern _EECON1
	extern _EECON2
	extern _EEDATA
	extern _EEADR
	extern _EEADRH
	extern _RCSTA
	extern _TXSTA
	extern _TXREG
	extern _RCREG
	extern _SPBRG
	extern _SPBRGH
	extern _T3CON
	extern _TMR3L
	extern _TMR3H
	extern _CMCON
	extern _CVRCON
	extern _ECCP1AS
	extern _PWM1CON
	extern _BAUDCON
	extern _CCP2CON
	extern _CCPR2L
	extern _CCPR2H
	extern _CCP1CON
	extern _CCPR1L
	extern _CCPR1H
	extern _ADCON2
	extern _ADCON1
	extern _ADCON0
	extern _ADRESL
	extern _ADRESH
	extern _SSPCON2
	extern _SSPCON1
	extern _SSPSTAT
	extern _SSPADD
	extern _SSPBUF
	extern _T2CON
	extern _PR2
	extern _TMR2
	extern _T1CON
	extern _TMR1L
	extern _TMR1H
	extern _RCON
	extern _WDTCON
	extern _HLVDCON
	extern _OSCCON
	extern _T0CON
	extern _TMR0L
	extern _TMR0H
	extern _STATUS
	extern _FSR2L
	extern _FSR2H
	extern _PLUSW2
	extern _PREINC2
	extern _POSTDEC2
	extern _POSTINC2
	extern _INDF2
	extern _BSR
	extern _FSR1L
	extern _FSR1H
	extern _PLUSW1
	extern _PREINC1
	extern _POSTDEC1
	extern _POSTINC1
	extern _INDF1
	extern _WREG
	extern _FSR0L
	extern _FSR0H
	extern _PLUSW0
	extern _PREINC0
	extern _POSTDEC0
	extern _POSTINC0
	extern _INDF0
	extern _INTCON3
	extern _INTCON2
	extern _INTCON
	extern _PRODL
	extern _PRODH
	extern _TABLAT
	extern _TBLPTRL
	extern _TBLPTRH
	extern _TBLPTRU
	extern _PCL
	extern _PCLATH
	extern _PCLATU
	extern _STKPTR
	extern _TOSL
	extern _TOSH
	extern _TOSU
	extern _delay1ktcy
	extern _delay1mtcy
	extern __mulint
	extern __divuint
	extern __moduint
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCL	equ	0xff9
PCLATH	equ	0xffa
PCLATU	equ	0xffb
WREG	equ	0xfe8
BSR	equ	0xfe0
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3
PRODH	equ	0xff4


	idata
_checksum	db	0x00
_round	db	0x01
_idx	db	0x00
_Port1	db	0x00, 0x00, 0x00, 0x00
_Port2	db	0x00, 0x00, 0x00, 0x00
_Port3	db	0x00, 0x00, 0x00, 0x00
_Port4	db	0x00, 0x00, 0x00, 0x00


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1

udata_main_0	udata
_timeOut	res	1

udata_main_1	udata
_fifo	res	6

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; ; Starting pCode block for absolute section
; ;-----------------------------------------
S_main_ivec_0x1_timer0_isr	code	0X000008
ivec_0x1_timer0_isr:
	GOTO	_timer0_isr

; I code from now on!
; ; Starting pCode block
S_main__main	code
_main:
;	.line	222; main.c	OSCCONbits.IRCF = 7;
	MOVF	_OSCCONbits, W
	ANDLW	0x8f
	IORLW	0x70
	MOVWF	_OSCCONbits
;	.line	223; main.c	delay1ktcy(1);
	MOVLW	0x01
	CALL	_delay1ktcy
;	.line	225; main.c	ADCON1 = 0x0F;
	MOVLW	0x0f
	MOVWF	_ADCON1
;	.line	229; main.c	PS1_1_TRIS = 0;
	BCF	_TRISBbits, 7
;	.line	230; main.c	PS1_2_TRIS = 0;
	BCF	_TRISBbits, 6
;	.line	231; main.c	PS1_3_TRIS = 0;
	BCF	_TRISBbits, 5
;	.line	232; main.c	PS1_4_TRIS = 0;
	BCF	_TRISBbits, 4
;	.line	234; main.c	PS2_1_TRIS = 0;
	BCF	_TRISBbits, 3
;	.line	235; main.c	PS2_2_TRIS = 0;
	BCF	_TRISAbits, 0
;	.line	236; main.c	PS2_3_TRIS = 0;
	BCF	_TRISAbits, 1
;	.line	237; main.c	PS2_4_TRIS = 0;
	BCF	_TRISAbits, 2
;	.line	239; main.c	PS3_1_TRIS = 0;
	BCF	_TRISAbits, 3
;	.line	240; main.c	PS3_2_TRIS = 0;
	BCF	_TRISAbits, 4
;	.line	241; main.c	PS3_3_TRIS = 0;
	BCF	_TRISAbits, 5
;	.line	242; main.c	PS3_4_TRIS = 0;
	BCF	_TRISEbits, 0
;	.line	244; main.c	PS4_1_TRIS = 0;
	BCF	_TRISEbits, 1
;	.line	245; main.c	PS4_2_TRIS = 0;
	BCF	_TRISEbits, 2
;	.line	246; main.c	PS4_3_TRIS = 0;
	BCF	_TRISDbits, 7
;	.line	247; main.c	PS4_4_TRIS = 0;
	BCF	_TRISDbits, 6
;	.line	249; main.c	PS1_1 = 0;
	BCF	_PORTBbits, 7
;	.line	250; main.c	PS1_2 = 0;
	BCF	_PORTBbits, 6
;	.line	251; main.c	PS1_3 = 0;
	BCF	_PORTBbits, 5
;	.line	252; main.c	PS1_4 = 0;
	BCF	_PORTBbits, 4
;	.line	254; main.c	PS2_1 = 0;
	BCF	_PORTBbits, 3
;	.line	255; main.c	PS2_2 = 0;
	BCF	_PORTAbits, 0
;	.line	256; main.c	PS2_3 = 0;
	BCF	_PORTAbits, 1
;	.line	257; main.c	PS2_4 = 0;
	BCF	_PORTAbits, 2
;	.line	259; main.c	PS3_1 = 0;
	BCF	_PORTAbits, 3
;	.line	260; main.c	PS3_2 = 0;
	BCF	_PORTAbits, 4
;	.line	261; main.c	PS3_3 = 0;
	BCF	_PORTAbits, 5
;	.line	262; main.c	PS3_4 = 0;
	BCF	_PORTEbits, 0
;	.line	264; main.c	PS4_1 = 0;
	BCF	_PORTEbits, 1
;	.line	265; main.c	PS4_2 = 0;
	BCF	_PORTEbits, 2
;	.line	266; main.c	PS4_3 = 0;
	BCF	_PORTDbits, 7
;	.line	267; main.c	PS4_4 = 0;
	BCF	_PORTDbits, 6
;	.line	270; main.c	unused1_TRIS = 0;
	BCF	_TRISDbits, 5
;	.line	271; main.c	unused2_TRIS = 0;
	BCF	_TRISDbits, 4
;	.line	272; main.c	unused3_TRIS = 0;
	BCF	_TRISDbits, 3
;	.line	273; main.c	unused4_TRIS = 0;
	BCF	_TRISDbits, 2
;	.line	274; main.c	unused5_TRIS = 0;
	BCF	_TRISDbits, 1
;	.line	275; main.c	unused6_TRIS = 0;
	BCF	_TRISDbits, 0
;	.line	277; main.c	unused1 = 0;
	BCF	_PORTDbits, 5
;	.line	278; main.c	unused2 = 0;
	BCF	_PORTDbits, 4
;	.line	279; main.c	unused3 = 0;
	BCF	_PORTDbits, 3
;	.line	280; main.c	unused4 = 0;
	BCF	_PORTDbits, 2
;	.line	281; main.c	unused5 = 0;
	BCF	_PORTDbits, 1
;	.line	282; main.c	unused6 = 0;
	BCF	_PORTDbits, 0
;	.line	285; main.c	TRISAbits.TRISA6 = 0; // LED output
	BCF	_TRISAbits, 6
;	.line	286; main.c	LED = 0; // output low
	BCF	_PORTAbits, 6
;	.line	289; main.c	TRISCbits.TRISC0 = 0; // nRES
	BCF	_TRISCbits, 0
;	.line	290; main.c	TRISCbits.TRISC1 = 0; // nFFS
	BCF	_TRISCbits, 1
;	.line	291; main.c	nRES = 1;
	BSF	_PORTCbits, 0
;	.line	292; main.c	nFFS = 1;
	BSF	_PORTCbits, 1
;	.line	314; main.c	TRISCbits.TRISC5 = 0; // SDO
	BCF	_TRISCbits, 5
;	.line	315; main.c	TRISCbits.TRISC4 = 1; // SDI
	BSF	_TRISCbits, 4
;	.line	316; main.c	TRISCbits.TRISC3 = 0; // SCK
	BCF	_TRISCbits, 3
;	.line	317; main.c	TRISCbits.TRISC2 = 0; // nSEL
	BCF	_TRISCbits, 2
;	.line	318; main.c	nSEL = 1;
	BSF	_PORTCbits, 2
;	.line	319; main.c	SSPCON1bits.SSPEN = 1; // enable SPI
	BSF	_SSPCON1bits, 5
;	.line	320; main.c	SSPCON1bits.CKP = 0; // idle bit low
	BCF	_SSPCON1bits, 4
;	.line	321; main.c	SSPCON1bits.SSPM0 = 0; // cleared Fosc/4 master mode. set for Fosc/16
	BCF	_SSPCON1bits, 0
;	.line	322; main.c	SSPSTATbits.SMP = 0; // sampled in the middle
	BCF	_SSPSTATbits, 7
;	.line	323; main.c	SSPSTATbits.CKE = 1; // transmit for idle to active
	BSF	_SSPSTATbits, 6
;	.line	324; main.c	SSPCON1bits.WCOL = 0;
	BCF	_SSPCON1bits, 7
;	.line	325; main.c	PIE1bits.SSPIE = 1; // enable SPI flag
	BSF	_PIE1bits, 3
;	.line	328; main.c	delay_ms(100);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x64
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	329; main.c	nRES = 0;
	BCF	_PORTCbits, 0
;	.line	330; main.c	delay_ms(10);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	331; main.c	nRES = 1;
	BSF	_PORTCbits, 0
;	.line	332; main.c	delay_ms(100);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x64
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	333; main.c	wr_command(0x00, 0x00); // clear POR interrupt by getting status
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	334; main.c	delay_ms(100);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x64
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	337; main.c	wr_command(0x80, 0x28); // Config setting command all FIFO + 868 + 12.5pF
	MOVLW	0x28
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	338; main.c	wr_command(0x82, 0x09); // Power Management Command. Idle + noClkOut
	MOVLW	0x09
	MOVWF	POSTDEC1
	MOVLW	0x82
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	339; main.c	wr_command(0xCA, 0x82); // FIFO fill when Synchon Pattern received. 2 bytes Synchon
	MOVLW	0x82
	MOVWF	POSTDEC1
	MOVLW	0xca
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	340; main.c	wr_command(0xCE, 0xA5); // Set 2nd byte to 0xA5
	MOVLW	0xa5
	MOVWF	POSTDEC1
	MOVLW	0xce
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	343; main.c	T0CONbits.T08BIT = 0;
	BCF	_T0CONbits, 6
;	.line	344; main.c	T0CONbits.T0CS = 0;
	BCF	_T0CONbits, 5
;	.line	345; main.c	T0CONbits.PSA = 0;
	BCF	_T0CONbits, 3
;	.line	346; main.c	T0CONbits.T0PS0 = 1;
	BSF	_T0CONbits, 0
;	.line	347; main.c	T0CONbits.T0PS1 = 1;
	BSF	_T0CONbits, 1
;	.line	348; main.c	T0CONbits.T0PS2 = 1;
	BSF	_T0CONbits, 2
;	.line	349; main.c	T0CONbits.TMR0ON = 0;
	BCF	_T0CONbits, 7
;	.line	350; main.c	INTCONbits.TMR0IF = 0;
	BCF	_INTCONbits, 2
;	.line	351; main.c	INTCONbits.TMR0IE = 1;
	BSF	_INTCONbits, 5
;	.line	352; main.c	INTCONbits.GIE = 1; // global interrupts
	BSF	_INTCONbits, 7
;	.line	354; main.c	blinkLed(5);
	MOVLW	0x05
	MOVWF	POSTDEC1
	CALL	_blinkLed
	INCF	FSR1L, F
;	.line	356; main.c	round = 0x01;
	MOVLW	0x01
	BANKSEL	_round
	MOVWF	_round, B
_00258_DS_:
;	.line	361; main.c	en_tx();
	CALL	_en_tx
_00190_DS_:
;	.line	362; main.c	while(nIRQ);
	BTFSC	_PORTBbits, 0
	BRA	_00190_DS_
;	.line	363; main.c	wr_command(0xB8, 0x2D);
	MOVLW	0x2d
	MOVWF	POSTDEC1
	MOVLW	0xb8
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
_00193_DS_:
;	.line	364; main.c	while(nIRQ);
	BTFSC	_PORTBbits, 0
	BRA	_00193_DS_
;	.line	365; main.c	wr_command(0xB8, 0xA5);
	MOVLW	0xa5
	MOVWF	POSTDEC1
	MOVLW	0xb8
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
_00196_DS_:
;	.line	366; main.c	while(nIRQ);
	BTFSC	_PORTBbits, 0
	BRA	_00196_DS_
;	.line	367; main.c	wr_command(0xB8, 0x5A);
	MOVLW	0x5a
	MOVWF	POSTDEC1
	MOVLW	0xb8
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
_00199_DS_:
;	.line	368; main.c	while(nIRQ);
	BTFSC	_PORTBbits, 0
	BRA	_00199_DS_
	BANKSEL	_round
;	.line	369; main.c	wr_command(0xB8, round);
	MOVF	_round, W, B
	MOVWF	POSTDEC1
	MOVLW	0xb8
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
_00202_DS_:
;	.line	370; main.c	while(nIRQ);
	BTFSC	_PORTBbits, 0
	BRA	_00202_DS_
;	.line	371; main.c	wr_command(0xB8, 0xEF);
	MOVLW	0xef
	MOVWF	POSTDEC1
	MOVLW	0xb8
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
_00205_DS_:
;	.line	372; main.c	while(nIRQ);
	BTFSC	_PORTBbits, 0
	BRA	_00205_DS_
;	.line	373; main.c	en_idle();
	CALL	_en_idle
	BANKSEL	_idx
;	.line	376; main.c	idx = 0;
	CLRF	_idx, B
;	.line	377; main.c	en_rx();
	CALL	_en_rx
	BANKSEL	_timeOut
;	.line	378; main.c	timeOut = 0;
	CLRF	_timeOut, B
;	.line	379; main.c	T0CONbits.TMR0ON = 1;
	BSF	_T0CONbits, 7
;	.line	380; main.c	TMR0H = 0xF0;
	MOVLW	0xf0
	MOVWF	_TMR0H
;	.line	381; main.c	TMR0L = 0x00;
	CLRF	_TMR0L
_00211_DS_:
;	.line	382; main.c	while( (idx < 6) & !timeOut){
	MOVLW	0x06
	BANKSEL	_idx
	SUBWF	_idx, W, B
	BTG	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	BANKSEL	_timeOut
	MOVF	_timeOut, W, B
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x01
	RLCF	r0x01, F
	MOVF	r0x01, W
	ANDWF	r0x00, F
	MOVF	r0x00, W
	BZ	_00213_DS_
_00208_DS_:
;	.line	383; main.c	while(!FFIT & !timeOut);
	CLRF	r0x00
	BTFSC	_PORTBbits, 2
	INCF	r0x00, F
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	BANKSEL	_timeOut
	MOVF	_timeOut, W, B
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x01
	RLCF	r0x01, F
	MOVF	r0x01, W
	ANDWF	r0x00, F
	MOVF	r0x00, W
	BNZ	_00208_DS_
;	.line	384; main.c	nFFS = 0;
	BCF	_PORTCbits, 1
;	.line	385; main.c	fifo[idx++] = spi_trx(0x00);
	MOVFF	_idx, r0x00
	BANKSEL	_idx
	INCF	_idx, F, B
	CLRF	r0x01
	MOVLW	LOW(_fifo)
	ADDWF	r0x00, F
	MOVLW	HIGH(_fifo)
	ADDWFC	r0x01, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_spi_trx
	MOVWF	r0x02
	INCF	FSR1L, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	r0x02, INDF0
;	.line	386; main.c	nFFS = 1;
	BSF	_PORTCbits, 1
	BRA	_00211_DS_
_00213_DS_:
;	.line	388; main.c	T0CONbits.TMR0ON = 0;
	BCF	_T0CONbits, 7
;	.line	389; main.c	en_idle();
	CALL	_en_idle
	BANKSEL	_timeOut
;	.line	390; main.c	if(timeOut) {
	MOVF	_timeOut, W, B
	BZ	_00215_DS_
	BANKSEL	_timeOut
;	.line	391; main.c	timeOut = 0;
	CLRF	_timeOut, B
;	.line	392; main.c	LED = 1;
	BSF	_PORTAbits, 6
_00215_DS_:
	BANKSEL	_fifo
;	.line	396; main.c	if(fifo[0] == 0x5A)
	MOVF	_fifo, W, B
	XORLW	0x5a
	BZ	_00332_DS_
	BRA	_00224_DS_
_00332_DS_:
	BANKSEL	_checksum
;	.line	398; main.c	checksum = 0;
	CLRF	_checksum, B
;	.line	399; main.c	for(idx=1; idx<5; idx++)
	MOVLW	0x01
	BANKSEL	_idx
	MOVWF	_idx, B
_00260_DS_:
	MOVLW	0x05
	BANKSEL	_idx
	SUBWF	_idx, W, B
	BC	_00263_DS_
;	.line	401; main.c	checksum += fifo[idx];        
	MOVLW	LOW(_fifo)
	BANKSEL	_idx
	ADDWF	_idx, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	HIGH(_fifo)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
	BANKSEL	_checksum
	ADDWF	_checksum, F, B
	BANKSEL	_idx
;	.line	399; main.c	for(idx=1; idx<5; idx++)
	INCF	_idx, F, B
	BRA	_00260_DS_
_00263_DS_:
	BANKSEL	_checksum
;	.line	403; main.c	if(checksum == fifo[5])
	MOVF	_checksum, W, B
	BANKSEL	(_fifo + 5)
	XORWF	(_fifo + 5), W, B
	BZ	_00335_DS_
	BRA	_00224_DS_
_00335_DS_:
;	.line	405; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	406; main.c	switch(round)
	MOVLW	0x01
	BANKSEL	_round
	SUBWF	_round, W, B
	BTFSS	STATUS, 0
	BRA	_00220_DS_
	MOVLW	0x05
	BANKSEL	_round
	SUBWF	_round, W, B
	BTFSC	STATUS, 0
	BRA	_00220_DS_
	BANKSEL	_round
	DECF	_round, W, B
	MOVWF	r0x00
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	CLRF	r0x04
	RLCF	r0x00, W
	RLCF	r0x04, F
	RLCF	WREG, W
	RLCF	r0x04, F
	ANDLW	0xfc
	MOVWF	r0x03
	MOVLW	UPPER(_00338_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00338_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00338_DS_)
	ADDWF	r0x03, F
	MOVF	r0x04, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x03, W
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVWF	PCL
_00338_DS_:
	GOTO	_00216_DS_
	GOTO	_00217_DS_
	GOTO	_00218_DS_
	GOTO	_00219_DS_
_00216_DS_:
	BANKSEL	_idx
;	.line	409; main.c	for(idx=0; idx<4; idx++) Port1[idx]+=fifo[idx+1];
	CLRF	_idx, B
_00264_DS_:
	MOVLW	0x04
	BANKSEL	_idx
	SUBWF	_idx, W, B
	BC	_00217_DS_
	MOVLW	LOW(_Port1)
	BANKSEL	_idx
	ADDWF	_idx, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	HIGH(_Port1)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x02
	BANKSEL	_idx
	INCF	_idx, W, B
	MOVWF	r0x03
	MOVLW	LOW(_fifo)
	ADDWF	r0x03, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	HIGH(_fifo)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	INDF0, r0x04
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	r0x02, INDF0
	MOVFF	r0x03, _idx
	BRA	_00264_DS_
_00217_DS_:
	BANKSEL	_idx
;	.line	411; main.c	for(idx=0; idx<4; idx++) Port2[idx]+=fifo[idx+1];
	CLRF	_idx, B
_00268_DS_:
	MOVLW	0x04
	BANKSEL	_idx
	SUBWF	_idx, W, B
	BC	_00218_DS_
	MOVLW	LOW(_Port2)
	BANKSEL	_idx
	ADDWF	_idx, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	HIGH(_Port2)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x02
	BANKSEL	_idx
	INCF	_idx, W, B
	MOVWF	r0x03
	MOVLW	LOW(_fifo)
	ADDWF	r0x03, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	HIGH(_fifo)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	INDF0, r0x04
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	r0x02, INDF0
	MOVFF	r0x03, _idx
	BRA	_00268_DS_
_00218_DS_:
	BANKSEL	_idx
;	.line	413; main.c	for(idx=0; idx<4; idx++) Port3[idx]+=fifo[idx+1];
	CLRF	_idx, B
_00272_DS_:
	MOVLW	0x04
	BANKSEL	_idx
	SUBWF	_idx, W, B
	BC	_00219_DS_
	MOVLW	LOW(_Port3)
	BANKSEL	_idx
	ADDWF	_idx, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	HIGH(_Port3)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x02
	BANKSEL	_idx
	INCF	_idx, W, B
	MOVWF	r0x03
	MOVLW	LOW(_fifo)
	ADDWF	r0x03, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	HIGH(_fifo)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	INDF0, r0x04
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	r0x02, INDF0
	MOVFF	r0x03, _idx
	BRA	_00272_DS_
_00219_DS_:
	BANKSEL	_idx
;	.line	415; main.c	for(idx=0; idx<4; idx++) Port4[idx]+=fifo[idx+1];
	CLRF	_idx, B
_00276_DS_:
	MOVLW	0x04
	BANKSEL	_idx
	SUBWF	_idx, W, B
	BC	_00220_DS_
	MOVLW	LOW(_Port4)
	BANKSEL	_idx
	ADDWF	_idx, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	HIGH(_Port4)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x02
	BANKSEL	_idx
	INCF	_idx, W, B
	MOVWF	r0x03
	MOVLW	LOW(_fifo)
	ADDWF	r0x03, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	HIGH(_fifo)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	INDF0, r0x04
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	r0x02, INDF0
	MOVFF	r0x03, _idx
	BRA	_00276_DS_
_00220_DS_:
;	.line	417; main.c	LED = 0;
	BCF	_PORTAbits, 6
_00224_DS_:
	BANKSEL	_Port1
;	.line	422; main.c	if(Port1[0])
	MOVF	_Port1, W, B
	BZ	_00226_DS_
;	.line	424; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	425; main.c	PS1_1 = 1;
	BSF	_PORTBbits, 7
;	.line	426; main.c	delay_ms(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	427; main.c	PS1_1 = 0;
	BCF	_PORTBbits, 7
;	.line	428; main.c	Port1[0]--;
	MOVFF	_Port1, r0x00
	DECF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	_Port1
	MOVWF	_Port1, B
;	.line	429; main.c	LED = 0;
	BCF	_PORTAbits, 6
_00226_DS_:
	BANKSEL	(_Port1 + 1)
;	.line	431; main.c	if(Port1[1])
	MOVF	(_Port1 + 1), W, B
	BZ	_00228_DS_
;	.line	433; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	434; main.c	PS1_2 = 1;
	BSF	_PORTBbits, 6
;	.line	435; main.c	delay_ms(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	436; main.c	PS1_2 = 0;
	BCF	_PORTBbits, 6
;	.line	437; main.c	Port1[1]--;
	MOVFF	(_Port1 + 1), r0x00
	DECF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	(_Port1 + 1)
	MOVWF	(_Port1 + 1), B
;	.line	438; main.c	LED = 0;
	BCF	_PORTAbits, 6
_00228_DS_:
	BANKSEL	(_Port1 + 2)
;	.line	440; main.c	if(Port1[2])
	MOVF	(_Port1 + 2), W, B
	BZ	_00230_DS_
;	.line	442; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	443; main.c	PS1_3 = 1;
	BSF	_PORTBbits, 5
;	.line	444; main.c	delay_ms(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	445; main.c	PS1_3 = 0;
	BCF	_PORTBbits, 5
;	.line	446; main.c	Port1[2]--;
	MOVFF	(_Port1 + 2), r0x00
	DECF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	(_Port1 + 2)
	MOVWF	(_Port1 + 2), B
;	.line	447; main.c	LED = 0;
	BCF	_PORTAbits, 6
_00230_DS_:
	BANKSEL	(_Port1 + 3)
;	.line	449; main.c	if(Port1[3])
	MOVF	(_Port1 + 3), W, B
	BZ	_00232_DS_
;	.line	451; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	452; main.c	PS1_4 = 1;
	BSF	_PORTBbits, 4
;	.line	453; main.c	delay_ms(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	454; main.c	PS1_4 = 0;
	BCF	_PORTBbits, 4
;	.line	455; main.c	Port1[3]--;
	MOVFF	(_Port1 + 3), r0x00
	DECF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	(_Port1 + 3)
	MOVWF	(_Port1 + 3), B
;	.line	456; main.c	LED = 0;
	BCF	_PORTAbits, 6
_00232_DS_:
	BANKSEL	_Port2
;	.line	460; main.c	if(Port2[0])
	MOVF	_Port2, W, B
	BZ	_00234_DS_
;	.line	462; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	463; main.c	PS2_1 = 1;
	BSF	_PORTBbits, 3
;	.line	464; main.c	delay_ms(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	465; main.c	PS2_1 = 0;
	BCF	_PORTBbits, 3
;	.line	466; main.c	Port2[0]--;
	MOVFF	_Port2, r0x00
	DECF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	_Port2
	MOVWF	_Port2, B
;	.line	467; main.c	LED = 0;
	BCF	_PORTAbits, 6
_00234_DS_:
	BANKSEL	(_Port2 + 1)
;	.line	469; main.c	if(Port2[1])
	MOVF	(_Port2 + 1), W, B
	BZ	_00236_DS_
;	.line	471; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	472; main.c	PS2_2 = 1;
	BSF	_PORTAbits, 0
;	.line	473; main.c	delay_ms(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	474; main.c	PS2_2 = 0;
	BCF	_PORTAbits, 0
;	.line	475; main.c	Port2[1]--;
	MOVFF	(_Port2 + 1), r0x00
	DECF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	(_Port2 + 1)
	MOVWF	(_Port2 + 1), B
;	.line	476; main.c	LED = 0;
	BCF	_PORTAbits, 6
_00236_DS_:
	BANKSEL	(_Port2 + 2)
;	.line	478; main.c	if(Port2[2])
	MOVF	(_Port2 + 2), W, B
	BZ	_00238_DS_
;	.line	480; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	481; main.c	PS2_3 = 1;
	BSF	_PORTAbits, 1
;	.line	482; main.c	delay_ms(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	483; main.c	PS2_3 = 0;
	BCF	_PORTAbits, 1
;	.line	484; main.c	Port2[2]--;
	MOVFF	(_Port2 + 2), r0x00
	DECF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	(_Port2 + 2)
	MOVWF	(_Port2 + 2), B
;	.line	485; main.c	LED = 0;
	BCF	_PORTAbits, 6
_00238_DS_:
	BANKSEL	(_Port2 + 3)
;	.line	487; main.c	if(Port2[3])
	MOVF	(_Port2 + 3), W, B
	BZ	_00240_DS_
;	.line	489; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	490; main.c	PS2_4 = 1;
	BSF	_PORTAbits, 2
;	.line	491; main.c	delay_ms(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	492; main.c	PS2_4 = 0;
	BCF	_PORTAbits, 2
;	.line	493; main.c	Port2[3]--;
	MOVFF	(_Port2 + 3), r0x00
	DECF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	(_Port2 + 3)
	MOVWF	(_Port2 + 3), B
;	.line	494; main.c	LED = 0;
	BCF	_PORTAbits, 6
_00240_DS_:
	BANKSEL	_Port3
;	.line	498; main.c	if(Port3[0])
	MOVF	_Port3, W, B
	BZ	_00242_DS_
;	.line	500; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	501; main.c	PS3_1 = 1;
	BSF	_PORTAbits, 3
;	.line	502; main.c	delay_ms(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	503; main.c	PS3_1 = 0;
	BCF	_PORTAbits, 3
;	.line	504; main.c	Port3[0]--;
	MOVFF	_Port3, r0x00
	DECF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	_Port3
	MOVWF	_Port3, B
;	.line	505; main.c	LED = 0;
	BCF	_PORTAbits, 6
_00242_DS_:
	BANKSEL	(_Port3 + 1)
;	.line	507; main.c	if(Port3[1])
	MOVF	(_Port3 + 1), W, B
	BZ	_00244_DS_
;	.line	509; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	510; main.c	PS3_2 = 1;
	BSF	_PORTAbits, 4
;	.line	511; main.c	delay_ms(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	512; main.c	PS3_2 = 0;
	BCF	_PORTAbits, 4
;	.line	513; main.c	Port3[1]--;
	MOVFF	(_Port3 + 1), r0x00
	DECF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	(_Port3 + 1)
	MOVWF	(_Port3 + 1), B
;	.line	514; main.c	LED = 0;
	BCF	_PORTAbits, 6
_00244_DS_:
	BANKSEL	(_Port3 + 2)
;	.line	516; main.c	if(Port3[2])
	MOVF	(_Port3 + 2), W, B
	BZ	_00246_DS_
;	.line	518; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	519; main.c	PS3_3 = 1;
	BSF	_PORTAbits, 5
;	.line	520; main.c	delay_ms(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	521; main.c	PS3_3 = 0;
	BCF	_PORTAbits, 5
;	.line	522; main.c	Port3[2]--;
	MOVFF	(_Port3 + 2), r0x00
	DECF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	(_Port3 + 2)
	MOVWF	(_Port3 + 2), B
;	.line	523; main.c	LED = 0;
	BCF	_PORTAbits, 6
_00246_DS_:
	BANKSEL	(_Port3 + 3)
;	.line	525; main.c	if(Port3[3])
	MOVF	(_Port3 + 3), W, B
	BZ	_00248_DS_
;	.line	527; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	528; main.c	PS3_4 = 1;
	BSF	_PORTEbits, 0
;	.line	529; main.c	delay_ms(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	530; main.c	PS3_4 = 0;
	BCF	_PORTEbits, 0
;	.line	531; main.c	Port3[3]--;
	MOVFF	(_Port3 + 3), r0x00
	DECF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	(_Port3 + 3)
	MOVWF	(_Port3 + 3), B
;	.line	532; main.c	LED = 0;
	BCF	_PORTAbits, 6
_00248_DS_:
	BANKSEL	_Port4
;	.line	536; main.c	if(Port4[0])
	MOVF	_Port4, W, B
	BZ	_00250_DS_
;	.line	538; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	539; main.c	PS4_1 = 1;
	BSF	_PORTEbits, 1
;	.line	540; main.c	delay_ms(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	541; main.c	PS4_1 = 0;
	BCF	_PORTEbits, 1
;	.line	542; main.c	Port4[0]--;
	MOVFF	_Port4, r0x00
	DECF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	_Port4
	MOVWF	_Port4, B
;	.line	543; main.c	LED = 0;
	BCF	_PORTAbits, 6
_00250_DS_:
	BANKSEL	(_Port4 + 1)
;	.line	545; main.c	if(Port4[1])
	MOVF	(_Port4 + 1), W, B
	BZ	_00252_DS_
;	.line	547; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	548; main.c	PS4_2 = 1;
	BSF	_PORTEbits, 2
;	.line	549; main.c	delay_ms(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	550; main.c	PS4_2 = 0;
	BCF	_PORTEbits, 2
;	.line	551; main.c	Port4[1]--;
	MOVFF	(_Port4 + 1), r0x00
	DECF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	(_Port4 + 1)
	MOVWF	(_Port4 + 1), B
;	.line	552; main.c	LED = 0;
	BCF	_PORTAbits, 6
_00252_DS_:
	BANKSEL	(_Port4 + 2)
;	.line	554; main.c	if(Port4[2])
	MOVF	(_Port4 + 2), W, B
	BZ	_00254_DS_
;	.line	556; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	557; main.c	PS4_3 = 1;
	BSF	_PORTDbits, 7
;	.line	558; main.c	delay_ms(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	559; main.c	PS4_3 = 0;
	BCF	_PORTDbits, 7
;	.line	560; main.c	Port4[2]--;
	MOVFF	(_Port4 + 2), r0x00
	DECF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	(_Port4 + 2)
	MOVWF	(_Port4 + 2), B
;	.line	561; main.c	LED = 0;
	BCF	_PORTAbits, 6
_00254_DS_:
	BANKSEL	(_Port4 + 3)
;	.line	563; main.c	if(Port4[3])
	MOVF	(_Port4 + 3), W, B
	BZ	_00256_DS_
;	.line	565; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	566; main.c	PS4_4 = 1;
	BSF	_PORTDbits, 6
;	.line	567; main.c	delay_ms(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	568; main.c	PS4_4 = 0;
	BCF	_PORTDbits, 6
;	.line	569; main.c	Port4[3]--;
	MOVFF	(_Port4 + 3), r0x00
	DECF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	(_Port4 + 3)
	MOVWF	(_Port4 + 3), B
;	.line	570; main.c	LED = 0;
	BCF	_PORTAbits, 6
_00256_DS_:
	BANKSEL	_fifo
;	.line	574; main.c	fifo[0] = 0x00;
	CLRF	_fifo, B
;	.line	575; main.c	round %= 4;
	MOVLW	0x03
	BANKSEL	_round
	ANDWF	_round, F, B
	BANKSEL	_round
;	.line	576; main.c	round += 1;
	INCF	_round, F, B
	GOTO	_00258_DS_
	RETURN	

; ; Starting pCode block
S_main__timer0_isr	code
_timer0_isr:
;	.line	211; main.c	void timer0_isr(void) interrupt 1
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	213; main.c	INTCONbits.TMR0IE = 0;
	BCF	_INTCONbits, 5
;	.line	214; main.c	timeOut = 1;
	MOVLW	0x01
	BANKSEL	_timeOut
	MOVWF	_timeOut, B
;	.line	215; main.c	INTCONbits.TMR0IF = 0;
	BCF	_INTCONbits, 2
;	.line	216; main.c	INTCONbits.TMR0IE = 1;
	BSF	_INTCONbits, 5
	MOVFF	PREINC1, FSR2L
	MOVFF	PREINC1, PCLATU
	MOVFF	PREINC1, PCLATH
	MOVFF	PREINC1, FSR0H
	MOVFF	PREINC1, FSR0L
	MOVFF	PREINC1, PRODH
	MOVFF	PREINC1, PRODL
	MOVFF	PREINC1, BSR
	MOVFF	PREINC1, STATUS
	MOVFF	PREINC1, WREG
	RETFIE	

; ; Starting pCode block
S_main__en_idle	code
_en_idle:
;	.line	173; main.c	void en_idle(){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	174; main.c	wr_command(0x82, 0x59); // leaves BaseBand and Synthesizer active
	MOVLW	0x59
	MOVWF	POSTDEC1
	MOVLW	0x82
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	175; main.c	wr_command(0x80, 0x28);
	MOVLW	0x28
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__en_tx	code
_en_tx:
;	.line	168; main.c	void en_tx() {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	169; main.c	wr_command(0x80, 0xD8);
	MOVLW	0xd8
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	170; main.c	wr_command(0x82, 0x39);
	MOVLW	0x39
	MOVWF	POSTDEC1
	MOVLW	0x82
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__en_rx	code
_en_rx:
;	.line	163; main.c	void en_rx(){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	164; main.c	wr_command(0x80, 0x68);
	MOVLW	0x68
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	165; main.c	wr_command(0x82, 0xD9);
	MOVLW	0xd9
	MOVWF	POSTDEC1
	MOVLW	0x82
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__wr_command	code
_wr_command:
;	.line	147; main.c	void wr_command( uchar tx_uchar1, uchar tx_uchar2){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	148; main.c	nSEL = 0;
	BCF	_PORTCbits, 2
;	.line	149; main.c	spi_trx(tx_uchar1);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_spi_trx
	INCF	FSR1L, F
;	.line	150; main.c	spi_trx(tx_uchar2); 
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_spi_trx
	INCF	FSR1L, F
;	.line	151; main.c	nSEL = 1;
	BSF	_PORTCbits, 2
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__wr_register	code
_wr_register:
;	.line	140; main.c	void wr_register( uchar tx_uchar1, uchar tx_uchar2, uchar* rx_uchar){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	MOVLW	0x06
	MOVFF	PLUSW2, r0x04
;	.line	141; main.c	nSEL = 0;
	BCF	_PORTCbits, 2
;	.line	142; main.c	rx_uchar[0] = spi_trx(tx_uchar1);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_spi_trx
	MOVWF	r0x00
	INCF	FSR1L, F
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, PRODL
	MOVF	r0x04, W
	CALL	__gptrput1
;	.line	143; main.c	rx_uchar[1] = spi_trx(tx_uchar2); 
	INCF	r0x02, F
	BTFSC	STATUS, 0
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_spi_trx
	MOVWF	r0x00
	INCF	FSR1L, F
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, PRODL
	MOVF	r0x04, W
	CALL	__gptrput1
;	.line	144; main.c	nSEL = 1;
	BSF	_PORTCbits, 2
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__spi_trx	code
_spi_trx:
;	.line	124; main.c	uchar spi_trx( uchar txData){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, _SSPBUF
_00152_DS_:
;	.line	127; main.c	while(!PIR1bits.SSPIF);
	BTFSS	_PIR1bits, 3
	BRA	_00152_DS_
;	.line	128; main.c	rxData = SSPBUF;
	MOVFF	_SSPBUF, r0x00
;	.line	129; main.c	PIR1bits.SSPIF = 0;
	BCF	_PIR1bits, 3
;	.line	130; main.c	return rxData;
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__blinkLed	code
_blinkLed:
;	.line	114; main.c	void blinkLed(uchar times) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	116; main.c	for(i=0;i<times;i++){
	CLRF	r0x01
_00138_DS_:
	MOVF	r0x00, W
	SUBWF	r0x01, W
	BC	_00142_DS_
;	.line	117; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	118; main.c	delay_ms(50);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x32
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	119; main.c	LED = 0;
	BCF	_PORTAbits, 6
;	.line	120; main.c	delay_ms(50);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x32
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	116; main.c	for(i=0;i<times;i++){
	INCF	r0x01, F
	BRA	_00138_DS_
_00142_DS_:
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__delay_s	code
_delay_s:
;	.line	110; main.c	void delay_s(uint value){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
; ;multiply lit val:0x02 by variable r0x00 and store in r0x00
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
;	.line	111; main.c	delay1mtcy(value * 2);
	BCF	STATUS, 0
	RLCF	r0x00, F
	MOVF	r0x00, W
	CALL	_delay1mtcy
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__delay_ms	code
_delay_ms:
;	.line	102; main.c	void delay_ms(uint value){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	104; main.c	uint times = (value*2) / 0x00FF;
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0xff
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__divuint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	105; main.c	uint rest = (value*2) % 0x00FF;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0xff
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__moduint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	106; main.c	for(t = 0; t < times; t++) delay1ktcy(0xFF);
	CLRF	r0x04
	CLRF	r0x05
_00119_DS_:
	MOVF	r0x03, W
	SUBWF	r0x05, W
	BNZ	_00128_DS_
	MOVF	r0x02, W
	SUBWF	r0x04, W
_00128_DS_:
	BC	_00122_DS_
	MOVLW	0xff
	CALL	_delay1ktcy
	INCF	r0x04, F
	BTFSC	STATUS, 0
	INCF	r0x05, F
	BRA	_00119_DS_
_00122_DS_:
;	.line	107; main.c	delay1ktcy(rest);
	MOVF	r0x00, W
	CALL	_delay1ktcy
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__delay_us	code
_delay_us:
;	.line	95; main.c	void delay_us(uchar value){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	97; main.c	for(t=0; t < value; t++) {
	CLRF	r0x01
_00105_DS_:
	MOVF	r0x00, W
	SUBWF	r0x01, W
	BC	_00109_DS_
	nop 
;	.line	97; main.c	for(t=0; t < value; t++) {
	INCF	r0x01, F
	BRA	_00105_DS_
_00109_DS_:
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	 2718 (0x0a9e) bytes ( 2.07%)
;           	 1359 (0x054f) words
; udata size:	    7 (0x0007) bytes ( 0.18%)
; access size:	    6 (0x0006) bytes


	end
