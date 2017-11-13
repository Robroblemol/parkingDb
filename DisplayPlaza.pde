class DisplayPlaza{
ArrayList<Plaza> arrayMoto = new ArrayList<Plaza>();
ArrayList<Plaza> arrayAuto = new ArrayList<Plaza>();
  int lengthAuto,lengthMoto;
  float intXPos, intYPos;
  Plaza  p;
  PlazaCreator pCreator;
  int l,factoX = 15,factoY = 100;

  DisplayPlaza(float xPos, float yPos){
    intXPos = xPos;
    intYPos = yPos;
    msql.query("SELECT Count (*) FROM plazas");
    msql.next();
    lengthAuto = msql.getInt(1);
    msql.query("SELECT Count (*) FROM plazaMotos");
    msql.next();
    lengthMoto = msql.getInt(1);
  //  println("lengthMoto: "+lengthMoto);
  //    println("lengthAuto: "+lengthAuto);
  pCreator = new ConcretePlaza();
  builPlaza("carro");
  }

  void builPlaza(String text){
      if(text.equals("carro")==true) l=lengthAuto;
      for(int i=0;i<l;i++){
        if(text.equals("carro")==true)
          arrayAuto.add(p = pCreator.newPlaza(text,intXPos+(factoX*i),intYPos));
        else if (text.equals("moto")==true)
          arrayMoto.add(p = pCreator.newPlaza(text,intXPos+(factoX*i),intYPos+factoY));
      }
      if(text.equals("carro")==true){
        text="moto";
        l=lengthMoto;
        builPlaza(text);
        }
  }
  void drawAllPlaza( Boolean flag) {
    if(flag==true) l=lengthAuto;
    for(int i=0;i<l;i++){
      if(flag==true)
        arrayAuto.get(i).drawPlaza();
      else if (flag==false)
        arrayMoto.get(i).drawPlaza();
    }
    if(flag==true){
      flag=false;
      l=lengthMoto;
      drawAllPlaza(flag);
      }
  }
  void setIntXPos(float xPos) {
    intXPos = xPos;
  }
  void setIntYPos(float yPos) {
    intYPos = yPos;
  }
  int getLength(Boolean flag){
    if (flag)
      return lengthAuto;
    else
      return lengthMoto;
  }

}
