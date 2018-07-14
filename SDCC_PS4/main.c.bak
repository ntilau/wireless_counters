// Printer module 1
#include <pic18fregs.h>
#include "delay.h"
#include "stdio.h"
//#define RESTART_WDT
//#define CLOCK_SPEED 8000000

#define LED PORTAbits.RA6
#define nRES PORTCbits.RC0
#define nFFS PORTCbits.RC1
#define nSEL PORTCbits.RC2
#define nIRQ PORTBbits.RB0
#define nINT PORTBbits.RB1
#define FFIT PORTBbits.RB2
#define radioSDO PORTCbits.RC4

#define printer1 PORTBbits.RB4
#define printer2 PORTBbits.RB5
#define printer3 PORTBbits.RB6
#define printer4 PORTBbits.RB7

#define ID 0x01


// Configurations
code char at __CONFIG1H config1h = 0xFF & _OSC_INTIO67_1H & _FCMEN_OFF_1H; // intio + failsafe
code char at __CONFIG2H config2h = 0xFF & _WDT_DISABLED_CONTROLLED_2H;
code char at __CONFIG2L config2l = 0xFF & _BOREN_OFF_2L; // disable brown out detector
code char at __CONFIG3H config3h = 0xFF & _MCLRE_MCLR_OFF_RE3_ON_3H & _PBADEN_PORTB_4_0__CONFIGURED_AS_DIGITAL_I_O_ON_RESET_3H; // NoMCLR
code char at __CONFIG4L config4l = 0x81; // disable low voltage programming

// Data Types
typedef unsigned char uchar;
typedef unsigned int uint;

uchar portP1 = 0, portP2 = 0, portP3 = 0, portP4 = 0; 
// uchar i = 0x00, j = 0x00;
// uchar status0 = 0x00, status1 = 0x00;
uchar fifo[2];
uchar idx = 0;
uchar dataTx[6];
uchar checksum = 0x00;
float timeOut;
struct {
  unsigned p1    	    : 1;
  unsigned p2        	: 1;
  unsigned p3       	: 1;
  unsigned p4       	: 1;
} port = {0,0,0,0};

// void wr_command(uchar, uchar);

void delay_us(uchar value){
  uchar t;
  for(t=0; t < value; t++) {
    _asm nop _endasm ;
  }
}

void delay_ms(uint value){
  uint t;
  uint times = (value*2) / 0x00FF;
  uint rest = (value*2) % 0x00FF;
  for(t = 0; t < times; t++) delay1ktcy(0xFF);
  delay1ktcy(rest);
}

void delay_s(uint value){
  delay1mtcy(value * 2);
}

void blinkLed(uchar times) {
  uchar i;
  for(i=0;i<times;i++){
    LED = 1;
    delay_ms(50);
    LED = 0;
    delay_ms(50);
  }
}

uchar spi_trx( uchar txData){
  uchar rxData = 0;
  SSPBUF = txData;
  while(!PIR1bits.SSPIF);
  rxData = SSPBUF;
  PIR1bits.SSPIF = 0;
  return rxData;
}
/*
uchar fifo_read(){
  uchar rxData = 0;
  nSEL = 0;
  spi_trx(0xB0);
  rxData = spi_trx(0x00);
  nSEL = 1;
  return rxData;
}

void fifo_write(uchar* txData, uchar nbrBytes){ // could also use nFFS
  uchar i = 0;
  while(i < nbrBytes){
    while(nIRQ);
    wr_command(0xB8, txData[i++]);
    delay_ms(1);
  }
}
*/

void putc(uchar txData){
	TXREG = txData;
	while(!TXSTAbits.TRMT);
}

void wr_register( uchar tx_uchar1, uchar tx_uchar2, uchar* rx_uchar){
  nSEL = 0;
  rx_uchar[0] = spi_trx(tx_uchar1);
  rx_uchar[1] = spi_trx(tx_uchar2); 
  nSEL = 1;
}

