void addSQL( ) {
  String s;
  int p;
  if(!flagMoto){
    p = dP.getFreePlaza(true);
    s = "CALL prc_addVehicule("+(p+1)+",'"+txfPlaca.getText()+"',(SELECT NOW()))";
    dP.setEstado(true,true,p);
  }
  else{
    p = dP.getFreePlaza(false);
    s = "CALL prc_addMoto("+(p+1)+",'"+txfPlaca.getText()+"',(SELECT NOW()))";
    dP.setEstado(false,true,p);
  }
  if(p>=0){
    println(s);
    msql.query(s);
    msql.next();
  }
}
int getNPLazaSQL (Boolean f){// devuelve el numero de plazas
  if(f){
    msql.query("SELECT Count (*) FROM plazas");//carro
    msql.next();
  }else{
    msql.query("SELECT Count (*) FROM plazaMotos");
    msql.next();
  }
  return msql.getInt(1);
}

void rmSQLVehicle(String pl) {
  String s;
  int p = getIdSQLPlaca(pl);
  println("id: "+p);
  if(!flagMoto){
     s = "CALL prc_rmVehicule('"+pl+"')";
     dP.setEstado(true,false,p-1);
  }else{
     s = "CALL prc_rmMoto('"+pl+"')";
     dP.setEstado(false,false,p-1);
  }
  println(s);
  msql.query(s);
  msql.next();
}
int getIdSQLPlaca(String pl){
  if(!flagMoto){
    msql.query("CALL prc_getVehicule('"+pl+"')");
    msql.next();
  }else{
    msql.query("CALL prc_getMoto('"+pl+"')");
    msql.next();
  }
  return msql.getInt(2);
}
void getVehicleSQL(String pl ) {
  if(pl.equals("*")==false){
    if(!flagMoto){
      msql.query("CALL prc_getVehicule('"+pl+"')");
      msql.next();
      }else{
        msql.query("CALL prc_getMoto('"+pl+"')");
        msql.next();
      }
  }else{
  }
  String s = "Id: "+ msql.getString(1)+" N° Plaza: "+
  msql.getString(2)+"\nPlaca Vehiculo: "+msql.getString(3)+
  " Fecha entrada: "+msql.getString(4)+"\n";
  txa1.setText(s);

}
