import de.bezier.data.sql.*;
MySQL msql;

void setup( ) {
  size(100, 100);
  String user     = "root";
  String pass     = "1234";
  String database = "parking";

msql = new MySQL( this, "localhost:3306", database, user, pass );
if ( msql.connect() ){
      msql.query("CALL prc_addVehicule(1,'abc234',(SELECT NOW()))");
  msql.next();
  }
}
