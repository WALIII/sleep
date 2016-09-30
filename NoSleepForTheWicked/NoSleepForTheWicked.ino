


// the setup function runs once when you press reset or power the board

int mn = 10; // 10 min, min wait btw pulses
int mx = 60; // 60 min, max wait btw pulses
void setup() {
  // initialize digital pin 13 as an output.
  pinMode(13, OUTPUT);
}

// the loop function runs over and over again forever
void loop() {

  int repeat = random(10);
  int waitOn = random(100,10);
  long waitOff = random(60000*mn,60000*mx); // min,max 60,000 

 for (int i=0; i <= repeat; i++){
      

  digitalWrite(13, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(waitOn);      
  
                    // wait for a second
  digitalWrite(13, LOW);    // turn the LED off by making the voltage LOW
  delay(waitOn);              // wait for a second


   } 
    
  delay(waitOff);
   }
