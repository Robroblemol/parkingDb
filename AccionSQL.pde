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
