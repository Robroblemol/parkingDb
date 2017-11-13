class ConcretePlaza extends PlazaCreator{
  Plaza newPlaza(String type,float xPos, float yPos){
    if(type.equals("moto")==true)
      return new PlazaMoto(xPos,yPos);
    else if(type.equals("carro")==true)
      return new PlazaAuto(xPos,yPos);
    else
      return new PlazaAuto(xPos,yPos);

  }
}
