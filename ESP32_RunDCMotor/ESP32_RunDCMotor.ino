#include <WiFi.h>

#define MOTOR_GPIO   26

const char* ssid = "_";
const char* password = "_";
IPAddress local_IP(192, 168, 10, 54);
IPAddress gateway(192, 168, 10, 1);

WiFiServer wifiServer(80);

IPAddress subnet(255, 255, 255, 0);
 
void setup() {
  Serial.begin(115200);

  pinMode(MOTOR_GPIO, OUTPUT);

  // WI-FI
  if (!WiFi.config(local_IP, gateway, subnet)) {
    Serial.println("STA Failed to configure");
  }
  
  // Connect to Wi-Fi network with SSID and password
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
 
  Serial.print("\nWiFi connected with IP: ");
  Serial.println(WiFi.localIP());

  wifiServer.begin();
}
 
void loop() {
  WiFiClient client = wifiServer.available();
 
  if (client) {
    while (client.connected()) {
      String myString = "";
      
      while (client.available() > 0) {
        char c = client.read();
        myString += c;
      }

      char delim[] = ",";
      char aux[100];
      myString.toCharArray(aux, 100);
    
      char *str = strtok(aux, delim);
      int m_delay = atoi(strtok(NULL, delim));
      
      Serial.println("str :: ");
      Serial.println(str);
      Serial.println("m_delay :: ");
      Serial.println(m_delay);
      
      if(strcmp(str, "M") == 0) {
        client.write("done_dc_motor");
        runDCMotor(m_delay);
        
      }

      delay(10);
    }
 
    client.stop();
    Serial.println("Client disconnected");
  }

  Serial.println("No client...");
  delay(2000);
}


void runDCMotor(int d) {
  Serial.println("ON...");
  digitalWrite(MOTOR_GPIO, HIGH); // sets the digital pin 13 on
  delay(d);            // waits for a second
  digitalWrite(MOTOR_GPIO, LOW);  // sets the digital pin 13 off
  Serial.println("OFF...");
}
