const int zeroSensor = A0;
const int oneSensor = A1;
const int threshold = 20;
int zeroRead, oneRead;
int pzeroRead, poneRead;

void setup() {
  Serial.begin(9600);
}

void loop() {

  zeroRead = analogRead(zeroSensor);
  if (zeroRead>pzeroRead && abs(zeroRead - pzeroRead)>threshold)Serial.println(0);
  pzeroRead = zeroRead;

  oneRead = analogRead(oneSensor);
  if (oneRead > poneRead && abs(oneRead - poneRead) > threshold)Serial.println(1);
  poneRead = oneRead;

  delay(100);
}
