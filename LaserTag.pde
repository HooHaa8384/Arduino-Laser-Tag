int motorPin1 = 6;
int motorPin2 = 7;
int irPin = 9;
int irSensor = 8;

int TRIGGER_PIN = 3;
int SPEAKER_PIN = 4;
const int RED_PIN = 11;
const int YELLOW_PIN = 12;

int TEAM_SWITCH_TIMEOUT = 3000;

enum
{
  RED = RED_PIN,
  YELLOW = YELLOW_PIN
};

int mTeam = YELLOW;

boolean FIRE = false;

void setup()
{
  pinMode(SPEAKER_PIN, OUTPUT);
  pinMode(YELLOW_PIN, OUTPUT);
  pinMode(RED_PIN, OUTPUT);
  pinMode(TRIGGER_PIN, INPUT);
  
  digitalWrite(YELLOW_PIN, HIGH);
  
  Serial.begin(9600);
}

void loop()
{
 
  if(0 == digitalRead(irSensor))
  {
    //processHit();
  }  

  if(HIGH == digitalRead(TRIGGER_PIN))
  {
    //Serial.println("Firing");
    FIRE = true;
    
    playShot(SPEAKER_PIN);
    /*delay(500);
    playDeactivate(SPEAKER_PIN);
    delay(500);
    playActivate(SPEAKER_PIN);
    */
    
    sendShot(mTeam);
    
    //Serial.println("switch Team");
    switchTeam();

    //Serial.println("Wait");
    while(HIGH == digitalRead(TRIGGER_PIN))
    {
      //Wait here until the trigger is released
    }
    //Serial.println("delay");
    delay(250);
  }
}

void switchTeam()
{
  unsigned long start = millis();

  while(digitalRead(TRIGGER_PIN) == HIGH)
  {
    if(millis() > start + TEAM_SWITCH_TIMEOUT)
    {
      if(mTeam == RED)
      {
        digitalWrite(RED_PIN, LOW);
        digitalWrite(YELLOW_PIN, HIGH);
        mTeam = YELLOW;
        return;
      }
      else
      {
        digitalWrite(YELLOW_PIN, LOW);
        digitalWrite(RED_PIN, HIGH);
        mTeam = RED;
        return;
      }
    }
  }
}

void turnMotorOn()
{
  digitalWrite(motorPin1,HIGH);
  digitalWrite(motorPin2,HIGH);
}

void turnMotorOff()
{
  digitalWrite(motorPin1,LOW);
  digitalWrite(motorPin2,LOW);  
}
