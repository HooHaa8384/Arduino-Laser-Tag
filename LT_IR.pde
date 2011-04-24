int PACKET_HEADER  = 250;
int BIT_HEADER     = 250;
int BIT_0          = 250;
int BIT_1          = 500;

byte HEADER     = 0xA6;
byte FUNC_SHOT  = 0x01;

#define IR_REG PORTB
int IR_BIT = 1<<1;

void sendShot(int team)
{
  byte data [] = {HEADER, FUNC_SHOT, team, NULL};
  sendPacket(data);
}

void sendPacket(byte data [])
{
   if(NULL != data[0])
   {   
      int i = 0;
      
      for(int k=0; data[k] != NULL;k++)
      {
        Serial.println(int(data[k]));
      }
      turnIROn(PACKET_HEADER);
      
      while (NULL != data[i])
      {
         byte bitMask = 0x80;         
        
         do
         {
            if((data[i] & bitMask) == 0)
            {
               send0();
               //Serial.println("sending 0");
            }
            else 
            {
               send1();
               //Serial.println("sending 1");
            }
         
            bitMask = bitMask >> 1;
         }
         while (bitMask != 0);
        
         //Serial.println("");
         i++;
      }
      
      turnIROn(PACKET_HEADER + BIT_HEADER);
   }
}

void send0()
{
   turnIROn(BIT_HEADER);
   delayMicroseconds(BIT_0);
}

void send1()
{
   turnIROn(BIT_HEADER);
   delayMicroseconds(BIT_1);
}

void turnIROn(int t)
{
   byte irOn = IR_REG | IR_BIT;
   byte irOff = IR_REG & ~IR_BIT;
   
   while (t>0)
   {
      IR_REG = irOn;
      delayMicroseconds(13);
      IR_REG = irOff;
      delayMicroseconds(13);
      t -= 26;
   }
}
