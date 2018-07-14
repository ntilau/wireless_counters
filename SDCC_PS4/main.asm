;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Mar 22 2009) (MINGW32)
; This file was generated Tue Sep 07 01:27:44 2010
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
	global _portP1
	global _portP2
	global _portP3
	global _portP4
	global _fifo
	global _idx
	global _dataTx
	global _checksum
	global _timeOut
	global _port
	global _delay_us
	global _delay_ms
	global _delay_s
	global _blinkLed
	global _spi_trx
	global _putc
	global _wr_register
	global _wr_command
	global _en_rx
	global _en_tx
	global _en_idle
	global _portb_isr
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
	extern ___fsgt
	extern ___fssub
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
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
_portP1	db	0x00
_portP2	db	0x00
_portP3	db	0x00
_portP4	db	0x00
_idx	db	0x00
_checksum	db	0x00
_port	db	0x00


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1

udata_main_0	udata
_timeOut	res	4

udata_main_1	udata
_fifo	res	2

udata_main_2	udata
_dataTx	res	6

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; ; Starting pCode block for absolute section
; ;-----------------------------------------
S_main_ivec_0x1_portb_isr	code	0X000008
ivec_0x1_portb_isr:
	GOTO	_portb_isr

; I code from now on!
; ; Starting pCode block
S_main__main	code
_main:
;	.line	205; main.c	OSCCONbits.IRCF = 7;
	MOVF	_OSCCONbits, W
	ANDLW	0x8f
	IORLW	0x70
	MOVWF	_OSCCONbits
;	.line	208; main.c	TRISAbits.TRISA6 = 0; // LED output
	BCF	_TRISAbits, 6
;	.line	209; main.c	LED = 0; // output low
	BCF	_PORTAbits, 6
;	.line	210; main.c	TRISDbits.TRISD6 = 0;
	BCF	_TRISDbits, 6
;	.line	211; main.c	PORTDbits.RD6 = 0;
	BCF	_PORTDbits, 6
;	.line	214; main.c	PORTB = 0xFF;
	MOVLW	0xff
	MOVWF	_PORTB
;	.line	215; main.c	TRISB = 0x00;
	CLRF	_TRISB
;	.line	216; main.c	TRISB = 0xFF;
	MOVLW	0xff
	MOVWF	_TRISB
;	.line	217; main.c	INTCON2bits.RBPU = 0; // enable weak pull-up
	BCF	_INTCON2bits, 7
;	.line	220; main.c	TRISCbits.TRISC0 = 0; // nRES
	BCF	_TRISCbits, 0
;	.line	221; main.c	TRISCbits.TRISC1 = 0; // nFFS
	BCF	_TRISCbits, 1
;	.line	222; main.c	TRISCbits.TRISC2 = 1;
	BSF	_TRISCbits, 2
;	.line	223; main.c	nRES = 1;
	BSF	_PORTCbits, 0
;	.line	224; main.c	nFFS = 1;
	BSF	_PORTCbits, 1
;	.line	227; main.c	INTCONbits.RBIF = 0;
	BCF	_INTCONbits, 0
;	.line	228; main.c	INTCONbits.RBIE = 1; // RB4-7 change interrupt
	BSF	_INTCONbits, 3
;	.line	229; main.c	INTCON2bits.RBIP = 1;
	BSF	_INTCON2bits, 0
;	.line	230; main.c	INTCONbits.GIE = 1; // global interrupts
	BSF	_INTCONbits, 7
;	.line	267; main.c	TRISCbits.TRISC5 = 0; // SDO
	BCF	_TRISCbits, 5
;	.line	268; main.c	TRISCbits.TRISC4 = 1; // SDI
	BSF	_TRISCbits, 4
;	.line	269; main.c	TRISCbits.TRISC3 = 0; // SCK
	BCF	_TRISCbits, 3
;	.line	270; main.c	TRISCbits.TRISC2 = 0; // nSEL
	BCF	_TRISCbits, 2
;	.line	271; main.c	nSEL = 1;
	BSF	_PORTCbits, 2
;	.line	272; main.c	SSPCON1bits.SSPEN = 1; // enable SPI
	BSF	_SSPCON1bits, 5
;	.line	273; main.c	SSPCON1bits.CKP = 0; // idle bit low
	BCF	_SSPCON1bits, 4
