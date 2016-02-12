// ��������� ��� ����� ���������� (��) �� �� ATMega8
// ���������� ������� ��. 08�1 ��������� �.�.
//------------------------------------------------------------------
//			��������� �������������
//------------------------------------------------------------------
#include <avr/io.h>				// ������� �����/������
#include <avr/eeprom.h>			// ������� eeprom_read_byte()
#include <string.h>				// ������� strcpy()
#include <util/delay.h>			// ������� _delay_ms()

#include "pff.h"				// ������� Petit FatFs		
#include "integer.h"			// ��������������� ����� char, int
#include "diskio.h"				// ��������� �������������� ������� 
								// ��� ������ � ������ ������	
// port B - SPI
#define Enable_Led_panel 1		// LED panel - pin 1
#define Enable_Memory_card 2 	// Flash card - pin 2

// port C - Buttons, Leds
#define Led_Red 0				// Led Red - pin 0
#define Led_Green 1				// Led Green - pin 1
#define Led_Blue 2				// Led Blue - pin 2
#define Button_1 3				// Button 1 - pin 3
#define Button_2 4				// Button 2 - pin 4
#define Button_3 5				// Button 3 - pin 5
#define Button_4 6				// Button 4 - pin 6
//------------------------------------------------------------------
//			���������� ����������
//------------------------------------------------------------------
EEMEM unsigned char rezhim_ee;	// ����� ������ (1, 2, 3 ��� 4)
struct filename					// �������� ������ � ����� "/images"
	{
		char one_file[13]; 		// �������� ������ �����
	} fn[20]; 					// �� 20 ������
	// 
