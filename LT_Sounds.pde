
//Laser Fire
int LASER_START = 1000;
int LASER_END = 500;
int LASER_STEP = 1;
int LASER_REPEAT = 3;

int DE_START = 750;
int DE_END = 200;
int DE_STEP = 100;
int DE_DELAY = 75;
int DE_REPEAT = 1;

int RE_START = 200;
int RE_END = 750;
int RE_STEP = 100;
int RE_DELAY = 75;
int RE_REPEAT = 1;

void playShot(int pin)
{
    for(int k=0; k<LASER_REPEAT;k++)
    {
      for(int i=LASER_START; i>LASER_END; i=i-LASER_STEP)
      {
        tone(pin,i);
      }
    }
    
    noTone(pin);
}
   
void playDeactivate(int pin)
{
   for(int i=DE_START; i>DE_END; i=i-DE_STEP)
   {
     tone(pin,i);
     delay(DE_DELAY);
   }
   
   noTone(pin);
}

void playActivate(int pin)
{
   for(int i=RE_START; i<RE_END; i=i+RE_STEP)
   {
     tone(pin,i);
     delay(RE_DELAY);
   }   
   
   noTone(pin);
}