;	.line	274; main.c	SSPCON1bits.SSPM0 = 0; // cleared Fosc/4 master mode. set for Fosc/16
	BCF	_SSPCON1bits, 0
;	.line	275; main.c	SSPSTATbits.SMP = 0; // sampled in the middle
	BCF	_SSPSTATbits, 7
;	.line	276; main.c	SSPSTATbits.CKE = 1; // transmit for idle to active
	BSF	_SSPSTATbits, 6
;	.line	277; main.c	SSPCON1bits.WCOL = 0;
	BCF	_SSPCON1bits, 7
;	.line	278; main.c	PIE1bits.SSPIE = 1; // enable SPI flag
	BSF	_PIE1bits, 3
;	.line	281; main.c	delay_ms(100);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x64
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	282; main.c	nRES = 0;
	BCF	_PORTCbits, 0
;	.line	283; main.c	delay_ms(5);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x05
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	284; main.c	nRES = 1;
	BSF	_PORTCbits, 0
;	.line	285; main.c	delay_ms(200);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0xc8
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	286; main.c	wr_command(0x00, 0x00); // clear POR interrupt
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	287; main.c	delay_ms(100);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x64
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	290; main.c	wr_command(0x80, 0x28); // Config setting command all FIFO + 868 + 12.5pF
	MOVLW	0x28
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	291; main.c	wr_command(0x82, 0x09); // Power Management Command. Idle + noClkOut
	MOVLW	0x09
	MOVWF	POSTDEC1
	MOVLW	0x82
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	292; main.c	wr_command(0xCA, 0x82); // FIFO fill when Synchon Pattern received. 2 bytes Synchon
	MOVLW	0x82
	MOVWF	POSTDEC1
	MOVLW	0xca
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	293; main.c	wr_command(0xCE, 0xA5); // Set 2nd byte to 0xA5
	MOVLW	0xa5
	MOVWF	POSTDEC1
	MOVLW	0xce
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	296; main.c	blinkLed(5);
	MOVLW	0x05
	MOVWF	POSTDEC1
	CALL	_blinkLed
	INCF	FSR1L, F
_00245_DS_:
	BANKSEL	_fifo
;	.line	300; main.c	fifo[0] = 0;
	CLRF	_fifo, B
	BANKSEL	(_fifo + 1)
;	.line	301; main.c	fifo[1] = 0;
	CLRF	(_fifo + 1), B
	BANKSEL	_idx
;	.line	303; main.c	idx = 0;
	CLRF	_idx, B
;	.line	304; main.c	en_rx();
	CALL	_en_rx
	BANKSEL	_timeOut
;	.line	305; main.c	timeOut = 0x00000FFF;
	CLRF	_timeOut, B
	MOVLW	0xf0
	BANKSEL	(_timeOut + 1)
	MOVWF	(_timeOut + 1), B
	MOVLW	0x7f
	BANKSEL	(_timeOut + 2)
	MOVWF	(_timeOut + 2), B
	MOVLW	0x45
	BANKSEL	(_timeOut + 3)
	MOVWF	(_timeOut + 3), B
