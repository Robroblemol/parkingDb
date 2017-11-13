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
    lengthAuto = getNPLazaSQL(true);
    lengthMoto = getNPLazaSQL(false);
  //  println("lengthMoto: "+lengthMoto);
  //    println("lengthAuto: "+lengthAuto);
  pCreator = new ConcretePlaza();
  builPlaza("carro");
  }

  void builPlaza(String text){
      if(text.equals("carro")==true) l=lengthAuto;
      for(int i=0;i<l;i++){
        if(text.equals("carro")==true){
          p = pCreator.newPlaza(text,intXPos+(factoX*i),intYPos);
          p.setEstado(getEstadoDb(i+1,true));
          arrayAuto.add(p);
        }
        else if (text.equals("moto")==true){
          p = pCreator.newPlaza(text,intXPos+(factoX*i),intYPos+factoY);
          p.setEstado(getEstadoDb(i+1,false));
          arrayMoto.add(p);
        }
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
  void setEstado(Boolean f,Boolean es,int i) {
    if (f)
      arrayAuto.get(i).setEstado(es);
    else
      arrayMoto.get(i).setEstado(es);
  }
  Boolean getEstadoDb(int i,boolean f){// estado de las plazas
    String s;
    if (f) s = "SELECT estado FROM plazas WHERE id="+i;
    else   s = "SELECT estado FROM plazaMotos WHERE id="+i;
    msql.query(s);
    msql.next();
    Boolean stts = msql.getBoolean(1);
    //println("estado Plaza "+i+": "+stts);
    return stts;

  }
  int getFreePlaza(boolean f){
    int free = 0;
    for(int i = 0;i<getLength(f);i++){
      if(f){
      //    println("plaza "+i+" = "+arrayAuto.get(i).getEstado());
        if(!arrayAuto.get(i).getEstado()){
          free = i;
          break;
        }
      }else{
        if(!arrayMoto.get(i).getEstado()){
          free = i;
          break;
        }
      }
    }
    println("free: "+free);
    return free;
  }
}