void wr_command( uchar tx_uchar1, uchar tx_uchar2){
  nSEL = 0;
  spi_trx(tx_uchar1);
  spi_trx(tx_uchar2); 
  nSEL = 1;
}

/*
void get_status(){
  //wr_command(0xC4, 0xFE); // disable AFC for accurate reading of the offset
  nSEL = 0;
  status0 = spi_trx(0x00);
  status1 = spi_trx(0x00); 
  nSEL = 1;
  //wr_command(0xC4, 0xFF);
}

*/

void en_rx(){
  wr_command(0x80, 0x68);
  wr_command(0x82, 0xD9);
}

void en_tx() {
  wr_command(0x80, 0xD8);
  wr_command(0x82, 0x39);
}

void en_idle(){
  wr_command(0x82, 0x59); // leaves BaseBand and Synthesizer active
  wr_command(0x80, 0x28);
}

/*
void updFifo(){
  fifo[idx++] = status0;
  fifo[idx++] = status1;
}

void printFifo(){
  for(i=0; i< idx; i++){
    putc(fifo[i]);
  }
}
*/

void portb_isr (void) interrupt 1
{
  INTCONbits.RBIE = 0;
  if(!PORTBbits.RB7 & port.p1) {
    portP1++;
    port.p1 = 0;
  } else port.p1 = PORTBbits.RB7;
  if(!PORTBbits.RB6 & port.p2) {
    portP2++;
    port.p2 = 0;
  } else port.p2 = PORTBbits.RB6;
  if(!PORTBbits.RB5 & port.p3) {
    portP3++;
    port.p3 = 0;
  } else port.p3 = PORTBbits.RB5;
  if(!PORTBbits.RB4 & port.p4) {
    portP4++;
    port.p4 = 0;
  } else port.p4 = PORTBbits.RB4;
  INTCONbits.RBIF = 0;
  INTCONbits.RBIE = 1;
}

/*
void timer0_isr(void) interrupt 2
{
  INTCONbits.TMR0IE = 0;
  timeOut = 1;
  INTCONbits.TMR0IF = 0;
  INTCONbits.TMR0IE = 1;
}
*/