unsigned char num_file = 0; 	// ����� ���������� �����
//------------------------------------------------------------------
//			������� ������������ ���������� (���� � ����������)
//------------------------------------------------------------------
FRESULT scan_files (char* path)			
{
	FRESULT res;
 	FILINFO fno;
	DIR dir;
	int i = 0; // index

    res = pf_opendir(&dir, path);		//open dir
    if (res == FR_OK) 
		{          
		   for (;;) 
		   {
         		res = pf_readdir(&dir, &fno);		//read dir
              	if (res != FR_OK || fno.fname[0] == 0) break;
              	if (fno.fattrib & ~AM_DIR) 
				{		//if object is a file
					for (int j = 0; j < 13; j++)
					{
						fn[i].one_file[j] = fno.fname[j];	
					}
					i++;			                                 
                }
       		}
		}
    return res;
}
//------------------------------------------------------------------
//			������� �������� ����� �� �� � ��� �� SPI (����) 
//------------------------------------------------------------------
unsigned char SPI_WriteByte(unsigned char byte)
{
	unsigned char ntry = 0;
	while(1)
	{
		if(ntry >= 16)
		return 0;	
		if((SPSR & 0b10000000) == 0b00000000) // elsi SPI svoboden
			SPDR = byte;
		else
		{
			ntry++;
			continue;
		}
		if((SPSR & 0b01000000) == 0b00000000) // esli net konflikta zapisi
			while((SPSR & 0b10000000) == 0b10000000) // do konca peredachi
			{		}
		else
		{	
			ntry++;
			continue;
		}
		break;
	}
	return 1;
}
//------------------------------------------------------------------
//			������� ����������� ���������� ����� �� MMC � ��� ()
//------------------------------------------------------------------
void copy_file() // podprogramma kopirovanija vibrannogo faila
{
	unsigned char read_buf[48]={}; // data 16 pixel
	unsigned int s1;
	unsigned char perek_addr_goriz = 0;
	unsigned char perek_addr_vert = 0; 
	unsigned char adres_panel = 0xCF; // adres paneli (bait)


	pf_lseek (54);					//smeshenie ukazatelya na 54 baita
	for (int i = 0; i < 256; i++)
	{
		//read 48 bytes to read_buf
		pf_read(read_buf, 48, &s1);

		// select panel
		PORTB |= _BV(Enable_Memory_card); // Bit Enable_Memory_card = 1
		PORTB |= ~_BV(Enable_Led_panel); // Bit Enable_Led_panel = 0
		
		// formirovanie adresa paneli i stroki		
		perek_addr_goriz ++;
		perek_addr_vert ++;

		if (perek_addr_goriz == 4)
		{
			adres_panel -= 0x31;
			perek_addr_goriz = 0;
		}
		else
		{
			adres_panel += 0x10;
		}

		if (perek_addr_vert == 64)
		{
			adres_panel -= 0x30;
			perek_addr_vert = 0;
		}
		
		// kopy data 16 pixel to panel
		SPCR = 0b11010000; //spi initialialization
		for (int i = 0; i < 48; i++)
		{
			SPI_WriteByte(read_buf[i]);
		}

		// select memory card
		PORTB |= ~_BV(Enable_Memory_card); // Bit Enable_Memory_card = 0
		PORTB |= _BV(Enable_Led_panel); // Bit Enable_Led_panel = 1
	} 
}
//------------------------------------------------------------------
//			������� �������� (��������� ��������, ����� ������)
//------------------------------------------------------------------
void delay_time(unsigned int interval, unsigned char rezhim) 
{
	unsigned int counter = 0; 	// �������
	do
	{
		_delay_ms(1000);		// �������� 1 �������

		// ���������� ������ ������ �� ����� �����
		if (bit_is_set (PINC,Button_1)) // elsi nazhata 1 knopka 
            rezhim_ee = 1; // vibran 1 rezhim
		if (bit_is_set (PINC,Button_2)) // elsi nazhata 2 knopka
            rezhim_ee = 2; // vibran 2 rezhim
        if (bit_is_set (PINC,Button_3)) // elsi nazhata 3 knopka
            rezhim_ee = 3; // vibran 3 rezhim
		if (bit_is_set (PINC,Button_4)) // elsi nazhata 4 knopka
            rezhim_ee = 4; // vibran 4 rezhim

		if (rezhim != rezhim_ee) // ���� ����� ���������
		{
			switch(eeprom_read_byte(&rezhim_ee)) // ������ ������ �� EEPROM 	
				{
					case 1: PORTC |= _BV(Led_Red); 
							break; // Led Red (100)
					case 2: PORTC |= _BV(Led_Green); 
							break; // Led Green (001)
					case 3: PORTC |= _BV(Led_Red); 
							PORTC |= _BV(Led_Green); 
							break; // Led Yellow (101)
					case 4: PORTB |= _BV(Led_Blue); 
							break; // Led Blue (010)
				}
			counter = interval; // ������� = ��������
		}
		else 					// ���� ����� �� ���������
		{
			counter ++;			// ������� ++
		};
	} while (counter < interval); // ���� ���� ������� < ���������
}
//------------------------------------------------------------------
//			�������� ���������
//------------------------------------------------------------------
void main ()
{ 
	FATFS fs;				// FatFs object
 	FRESULT res;			// result
//------------------------------------------------------------------ 
 	DDRB = 0b10101111;		// ��������� ��������� ����������� ������ B � �
 	DDRC = 0b00101010;		// 1 - �����, 0 - ����
 	PORTB |= ~_BV(Enable_Memory_card); // Bit Enable_Memory_card = 0
	PORTB |= _BV(Enable_Led_panel); // Bit Enable_Led_panel = 1
 
 	res=pf_mount(&fs);		// ������������ FAT
	if (res==0x00) 			// ���� FAT ������� ��������������
	{	
		scan_files ("images");		// scan files in directory "/images"
		if (res == FR_NO_FILE) 		// ���� � ����� ��� ������
			{
				PORTC |= _BV(Led_Red); // ����������� "��� ������"
				PORTC |= _BV(Led_Green); // white color (111)
				PORTC |= _BV(Led_Blue);  
			}
		else						// ���� � ����� ���� �����
			{
				switch(eeprom_read_byte(&rezhim_ee)) // ���������� �� EEPROM 	
				{									// ������ ������ ������	
					case 1: PORTC |= _BV(Led_Red); 	// ���� ������ ������ ������
							break; 					// Led Red (100)

					case 2: PORTC |= _BV(Led_Green);// ���� ������ ������ ������ 
							break; 					// Led Green (001)

					case 3: PORTC |= _BV(Led_Red);	// ���� ������ ������ ������ 
							PORTC |= _BV(Led_Green);// Led Yellow (101)
							break; 

					case 4: PORTB |= _BV(Led_Blue);	// ���� ������ ��������� ������ 
							break;					// Led Blue (010)
				} 

				res=pf_open(strcpy("/images/", fn[0].one_file)); 
				//�������� ������� �����

  				do 
				{
					switch(eeprom_read_byte(&rezhim_ee)) // ����� ������ ������	
					{
						case 1: // vibran rezhim staticheskoj kartinki
								copy_file(); // kopirovanie vibrannogo faila
								delay_time(3600, 1); // ozhidanie 3600 sec 
								break;

						case 2: // vibran rezhim pereklyuchenija cherez 5 sec
								copy_file(); // kopirovanie vibrannogo faila
								delay_time(5, 1); // ozhidanie 5 sec	
								res=pf_open(strcpy("/images/", fn[num_file].one_file)); 
								//open sled. file

								if (res = FR_OK) // esli eshe est' faili
									num_file ++; // vibiraetsya sled fail
								else
								{
									num_file = 0; // vibiraetsya pervij fail
									res=pf_open(strcpy("/images/", fn[0].one_file));
									//open first file
								}
								break;

						case 3: // vibran rezhim pereklyuchenija cherez 10 sec
								copy_file(); // kopirovanie vibrannogo faila
								delay_time(10, 1); // ozhidanie 10 sec
								res=pf_open(strcpy("/images/", fn[num_file].one_file)); 
								//open sled. file
		
								if (res = FR_OK) // esli eshe est' faili
									num_file ++; // vibiraetsya sled fail
								else
								{
									num_file = 0; // vibiraetsya pervij fail
									res=pf_open(strcpy("/images/", fn[0].one_file));
									//open first file
								}
								break;

						case 4: // vibran rezhim pereklyuchenija cherez 20 sec
								copy_file(); // kopirovanie vibrannogo faila
								delay_time(20, 1); // ozhidanie 20 sec
								res=pf_open(strcpy("/images/", fn[num_file].one_file)); 
								//open sled. file

								if (res = FR_OK) // esli eshe est' faili
									num_file ++; // vibiraetsya sled fail
								else
								{
									num_file = 0; // vibiraetsya pervij fail
									res=pf_open(strcpy("/images/", fn[0].one_file));
									//open first file
								}
								break; 
					} 
			
				
				} while (1); // ����������� ����
			}
	} 
	
} 

