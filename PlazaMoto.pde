class PlazaMoto implements Plaza{
  float xPos = 0, yPos = 0;
  float xArea = 10, yArea = 20;
  color c;
  PlazaMoto(float xPos,float yPos){
    this.xPos=xPos;
    this.yPos=yPos;
    this.c = color(51,255,54);
  }
  void drawPlaza(){
    fill (c);//color rojo
    noStroke();
    rect(xPos,yPos,xArea,yArea);
    stroke(0);
  }
  color getColor() {
    return c;
  }
  float getXPos(){
    return xPos;
  }
  float getYPos(){
    return yPos;
  }

  void setColor(color c){
  this.c=c;
}
void setXpos(float xPos){
  this.xPos=xPos;
}
void setYpos(float yPos){
  this.yPos=yPos;
}
void setPos(float xPos,float yPos ) {
  setXpos(xPos);
  setYpos(yPos);
}
}
