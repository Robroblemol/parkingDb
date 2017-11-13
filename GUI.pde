import g4p_controls.*;//importamos libreria

GLabel lbTitle,lbEditVehiculo,lbBorrar,lbgetVehiculo;
GButton bAdd,bSelect,bRm,bEdit;
GTextField txfPlaca;
PlazaCreator pCreator;
Plaza  pA,pM;

void initGui( ) {
  G4P.setGlobalColorScheme(GCScheme.RED_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Parking Control");
  pCreator = new ConcretePlaza();
  pA = pCreator.newPlaza("carro",90,220);
  pM = pCreator.newPlaza("moto",90,320);
  createControlGruop();
}
void createControlGruop( ) {
  bAdd = new GButton(this,70,125,100,35,"Add");
  bAdd.fireAllEvents(true);
  bSelect = new GButton(this,180,125,100,35,"Buscar");
  bSelect.fireAllEvents(true);
  bRm = new GButton(this,290,125,100,35,"Borrar");
  bRm.fireAllEvents(true);
  bEdit = new GButton(this,400,125,100,35,"Modificar Plaza");


  txfPlaca = new GTextField(this, 70, 80, 100, 20);
  txfPlaca.tag = "txfPlaca";
  txfPlaca.setPromptText("Digite Placa");

}
 void showGUIProcessing() {
  fill(255);
  textSize(30);
  text("Parking Control",250, 50);
  fill(255);
  textSize(25);
  text("Plazas Disponibles Automovil",90, 200);
  text("Plazas Disponibles Moto",90, 300);
  pA.drawPlaza();
  pM.drawPlaza();

}
public void handleButtonEvents(GButton button, GEvent event) {

}
public void handleTextEvents(GEditableTextControl textcontrol, GEvent event) {
}