_00213_DS_:
;	.line	309; main.c	while( (idx < 2) & (timeOut > 0) ){
	MOVLW	0x02
	BANKSEL	_idx
	SUBWF	_idx, W, B
	BTG	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	BANKSEL	(_timeOut + 3)
	MOVF	(_timeOut + 3), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_timeOut + 2)
	MOVF	(_timeOut + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_timeOut + 1)
	MOVF	(_timeOut + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_timeOut
	MOVF	_timeOut, W, B
	MOVWF	POSTDEC1
	CALL	___fsgt
	MOVWF	r0x01
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x01, W
	ANDWF	r0x00, F
	MOVF	r0x00, W
	BTFSC	STATUS, 2
	BRA	_00215_DS_
_00210_DS_:
;	.line	310; main.c	while(!FFIT & (timeOut > 0)) timeOut--;
	CLRF	r0x00
	BTFSC	_PORTBbits, 2
	INCF	r0x00, F
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	BANKSEL	(_timeOut + 3)
	MOVF	(_timeOut + 3), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_timeOut + 2)
	MOVF	(_timeOut + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_timeOut + 1)
	MOVF	(_timeOut + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_timeOut
	MOVF	_timeOut, W, B
	MOVWF	POSTDEC1
	CALL	___fsgt
	MOVWF	r0x01
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x01, W
	ANDWF	r0x00, F
	MOVF	r0x00, W
	BZ	_00212_DS_
	MOVLW	0x3f
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	BANKSEL	(_timeOut + 3)
	MOVF	(_timeOut + 3), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_timeOut + 2)
	MOVF	(_timeOut + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_timeOut + 1)
	MOVF	(_timeOut + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_timeOut
	MOVF	_timeOut, W, B
	MOVWF	POSTDEC1
	CALL	___fssub
	BANKSEL	_timeOut
	MOVWF	_timeOut, B
	MOVFF	PRODL, (_timeOut + 1)
	MOVFF	PRODH, (_timeOut + 2)
	MOVFF	FSR0L, (_timeOut + 3)
	MOVLW	0x08
	ADDWF	FSR1L, F
	BRA	_00210_DS_
_00212_DS_:
;	.line	311; main.c	nFFS = 0;
	BCF	_PORTCbits, 1
;	.line	312; main.c	fifo[idx++] = spi_trx(0x00);
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
;	.line	313; main.c	nFFS = 1;
	BSF	_PORTCbits, 1
	BRA	_00213_DS_
_00215_DS_:
;	.line	316; main.c	en_idle();
	CALL	_en_idle
	BANKSEL	_timeOut
;	.line	317; main.c	if(timeOut == 0) {
	MOVF	_timeOut, W, B
	BANKSEL	(_timeOut + 1)
	IORWF	(_timeOut + 1), W, B
	BANKSEL	(_timeOut + 2)
	IORWF	(_timeOut + 2), W, B
	BANKSEL	(_timeOut + 3)
	IORWF	(_timeOut + 3), W, B
	BNZ	_00217_DS_
;	.line	319; main.c	LED = 1;
	BSF	_PORTAbits, 6
_00217_DS_:
;	.line	323; main.c	if(fifo[0] == 0x5A & fifo[1] == ID)
	CLRF	r0x00
	BANKSEL	_fifo
	MOVF	_fifo, W, B
	XORLW	0x5a
	BNZ	_00274_DS_
	INCF	r0x00, F
_00274_DS_:
	CLRF	r0x01
	BANKSEL	(_fifo + 1)
	MOVF	(_fifo + 1), W, B
	XORLW	0x04
	BNZ	_00276_DS_
	INCF	r0x01, F
_00276_DS_:
	MOVF	r0x01, W
	ANDWF	r0x00, F
	MOVF	r0x00, W
	BTFSC	STATUS, 2
	BRA	_00245_DS_
;	.line	325; main.c	LED=1;
	BSF	_PORTAbits, 6
	BANKSEL	_portP1
;	.line	327; main.c	dataTx[0] = portP1;
	MOVF	_portP1, W, B
	BANKSEL	_dataTx
	MOVWF	_dataTx, B
	BANKSEL	_portP2
;	.line	328; main.c	dataTx[1] = portP2;
	MOVF	_portP2, W, B
	BANKSEL	(_dataTx + 1)
	MOVWF	(_dataTx + 1), B
	BANKSEL	_portP3
;	.line	329; main.c	dataTx[2] = portP3;
	MOVF	_portP3, W, B
	BANKSEL	(_dataTx + 2)
	MOVWF	(_dataTx + 2), B
	BANKSEL	_portP4
;	.line	330; main.c	dataTx[3] = portP4;
	MOVF	_portP4, W, B
	BANKSEL	(_dataTx + 3)
	MOVWF	(_dataTx + 3), B
;	.line	332; main.c	en_tx();
	CALL	_en_tx
	BANKSEL	_idx
;	.line	333; main.c	idx = 0;
	CLRF	_idx, B
	BANKSEL	_checksum
;	.line	334; main.c	checksum = 0;
	CLRF	_checksum, B
_00218_DS_:
;	.line	335; main.c	while(nIRQ);
	BTFSC	_PORTBbits, 0
	BRA	_00218_DS_
;	.line	336; main.c	wr_command(0xB8, 0x2D);
	MOVLW	0x2d
	MOVWF	POSTDEC1
	MOVLW	0xb8
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
_00221_DS_:
;	.line	337; main.c	while(nIRQ);
	BTFSC	_PORTBbits, 0
	BRA	_00221_DS_
;	.line	338; main.c	wr_command(0xB8, 0xA5);
	MOVLW	0xa5
	MOVWF	POSTDEC1
	MOVLW	0xb8
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
_00224_DS_:
;	.line	339; main.c	while(nIRQ);
	BTFSC	_PORTBbits, 0
	BRA	_00224_DS_
;	.line	340; main.c	wr_command(0xB8, 0x5A);
	MOVLW	0x5a
	MOVWF	POSTDEC1
	MOVLW	0xb8
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
_00230_DS_:
;	.line	341; main.c	while(idx < 4){
	MOVLW	0x04
	BANKSEL	_idx
	SUBWF	_idx, W, B
	BC	_00233_DS_
;	.line	342; main.c	checksum += dataTx[idx];
	MOVLW	LOW(_dataTx)
	BANKSEL	_idx
	ADDWF	_idx, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	HIGH(_dataTx)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
	BANKSEL	_checksum
	ADDWF	_checksum, F, B
_00227_DS_:
;	.line	343; main.c	while(nIRQ);
	BTFSC	_PORTBbits, 0
	BRA	_00227_DS_
;	.line	344; main.c	wr_command(0xB8, dataTx[idx++]);
	MOVFF	_idx, r0x00
	BANKSEL	_idx
	INCF	_idx, F, B
	CLRF	r0x01
	MOVLW	LOW(_dataTx)
	ADDWF	r0x00, F
	MOVLW	HIGH(_dataTx)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0xb8
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
	BRA	_00230_DS_
_00233_DS_:
;	.line	346; main.c	while(nIRQ);
	BTFSC	_PORTBbits, 0
	BRA	_00233_DS_
	BANKSEL	_checksum
;	.line	347; main.c	wr_command(0xB8, checksum);
	MOVF	_checksum, W, B
	MOVWF	POSTDEC1
	MOVLW	0xb8
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
_00236_DS_:
;	.line	348; main.c	while(nIRQ);
	BTFSC	_PORTBbits, 0
	BRA	_00236_DS_
;	.line	349; main.c	wr_command(0xB8, 0xEF);
	MOVLW	0xef
	MOVWF	POSTDEC1
	MOVLW	0xb8
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
_00239_DS_:
;	.line	350; main.c	while(nIRQ);
	BTFSC	_PORTBbits, 0
	BRA	_00239_DS_
;	.line	351; main.c	en_idle();
	CALL	_en_idle
	BANKSEL	_dataTx
;	.line	353; main.c	portP1 -= dataTx[0];
	MOVF	_dataTx, W, B
	BANKSEL	_portP1
	SUBWF	_portP1, F, B
	BANKSEL	(_dataTx + 1)
;	.line	354; main.c	portP2 -= dataTx[1];
	MOVF	(_dataTx + 1), W, B
	BANKSEL	_portP2
	SUBWF	_portP2, F, B
	BANKSEL	(_dataTx + 2)
;	.line	355; main.c	portP3 -= dataTx[2];
	MOVF	(_dataTx + 2), W, B
	BANKSEL	_portP3
	SUBWF	_portP3, F, B
	BANKSEL	(_dataTx + 3)
;	.line	356; main.c	portP4 -= dataTx[3];
	MOVF	(_dataTx + 3), W, B
	BANKSEL	_portP4
	SUBWF	_portP4, F, B
;	.line	358; main.c	LED = 0;
	BCF	_PORTAbits, 6
	BRA	_00245_DS_
	RETURN	

; ; Starting pCode block
S_main__portb_isr	code
_portb_isr:
;	.line	169; main.c	void portb_isr (void) interrupt 1
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
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	171; main.c	INTCONbits.RBIE = 0;
	BCF	_INTCONbits, 3
;	.line	172; main.c	if(!PORTBbits.RB7 & port.p1) {
	CLRF	r0x00
	BTFSC	_PORTBbits, 7
	INCF	r0x00, F
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	CLRF	r0x01
	BANKSEL	_port
	BTFSC	_port, 0, B
	INCF	r0x01, F
	MOVF	r0x01, W
	ANDWF	r0x00, F
	MOVF	r0x00, W
	BZ	_00194_DS_
	BANKSEL	_portP1
;	.line	173; main.c	portP1++;
	INCF	_portP1, F, B
	BANKSEL	_port
;	.line	174; main.c	port.p1 = 0;
	BCF	_port, 0, B
	BRA	_00195_DS_
_00194_DS_:
;	.line	175; main.c	} else port.p1 = PORTBbits.RB7;
	CLRF	r0x00
	BTFSC	_PORTBbits, 7
	INCF	r0x00, F
	MOVF	r0x00, W
	ANDLW	0x01
	MOVWF	PRODH
	BANKSEL	_port
	MOVF	_port, W, B
	ANDLW	0xfe
	IORWF	PRODH, W
	BANKSEL	_port
	MOVWF	_port, B
_00195_DS_:
;	.line	176; main.c	if(!PORTBbits.RB6 & port.p2) {
	CLRF	r0x00
	BTFSC	_PORTBbits, 6
	INCF	r0x00, F
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	CLRF	r0x01
	BANKSEL	_port
	BTFSC	_port, 1, B
	INCF	r0x01, F
	MOVF	r0x01, W
	ANDWF	r0x00, F
	MOVF	r0x00, W
	BZ	_00197_DS_
	BANKSEL	_portP2
;	.line	177; main.c	portP2++;
	INCF	_portP2, F, B
	BANKSEL	_port
;	.line	178; main.c	port.p2 = 0;
	BCF	_port, 1, B
	BRA	_00198_DS_
_00197_DS_:
;	.line	179; main.c	} else port.p2 = PORTBbits.RB6;
	CLRF	r0x00
	BTFSC	_PORTBbits, 6
	INCF	r0x00, F
	MOVF	r0x00, W
	ANDLW	0x01
	RLNCF	WREG, W
	MOVWF	PRODH
	BANKSEL	_port
	MOVF	_port, W, B
	ANDLW	0xfd
	IORWF	PRODH, W
	BANKSEL	_port
	MOVWF	_port, B
_00198_DS_:
;	.line	180; main.c	if(!PORTBbits.RB5 & port.p3) {
	CLRF	r0x00
	BTFSC	_PORTBbits, 5
	INCF	r0x00, F
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	CLRF	r0x01
	BANKSEL	_port
	BTFSC	_port, 2, B
	INCF	r0x01, F
	MOVF	r0x01, W
	ANDWF	r0x00, F
	MOVF	r0x00, W
	BZ	_00200_DS_
	BANKSEL	_portP3
;	.line	181; main.c	portP3++;
	INCF	_portP3, F, B
	BANKSEL	_port
;	.line	182; main.c	port.p3 = 0;
	BCF	_port, 2, B
	BRA	_00201_DS_
_00200_DS_:
;	.line	183; main.c	} else port.p3 = PORTBbits.RB5;
	CLRF	r0x00
	BTFSC	_PORTBbits, 5
	INCF	r0x00, F
	MOVF	r0x00, W
	ANDLW	0x01
	RLNCF	WREG, W
	RLNCF	WREG, W
	MOVWF	PRODH
	BANKSEL	_port
	MOVF	_port, W, B
	ANDLW	0xfb
	IORWF	PRODH, W
	BANKSEL	_port
	MOVWF	_port, B
_00201_DS_:
;	.line	184; main.c	if(!PORTBbits.RB4 & port.p4) {
	CLRF	r0x00
	BTFSC	_PORTBbits, 4
	INCF	r0x00, F
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	CLRF	r0x01
	BANKSEL	_port
	BTFSC	_port, 3, B
	INCF	r0x01, F
	MOVF	r0x01, W
	ANDWF	r0x00, F
	MOVF	r0x00, W
	BZ	_00203_DS_
	BANKSEL	_portP4
;	.line	185; main.c	portP4++;
	INCF	_portP4, F, B
	BANKSEL	_port
;	.line	186; main.c	port.p4 = 0;
	BCF	_port, 3, B
	BRA	_00204_DS_
_00203_DS_:
;	.line	187; main.c	} else port.p4 = PORTBbits.RB4;
	CLRF	r0x00
	BTFSC	_PORTBbits, 4
	INCF	r0x00, F
	MOVF	r0x00, W
	ANDLW	0x01
	SWAPF	WREG, W
	RRNCF	WREG, W
	MOVWF	PRODH
	BANKSEL	_port
	MOVF	_port, W, B
	ANDLW	0xf7
	IORWF	PRODH, W
	BANKSEL	_port
	MOVWF	_port, B
_00204_DS_:
;	.line	188; main.c	INTCONbits.RBIF = 0;
	BCF	_INTCONbits, 0
;	.line	189; main.c	INTCONbits.RBIE = 1;
	BSF	_INTCONbits, 3
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
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
;	.line	151; main.c	void en_idle(){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	152; main.c	wr_command(0x82, 0x59); // leaves BaseBand and Synthesizer active
	MOVLW	0x59
	MOVWF	POSTDEC1
	MOVLW	0x82
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	153; main.c	wr_command(0x80, 0x28);
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
;	.line	146; main.c	void en_tx() {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	147; main.c	wr_command(0x80, 0xD8);
	MOVLW	0xd8
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	148; main.c	wr_command(0x82, 0x39);
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
;	.line	141; main.c	void en_rx(){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	142; main.c	wr_command(0x80, 0x68);
	MOVLW	0x68
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_wr_command
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	143; main.c	wr_command(0x82, 0xD9);
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
;	.line	122; main.c	void wr_command( uchar tx_uchar1, uchar tx_uchar2){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	123; main.c	nSEL = 0;
	BCF	_PORTCbits, 2
;	.line	124; main.c	spi_trx(tx_uchar1);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_spi_trx
	INCF	FSR1L, F
;	.line	125; main.c	spi_trx(tx_uchar2); 
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_spi_trx
	INCF	FSR1L, F
;	.line	126; main.c	nSEL = 1;
	BSF	_PORTCbits, 2
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__wr_register	code
_wr_register:
;	.line	115; main.c	void wr_register( uchar tx_uchar1, uchar tx_uchar2, uchar* rx_uchar){
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
;	.line	116; main.c	nSEL = 0;
	BCF	_PORTCbits, 2
;	.line	117; main.c	rx_uchar[0] = spi_trx(tx_uchar1);
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
;	.line	118; main.c	rx_uchar[1] = spi_trx(tx_uchar2); 
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
;	.line	119; main.c	nSEL = 1;
	BSF	_PORTCbits, 2
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__putc	code
_putc:
;	.line	110; main.c	void putc(uchar txData){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x02
	MOVFF	PLUSW2, _TXREG
_00160_DS_:
;	.line	112; main.c	while(!TXSTAbits.TRMT);
	BTFSS	_TXSTAbits, 1
	BRA	_00160_DS_
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__spi_trx	code
_spi_trx:
;	.line	82; main.c	uchar spi_trx( uchar txData){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, _SSPBUF
_00152_DS_:
;	.line	85; main.c	while(!PIR1bits.SSPIF);
	BTFSS	_PIR1bits, 3
	BRA	_00152_DS_
;	.line	86; main.c	rxData = SSPBUF;
	MOVFF	_SSPBUF, r0x00
;	.line	87; main.c	PIR1bits.SSPIF = 0;
	BCF	_PIR1bits, 3
;	.line	88; main.c	return rxData;
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__blinkLed	code
_blinkLed:
;	.line	72; main.c	void blinkLed(uchar times) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	74; main.c	for(i=0;i<times;i++){
	CLRF	r0x01
_00138_DS_:
	MOVF	r0x00, W
	SUBWF	r0x01, W
	BC	_00142_DS_
;	.line	75; main.c	LED = 1;
	BSF	_PORTAbits, 6
;	.line	76; main.c	delay_ms(50);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x32
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	77; main.c	LED = 0;
	BCF	_PORTAbits, 6
;	.line	78; main.c	delay_ms(50);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x32
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	74; main.c	for(i=0;i<times;i++){
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
;	.line	68; main.c	void delay_s(uint value){
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
;	.line	69; main.c	delay1mtcy(value * 2);
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
;	.line	60; main.c	void delay_ms(uint value){
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
;	.line	62; main.c	uint times = (value*2) / 0x00FF;
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
;	.line	63; main.c	uint rest = (value*2) % 0x00FF;
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
;	.line	64; main.c	for(t = 0; t < times; t++) delay1ktcy(0xFF);
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
;	.line	65; main.c	delay1ktcy(rest);
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
;	.line	53; main.c	void delay_us(uchar value){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	55; main.c	for(t=0; t < value; t++) {
	CLRF	r0x01
_00105_DS_:
	MOVF	r0x00, W
	SUBWF	r0x01, W
	BC	_00109_DS_
	nop 
;	.line	55; main.c	for(t=0; t < value; t++) {
	INCF	r0x01, F
	BRA	_00105_DS_
_00109_DS_:
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	 2076 (0x081c) bytes ( 1.58%)
;           	 1038 (0x040e) words
; udata size:	   12 (0x000c) bytes ( 0.31%)
; access size:	    6 (0x0006) bytes


	end
