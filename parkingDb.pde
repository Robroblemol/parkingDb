import de.bezier.data.sql.*;
MySQL msql;

void setup( ) {
  size(700, 500);
  String user     = "root";
  String pass     = "1234";
  String database = "parking";
msql = new MySQL( this, "localhost:3306", database, user, pass );
if ( msql.connect() ){
  //msql.query("CALL prc_addVehicule(1,'abc123',(SELECT NOW()))");
  msql.query("CALL prc_getVehicule('abc123')");
  msql.next();
  println("id: "+ msql.getString(1));
  println("idPlaza: "+msql.getString(2));
  println("placa: "+msql.getString(3));
  println("fecha_ent: "+msql.getString(4));
  //println("idPlaza: "+msql.getString(2));
  }
initGui();
}
void draw(){
  background(0);
  showText();
}
