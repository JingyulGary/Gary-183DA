// Jingyu Li (004-616-099)
// EE 183DA
// Lab 2
#include <Servo.h>
#include <ESP8266WiFi.h>

const short int LED1 = 2; //GPIO2
const short int LED2 = 16;//GPIO16
Servo servo1, servo2;
WiFiServer server(80);

void setup() {
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  servo1.attach(5);//GPIO5 Servo
  servo2.attach(4);//GPIO4 Continuous Servo
  servo1.write(90);//Initialize both servo
  servo2.write(90);

  // Setup the Wifi AP
  WiFi.mode(WIFI_AP);
  WiFi.softAP("004616099", "12341234");
  server.begin();
  Serial.begin(115200);
  IPAddress HTTPS_ServerIP = WiFi.softAPIP();
  Serial.println();
  Serial.print("Server IP is: ");
  Serial.println(HTTPS_ServerIP);
  digitalWrite(LED1, LOW);
  digitalWrite(LED2, HIGH);
}

void loop() {
  WiFiClient client = server.available();
  if (!client) {
    return;
  }
  Serial.println("Somebody has connected :)");
  String request = client.readString();
  Serial.println(request);
  if (request.indexOf("/TEST") != -1) {
    one();
    Serial.println("TEST DONE!!");
  }
  else if (request.indexOf("/GO") != -1) {
    two();
    Serial.println("GO DONE!!");
  }

}

// Test Part
void one() {
  int pos;

  for (pos = 0; pos <= 180; pos += 5) 
  { // in steps of 1 degree
    digitalWrite(LED2, LOW);
    servo2.write(0);
    servo1.write(pos);              
    delay(15);                      
    digitalWrite(LED2, HIGH);
  }
  for (pos = 180; pos >= 0; pos -= 5) 
  {
    digitalWrite(LED2, LOW);
    servo2.write(180);
    servo1.write(pos);              
    delay(15);
    digitalWrite(LED2, HIGH);
  }
  servo1.write(90);//reset the servos
  servo2.write(90);
}

// This is the GO part
void two() {
  digitalWrite(LED2, LOW);
  int i;
  for (i = 0; i <= 6; i++) {
    servo2.write(0);
    servo1.write(45);
    delay(400);
    servo1.write(135);
    delay(400);
    servo2.write(180);
    servo1.write(45);
    delay(400);
    servo1.write(135);
    delay(400);
  }
  for (i=0;i<=6;i++){
    servo2.write(0);
    servo1.write(0);
    delay(300);
    servo2.write(180);
    servo1.write(180);
    delay(400);
  }
  digitalWrite(LED2, HIGH);
  servo2.write(90);// reset the servos
  servo1.write(90);
}

