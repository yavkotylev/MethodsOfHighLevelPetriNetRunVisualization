public class Place {
  public Place(String id, String name, float x, float y, float placeDiameter) {
    this.id = id;
    this.name = name;
    this.x = x;
    this.y = y;
    this.diameter = placeDiameter;
    this.radius = placeDiameter/2;
  }
  private final String id;
  private final String name;
  public final float diameter;
  public final float radius;
  private final ArrayList<Token> tokens = new ArrayList();
  private final HashMap<Transition, Arc> transitionMap= new HashMap();
  public float x;
  public float y;

  public void draw() {
    circle(x, y, diameter);
    drawArc();
    drawTokens();
  }

  public void addConnectionTo(Transition tr) {
    Arc arc = new Arc(this, tr);
    transitionMap.put(tr, arc);
  }
  public void addConnectionFrom(Transition tr) {
    Arc arc = new Arc(tr, this);
    transitionMap.put(tr, arc);
  }

  public void addToken(Token token) {
    tokens.add(token);
    updateTokenPositions();
    token.updateHalf();
  }

  public void removeToken(Token token) {
    tokens.remove(token);
    updateTokenPositions();
  }

  public Arc getArc(Transition tr) {
    return transitionMap.get(tr);
  }

  private void drawTokens() {
    for (int i = 0; i < tokens.size(); i++) {
      tokens.get(i).draw();
    }
  }
  private void drawArc() {
    for (Arc arc : transitionMap.values()) {
      arc.draw();
    }
  }

  private void updateTokenPositions() {
    if (tokens.size() == 1) {
      tokens.get(0).x = x;
      tokens.get(0).y = y;
    } else if (tokens.size() == 2) {
      tokens.get(0).x = x - radius/4;
      tokens.get(0).y = y;
      tokens.get(1).x = x + radius/4;
      tokens.get(1).y = y;
    } else if (tokens.size() == 3) {
      tokens.get(0).x = x - radius/4;
      tokens.get(0).y = y + radius/4;
      tokens.get(1).x = x + radius/4;
      tokens.get(1).y = y + radius/4;
      tokens.get(2).x = x;
      tokens.get(2).y = y - radius/4;
    } else if (tokens.size() == 4) {
      tokens.get(0).x = x - radius/4;
      tokens.get(0).y = y + radius/4;
      tokens.get(1).x = x + radius/4;
      tokens.get(1).y = y + radius/4;
      tokens.get(2).x = x + radius/4;
      tokens.get(2).y = y - radius/4;
      tokens.get(3).x = x - radius/4;
      tokens.get(3).y = y - radius/4;
    } else if (tokens.size() == 5) {
      tokens.get(0).x = x - radius/3;
      tokens.get(0).y = y + radius/3;
      tokens.get(1).x = x + radius/3;
      tokens.get(1).y = y + radius/3;
      tokens.get(2).x = x + radius/3;
      tokens.get(2).y = y - radius/3;
      tokens.get(3).x = x - radius/3;
      tokens.get(3).y = y - radius/3;
      tokens.get(4).x = x;
      tokens.get(4).y = y;
    } else if (tokens.size() == 6) {
      tokens.get(0).x = x - radius/3;
      tokens.get(0).y = y + radius/3;
      tokens.get(1).x = x;
      tokens.get(1).y = y + radius/3;
      tokens.get(2).x = x + radius/3;
      tokens.get(2).y = y + radius/3;


      tokens.get(3).x = x - radius/3;
      tokens.get(3).y = y - radius/3;
      tokens.get(4).x = x;
      tokens.get(4).y = y - radius/3;
      tokens.get(5).x = x + radius/3;
      tokens.get(5).y = y - radius/3;
    }
  }
}