void main() {
 
  // 8MHz internal oscillator
  OSCCONbits.IRCF = 7;
  
  // LED
  TRISAbits.TRISA6 = 0; // LED output
  LED = 0; // output low
  TRISDbits.TRISD6 = 0;
  PORTDbits.RD6 = 0;
  
  // TRISB all inputs with pull-up
  PORTB = 0xFF;
  TRISB = 0x00;
  TRISB = 0xFF;
  INTCON2bits.RBPU = 0; // enable weak pull-up
 
  // RADIO
  TRISCbits.TRISC0 = 0; // nRES
  TRISCbits.TRISC1 = 0; // nFFS
  TRISCbits.TRISC2 = 1;
  nRES = 1;
  nFFS = 1;
  
  // Printers interrupts
  INTCONbits.RBIF = 0;
  INTCONbits.RBIE = 1; // RB4-7 change interrupt
  INTCON2bits.RBIP = 1;
  INTCONbits.GIE = 1; // global interrupts

/*  
  // Set Timer0
  T0CONbits.T08BIT = 0;
  T0CONbits.T0CS = 0;
  T0CONbits.PSA = 0;
  T0CONbits.T0PS0 = 1;
  T0CONbits.T0PS1 = 1;
  T0CONbits.T0PS2 = 1;
  T0CONbits.TMR0ON = 0;
  INTCONbits.TMR0IF = 0;
  INTCONbits.TMR0IE = 1;
  INTCONbits.GIE = 1; // global interrupts
*/
  
/*
  // UART
  TRISCbits.TRISC6 = 1; // Tx pin input
  BAUDCON = 0;
  SPBRG = 12; // 9600 bps @ fClk = 8 MHz
  //SPBRGH = 0;
  TXSTAbits.BRGH = 0; // use 2 uchars or 1 for SPBRG number
  TXSTAbits.SYNC = 0; // Disable Synchronous/Enable Asynchronous
  BAUDCONbits.BRG16 = 0;
  PIE1bits.TXIE = 1; // (0 = disabled)
  PIE1bits.RCIE = 1; // (1 = enabled)
  TXSTAbits.TX9 = 0; // (0 = 8-bit transmit)
  RCSTAbits.RX9 = 0; // (0 = 8-bit reception)
  TXSTAbits.TXEN = 1; // Enable transmission mode
  RCSTAbits.CREN = 1; // Continuous reception
  TRISCbits.TRISC7 = 1; // Rx pin
  TRISCbits.TRISC6 = 0; // Tx pin 
  RCSTAbits.SPEN = 1; // Serial port enabled
*/

  // SPI
  TRISCbits.TRISC5 = 0; // SDO
  TRISCbits.TRISC4 = 1; // SDI
  TRISCbits.TRISC3 = 0; // SCK
  TRISCbits.TRISC2 = 0; // nSEL
  nSEL = 1;
  SSPCON1bits.SSPEN = 1; // enable SPI
  SSPCON1bits.CKP = 0; // idle bit low
  SSPCON1bits.SSPM0 = 0; // cleared Fosc/4 master mode. set for Fosc/16
  SSPSTATbits.SMP = 0; // sampled in the middle
  SSPSTATbits.CKE = 1; // transmit for idle to active
  SSPCON1bits.WCOL = 0;
  PIE1bits.SSPIE = 1; // enable SPI flag
  
  //RADIO reset
  delay_ms(100);
  nRES = 0;
  delay_ms(5);
  nRES = 1;
  delay_ms(200);
  wr_command(0x00, 0x00); // clear POR interrupt
  delay_ms(100);
  
  // Radio Enable and configuration
  wr_command(0x80, 0x28); // Config setting command all FIFO + 868 + 12.5pF
  wr_command(0x82, 0x09); // Power Management Command. Idle + noClkOut
  wr_command(0xCA, 0x82); // FIFO fill when Synchon Pattern received. 2 bytes Synchon
  wr_command(0xCE, 0xA5); // Set 2nd byte to 0xA5


  blinkLed(5);
    
  while(1) {
    
    fifo[0] = 0;
    fifo[1] = 0;
    
    idx = 0;
    en_rx();
    timeOut = 0x00000FFF;
    //T0CONbits.TMR0ON = 1;
    // TMR0H = 0xC0;
    //TMR0L = 0x00;
    while( (idx < 2) & (timeOut > 0) ){
      while(!FFIT & (timeOut > 0)) timeOut--;
      nFFS = 0;
      fifo[idx++] = spi_trx(0x00);
      nFFS = 1;
    }
    //T0CONbits.TMR0ON = 0;
    en_idle();
    if(timeOut == 0) {
      // timeOut = 0;
      LED = 1;
      // blinkLed(5);
    }
    
    if(fifo[0] == 0x5A & fifo[1] == ID)
    {
      LED=1;
      
      dataTx[0] = portP1;
      dataTx[1] = portP2;
      dataTx[2] = portP3;
      dataTx[3] = portP4;

      en_tx();
      idx = 0;
      checksum = 0;
      while(nIRQ);
      wr_command(0xB8, 0x2D);
      while(nIRQ);
      wr_command(0xB8, 0xA5);
      while(nIRQ);
      wr_command(0xB8, 0x5A);
      while(idx < 4){
        checksum += dataTx[idx];
        while(nIRQ);
        wr_command(0xB8, dataTx[idx++]);
      }
      while(nIRQ);
      wr_command(0xB8, checksum);
      while(nIRQ);
      wr_command(0xB8, 0xEF);
      while(nIRQ);
      en_idle();

      portP1 -= dataTx[0];
      portP2 -= dataTx[1];
      portP3 -= dataTx[2];
      portP4 -= dataTx[3];
      
      LED = 0;
      
    }
    

  }
}