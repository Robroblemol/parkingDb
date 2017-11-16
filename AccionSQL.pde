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
String s = "";
  if(pl.equals("*")==false){
    if(!flagMoto){
      //msql.next();
      msql.query("CALL prc_getVehicule('"+pl+"')");
      }else{
        //msql.next();
        msql.query("CALL prc_getMoto('"+pl+"')");
      }
      msql.next();
      s = "Id: "+ msql.getString(1)+" N° Plaza: "+
      msql.getString(2)+"\nPlaca Vehiculo: "+msql.getString(3)+
      " Fecha entrada: "+msql.getString(4)+"\n";
  }else{
    s = getAllVehicleSQL(pl);
  }
  txa1.setText(s);

}
String getAllVehicleSQL() {
  if(!flagMoto){
    msql.query("SELECT Count (*) FROM vehiculos");//carro
    msql.next();
  }else{
    msql.query("SELECT Count (*) FROM motos");
    msql.next();
  }
  int l = msql.getInt(1);
  String s = "";
  if(!flagMoto){
    msql.query("SELECT * FROM vehiculos");//carro
  }else{
    msql.query("SELECT * FROM motos");
  }
  for(int i = 0;i < l ;i++){
    msql.next();
    s = s + "Id: "+ msql.getString(1)+" N° Plaza: "+
    msql.getString(2)+"\nPlaca Vehiculo: "+msql.getString(3)+
    " Fecha entrada: "+msql.getString(4)+"\n";
  }
  return s;
}
String getAllVehicleSQL(String v) {
  msql.query("SELECT Count (*) FROM " +v);
  msql.next();
  int l = msql.getInt(1);
  String s = "";
  msql.query("SELECT * FROM "+ v);//carro
  for(int i = 0;i < l ;i++){
    msql.next();
    s = s + "Id: "+ msql.getString(1)+" N° Plaza: "+
    msql.getString(2)+"\nPlaca Vehiculo: "+msql.getString(3)+
    " Fecha entrada: "+msql.getString(4)+"\nFecha de salida: "+msql.getString(5);
  }
  return s;
}
void modSQL(String pl, int id){
  String s = "";
  if(!flagMoto){
    s = "CALL prc_editVehicule('"+pl+"',"+id+")";
    dP.setEstado(true,true,id);
  }else{
    s="CALL prc_editMoto('"+pl+"',"+id+")";
    dP.setEstado(false,true,id);
  }
  println(s);
  try{
    msql.next();
    msql.query(s);//carro
  }catch(RuntimeException e){
    G4P.showMessage(this, "Por favor digite una plaza valida", "Plaza Ocupada",
    G4P.ERROR );
  }

  //msql.query(s);//carro
  //msql.next();
  //int reply = G4P.selectOption(this, "Digite", "prueba", G4P.INFO, G4P.YES_NO);
}

void getNoPresentes(String pl) {
  String s;
  if(!pl.equals("*")){
    s = "CALL prc_getNopresente('"+pl+"')";
    println(s);
    msql.query(s);
    msql.next();
    s = "Id: "+ msql.getString(1)+" N° Plaza: "+
    msql.getString(2)+"\nPlaca Vehiculo: "+msql.getString(3)+
    " Fecha entrada: "+msql.getString(4)+"\nFecha de salida: "+msql.getString(5);
  }else{
    s=getAllVehicleSQL("nopresentes");
  }
    txa1.setText(s);
}
