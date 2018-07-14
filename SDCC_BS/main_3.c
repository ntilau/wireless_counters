// Base station
#include <pic18fregs.h>
#include "delay.h"
#include "stdio.h"
//#define RESTART_WDT
#define CLOCK_SPEED 8000000

#define LED PORTAbits.RA6
#define nRES PORTCbits.RC0
#define nFFS PORTCbits.RC1
#define nSEL PORTCbits.RC2
#define nIRQ PORTBbits.RB0
#define nINT PORTBbits.RB1
#define FFIT PORTBbits.RB2
#define radioSDO PORTCbits.RC4

// Configurations
code char at __CONFIG1H config1h = 0xFF & _OSC_INTIO67_1H & _FCMEN_OFF_1H; // intio + failsafe
code char at __CONFIG2H config2h = 0xFF & _WDT_DISABLED_CONTROLLED_2H;
code char at __CONFIG2L config2l = 0xFF & _BOREN_OFF_2L; // disable brown out detector
code char at __CONFIG3H config3h = 0xFF & _MCLRE_MCLR_OFF_RE3_ON_3H & _PBADEN_PORTB_4_0__CONFIGURED_AS_DIGITAL_I_O_ON_RESET_3H; // NoMCLR
code char at __CONFIG4L config4l = 0x81; // disable low voltage programming

// Data Types
typedef unsigned char uchar;
typedef unsigned int uint;

uchar checksum = 0x00; 
uchar i = 0x00, j = 0x00;
uchar dataRx = 0x00;
uchar status0 = 0x00, status1 = 0x00;
uchar fifo[16];
uchar fifoIdx = 0;
uchar dataTx[16];
uchar enableUART = 0;

void delay_us(uchar value){
  for(i=0; i < value; i++) {
    _asm nop _endasm ;
  }
}

void delay_ms(uint value){
  uint times = (value*2) / 0x00FF;
  uint rest = (value*2) % 0x00FF;
  for(i = 0; i < times; i++) delay1ktcy(0xFF);
  delay1ktcy(rest);
}

void delay_s(uint value){
  delay1mtcy(value * 2);
}

void blinkLed(uchar times) {
  uchar i;
  for(i=0;i<times;i++){
    LED = 1;
    delay_ms(5);
    LED = 0;
    delay_ms(5);
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

void get_status(){
  //wr_command(0xC4, 0xFE); // disable AFC for accurate reading of the offset
  nSEL = 0;
  status0 = spi_trx(0x00);
  status1 = spi_trx(0x00); 
  nSEL = 1;
  //wr_command(0xC4, 0xFF);
}

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

void updFifo(){
  fifo[fifoIdx++] = status0;
  fifo[fifoIdx++] = status1;
}

void printFifo(){
  for(i = 0; i < fifoIdx; i++){
    putc(fifo[i]);
  }
}

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
  TRISB = 0xFF;
  INTCON2bits.RBPU = 0; // enable weak pull-up
  
  // RADIO
  TRISCbits.TRISC0 = 0; // nRES
  TRISCbits.TRISC1 = 0; // nFFS
  nRES = 1;
  nFFS = 1;
  
  if(enableUART){
    // UART
    TRISCbits.TRISC6 = 1; // Tx pin input
    BAUDCON = 0;
    SPBRG = 12; // 9600 bps @ fClk = 8 MHz
    /*SPBRGH = 0;*/
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
  }
  
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
  nRES = 0;
  delay_ms(5);
  nRES = 1;
  delay_ms(100);
  get_status(); // clear POR interrupt
  
  // Radio Enable and configuration
  wr_command(0x80, 0x28); // Config setting command all FIFO + 868 + 12.5pF
  wr_command(0x82, 0x09); // Power Management Command. Idle + noClkOut
  wr_command(0xCA, 0x82); // FIFO fill when Synchon Pattern received. 2 bytes Synchon
  wr_command(0xCE, 0xA5); // Set 2nd byte to 0xA5
  
  for(j=0; j<5; j++){
    dataTx[j] = (j << 4) | j;
  }
  
  blinkLed(5);
  

  
  while(1) {
    
    
    //for(i = 0; i <5; i++){
    fifoIdx = 0;
    en_rx();
    while(fifoIdx < 6){
    //if(FFIT) 
      while(!FFIT);     
      nFFS = 0;
      fifo[fifoIdx++] = spi_trx(0x00);
      nFFS = 1;
    }
    en_idle();
    
    checksum = 0;
    for(i=0; i<5; i++){
      checksum += fifo[i];
    }
    
    if(checksum == fifo[5]){
      blinkLed(1);
      en_tx();
      while(nIRQ);
      wr_command(0xB8, 0xAA);
      while(nIRQ);
      wr_command(0xB8, 0x2D);
      while(nIRQ);
      wr_command(0xB8, 0xA5);
      while(nIRQ);
      wr_command(0xB8, 0xAA);
      while(nIRQ);
      wr_command(0xB8, 0xCC);
      while(nIRQ);
      wr_command(0xB8, 0xEF);
      while(nIRQ);
      en_idle();
      
    }
      
    
    
    //blinkLed(1);    
   // printFifo();
    // delay_s(1);
 
    

  }
  
}

/* TX

// en_tx();
    i = 0;
    while(i < 8){
      while(nIRQ);
      wr_command(0xB8, dataTx[i++]);
    }
    while(nIRQ);    
    en_idle();
    blinkLed(1);
    
*/

