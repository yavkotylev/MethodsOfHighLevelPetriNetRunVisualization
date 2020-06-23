class ModelReader { //<>// //<>// //<>//

  private final NetReader netReader;
  private final ActionReader actionReader;
  private final XML xml;
  public ModelReader(String fileName) {
    this.xml = loadXML(fileName);
    this.netReader = new NetReader();
    this.actionReader = new ActionReader(netReader);
  }


  public MainNet readMainNet() {
    XML mainNetXML = xml.getChildren("mainNet")[0];
    MainNet mainNet =  new MainNet();
    netReader.readNet(mainNetXML, mainNet);
    println("MainNet has been read");
    XML[] elementNetsXml = xml.getChildren("elementNets")[0].getChildren("elementNet");
    for (XML elementNetXml : elementNetsXml) {
      mainNet.addElementNet(readElementNet(elementNetXml, mainNet));
    }
    return mainNet;
  }

  public ActionController getActionController(MainNet mainNet) {
    ActionController actionController = new ActionController(mainNet);
    XML[] actionsXml = xml.getChildren("actions")[0].getChildren("action");
    for (XML actionXml : actionsXml) {
      actionController.addAction(actionReader.readAction(actionXml, mainNet));
    }
    actionController.addElementNetTimeIntervals();
    return actionController;
  }

  private ElementNet readElementNet(XML elementNetXml, MainNet mainNet) {
    XML displaying = elementNetXml.getChildren("displaying")[0];
    int timeInterval = displaying.getInt("interval");
    int distanceBetweenTimeIntervals = displaying.getInt("distance");
    int treshold = displaying.getInt("treshold");
    ElementNet elementNet = new ElementNet(mainNet, timeInterval, distanceBetweenTimeIntervals, treshold);
    netReader.readElementNet(elementNetXml, elementNet, mainNet);
    println("elementNet has been read");
    return elementNet;
  }
}
