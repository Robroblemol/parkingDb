void addSQL( ) {
  String s;
  int p;
  if(!flagMoto){
    p = dP.getFreePlaza(true);
    s = "CALL prc_addVehicule("+p+",'"+txfPlaca.getText()+"',(SELECT NOW()))";
    dP.setEstado(true,true,p);
  }
  else{
    p = dP.getFreePlaza(false);
    s = "CALL prc_addMoto("+p+",'"+txfPlaca.getText()+"',(SELECT NOW()))";
    dP.setEstado(false,true,p);
  }
  if(p>=0){
    println(s);
    //msql.query(s);
    //msql.next();
  }
}
int getNPLazaSQL (Boolean f){// devuelve el numero de plazas
  //int length;
  if(f){
    msql.query("SELECT Count (*) FROM plazas");//carro
    msql.next();
  }else{
    msql.query("SELECT Count (*) FROM plazaMotos");
    msql.next();
  }
  return msql.getInt(1);
  //length=msql.getInt(1);

}
