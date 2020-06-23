public class NetReader { //<>// //<>//
  private float placeDiameter = 50;
  private  float transitionDiameter = 50;
  private  float tokenDiameter = 10;


  public void readElementNet(XML xmlElementNet, ElementNet elementNet, MainNet mainNet) {
    placeDiameter = 25;
    transitionDiameter = 25;
    tokenDiameter = 5;
    readNet(xmlElementNet, elementNet);
    addReferenceTokens(elementNet, xmlElementNet, mainNet);
    placeDiameter = 50;
    transitionDiameter = 50;
    tokenDiameter = 10;
  }
  public void readNet(XML xmlNet, Net net) {
    net.id = readId(xmlNet);
    XML[] placesXml = xmlNet.getChildren("places")[0].getChildren("place");
    for (XML placeXml : placesXml) {
      net.addPlace(new Place(readId(placeXml), readName(placeXml), readPositionX(placeXml), readPositionY(placeXml), placeDiameter));
    }

    XML[] transitionsXml = xmlNet.getChildren("transitions")[0].getChildren("transition");
    for (XML transitionXml : transitionsXml) {
      net.addTransition(new Transition(readId(transitionXml), readName(transitionXml), readPositionX(transitionXml), readPositionY(transitionXml), transitionDiameter));
    }

    XML[] tokensXml = xmlNet.getChildren("tokens")[0].getChildren("token");
    for (XML tokenXml : tokensXml) {
      String id = tokenXml.getString("id");
      String name = readName(tokenXml);
      color c = readColor(tokenXml);
      net.addAllToken(new Token(readId(tokenXml), readName(tokenXml), tokenDiameter, c));
    }

    XML[] arcsXml = xmlNet.getChildren("arcs")[0].getChildren("arc");
    for (XML arcXml : arcsXml) {
      net.addArc(readArc(net, arcXml));
    }

    XML[] imsXml = xmlNet.getChildren("initialMarking")[0].getChildren("im");
    for (XML imXml : imsXml) {
      addInitialMarking(imXml, net);
    }
  }

  private String readId(XML node) {
    return node.getString("id");
  }

  private String readName(XML node) {
    return node.getChildren("name")[0].getContent();
  }

  private float readPositionX(XML node) {
    try {
      return Float.valueOf(node.getChildren("graphics")[0].getChildren("position")[0].getFloat("x"));
    }     
    catch (Exception e) {
      return 0;
    }
  }

  private float readPositionY(XML node) {
    try {
      return node.getChildren("graphics")[0].getChildren("position")[0].getFloat("y");
    } 
    catch (Exception e) {
      return 0; //<>//
    } //<>//
  }

  private color readColor(XML node) {
    try {
      XML col = node.getChildren("color")[0];
      int r = col.getInt("r");
      int g = col.getInt("g");
      int b = col.getInt("b");
      return color(r, g, b);
    } 
    catch (Exception e) {
      return color(255, 255, 255);
    }
  }

  private Arc readArc(Net net, XML node) {
    String idFrom = node.getChildren("from")[0].getContent();
    String idTo = node.getChildren("to")[0].getContent();
    BaseShape from = null;
    BaseShape to = null;
    for (Place place : net.places) {
      if (place.id.equals(idFrom)) {
        from = place;
      }
      if (place.id.equals(idTo)) {
        to = place;
      }
    }
    for (Transition transition : net.transitions) {
      if (transition.id.equals(idFrom)) {
        from = transition;
      }
      if (transition.id.equals(idTo)) {
        to = transition;
      }
    }
    if (from instanceof Place) {
      return new Arc((Place)from, (Transition)to);
    } else {
      return new Arc((Transition)from, (Place)to);
    }
  }

  private void addReferenceTokens(ElementNet elementNet, XML elementNetXml, MainNet mainNet) {
    XML[] referenceTokensXml = elementNetXml.getChildren("referenceTokens")[0].getChildren("tokenId");
    for (XML referenceTokenXml : referenceTokensXml) {
      elementNet.addReferenceToken(mainNet.getTokenById(readId(referenceTokenXml)));
    }
  }

  private void addInitialMarking(XML node, Net net) {
    String tokenId = node.getChildren("token")[0].getContent();
    String placeId = node.getChildren("place")[0].getContent();
    Token token = net.getTokenById(tokenId);
    net.addActiveToken(token);
    net.getPlaceById(placeId).addToken(token);
  }
}
