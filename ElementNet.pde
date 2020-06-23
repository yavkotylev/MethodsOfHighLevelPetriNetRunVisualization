public class ElementNet extends Net {
  private final ArrayList<Token> referenceTokens = new ArrayList();
  private final Net mainNet;
  private boolean displayed = false;
  private boolean isAtUpperHalf = false;
  private final float interval = 30;
  private final ArrayList<TimeInterval> displayedIntervals = new ArrayList();

  private final int timeInterval;
  private final int distanceBetweenTimeIntervals;
  private final int treshold;

  private float borderWidth, borderHalfWidth, borderHeight;

  public float netShiftX, netShiftY;

  public ElementNet (Net mainNet, int timeInterval, int distanceBetweenTimeIntervals, int treshold) {
    this.mainNet = mainNet;
    this.timeInterval = timeInterval;
    this.distanceBetweenTimeIntervals = distanceBetweenTimeIntervals;
    this.treshold = treshold;
  }

  public void draw(ArrayList<ElementNet> drawnNets) {
    float additionalShift = getAdditionalShiftY(drawnNets) ; //<>//
    float tempShiftY = 0;
    if (isAtUpperHalf) {
      tempShiftY = mainNet.up - borderHeight/2 - additionalShift - interval ;
    } else {
      tempShiftY = mainNet.down + borderHeight/2  + additionalShift + interval;
    }
    translate(netShiftX - middleX, tempShiftY); //<>//
    drawBorders();
    super.draw();
    translate(-netShiftX + middleX, -tempShiftY);
    netShiftY = additionalShift + borderHeight + interval;
    drawConnections(tempShiftY);
  }

  public void addPlace(Place place) {
    super.addPlace(place);
    borderWidth = right - left;
    borderHeight = down - up;
    borderHalfWidth = borderWidth/2;
  }

  public void addTransition(Transition transition) {
    super.addTransition(transition);
    borderWidth = right - left;
    borderHeight = down - up;
    borderHalfWidth = borderWidth/2;
  }

  public boolean updateAndGetHalf() {
    float tokenCount = 0;
    float tokenSummY = 0;
    float tokenSummX = 0;
    for (Token t : referenceTokens) {
      if (mainNet.hasActiveToken(t)) {
        tokenCount++;
        tokenSummY += t.getY();
        tokenSummX += t.getX();
      }
    }
    netShiftX = tokenSummY/tokenCount;
    netShiftX = tokenSummX/tokenCount;
    return this.isAtUpperHalf = mainNet.middleY > tokenSummY/tokenCount;
  }

  public void updateIsDisplayed(int time) {
    for (TimeInterval interv : displayedIntervals) {
      if (time >= interv.start && time <= interv.end) {
        displayed = true;
        return;
      }
    }
    displayed = false;
  }

  public void addDisplayedTimeInterval(int start, int end) {
    displayedIntervals.add(new TimeInterval(start, end));
  }

  public boolean isDisplayed() {
    return displayed;
  }

  public float getNetShiftX() {
    return netShiftX;
  }

  public float getNetShiftY() {
    return netShiftY;
  }

  public float getBorderHalfWidth() {
    return borderHalfWidth;
  }

  public void addReferenceToken(Token token) {
    referenceTokens.add(token);
  }


  private void drawBorders() {
    rect(left, up, borderWidth, borderHeight);
  }

  private void drawConnections(float tempShiftY) {
    for (Token t : referenceTokens) {
      if (mainNet.hasActiveToken(t)) {
        if (isAtUpperHalf) {
          line(netShiftX, tempShiftY + borderHeight/2, t.getX(), t.getY());
        } else {
          line(netShiftX, tempShiftY - borderHeight/2, t.getX(), t.getY());
        }
      }
    }
  }

  private class TimeInterval {
    public TimeInterval (int start, int end) {
      this.start = start;
      this.end = end;
    }
    int start;
    int end;
  }

  private float getAdditionalShiftY(ArrayList<ElementNet> drawnNets) {
    float additionalShiftY = 0;
    for (ElementNet checkNet : drawnNets) {
      float checkRight = checkNet.getNetShiftX() + checkNet.getBorderHalfWidth();
      float checkLeft = checkNet.getNetShiftX() - checkNet.getBorderHalfWidth();
      float thisRight = netShiftX + borderHalfWidth;
      float thisLeft = netShiftX - borderHalfWidth;
      if (!(checkRight < thisLeft || checkLeft > thisRight)) {
        if (additionalShiftY < checkNet.getNetShiftY()) {
          additionalShiftY = checkNet.getNetShiftY();
        }
      }
    }
    return additionalShiftY;
  }
}
