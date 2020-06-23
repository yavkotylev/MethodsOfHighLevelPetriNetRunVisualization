class MainNet extends Net {
  private final ArrayList<ElementNet> elementNets = new ArrayList();
  public void draw() {
    //drawBorders();
    super.draw();

    ArrayList<ElementNet> drawnUp = new ArrayList();
    ArrayList<ElementNet> drawnDown = new ArrayList();
    for (ElementNet elementNet : elementNets) {
      if (elementNet.isDisplayed()) {
        ArrayList<ElementNet> drawnForHalf;
        if (elementNet.updateAndGetHalf()) {
          drawnForHalf = drawnUp;
        } else {
          drawnForHalf = drawnDown;
        }
        elementNet.draw(drawnForHalf);
        drawnForHalf.add(elementNet);
      }
    }
    for (ElementNet elementNet : elementNets) {
      elementNet.netShiftY = 0;
    }
  }

  public void addElementNet(ElementNet elementNet) {
    elementNets.add(elementNet);
  }

  public void updateElementNetIsDisplayed(int time) {
    for (ElementNet en : elementNets) {
      en.updateIsDisplayed(time);
    }
  }

  public ArrayList<ElementNet> getElementNets() {
    return elementNets;
  }

  public ElementNet getElementNetById(String enId) {
    for (ElementNet en : elementNets) {
      if (en.id.equals(enId)) {
        return en;
      }
    }
    return null;
  }
  private void drawBorders() {
    rect(left, up, right - left, down - up);
  }
}
