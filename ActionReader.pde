public class ActionReader {

  private final NetReader netReader;

  public ActionReader(NetReader netReader) {
    this.netReader = netReader;
  }
  public Action readAction(XML actionXml, MainNet mainNet) {
    XML timeXml = actionXml.getChildren("time")[0];
    int startTime =timeXml.getInt("startTime");
    int endTime = timeXml.getInt("endTime");
    int weight =  actionXml.getChildren("weight")[0].getInt("value");

    XML netXml = actionXml.getChildren("net")[0];
    Net net = getNet(netXml, mainNet);
    Transition transition = net.getTransitionById(netXml.getString("transitionId"));
    HashMap<Token, Place> addMap = getTokenPlaceMap(actionXml.getChildren("addTokens")[0], net);
    HashMap<Token, Place> removeMap = getTokenPlaceMap(actionXml.getChildren("removeTokens")[0], net);
    color transitionCol = netReader.readColor(actionXml); //<>//
    println(transitionCol);
    return new Action(startTime, endTime, weight, transition, net, removeMap, addMap, transitionCol);
  }

  private Net getNet(XML netXml, MainNet mainNet) {
    String netId = netXml.getString("netId");
    if (mainNet.id.equals(netId)) {
      return mainNet;
    }
    return mainNet.getElementNetById(netId);
  }

  private HashMap<Token, Place> getTokenPlaceMap(XML tokenPlacesXml, Net net) {
    HashMap<Token, Place> map = new HashMap();
    XML[] tokenPlaceXml = tokenPlacesXml.getChildren("token");
    for (XML tp : tokenPlaceXml) {
      map.put(net.getTokenById(tp.getString("tokenId")), net.getPlaceById(tp.getString("placeId")));
    }
    return map;
  }
}
