

void setup() {
  size(1080, 700);
  frameRate(24);
}

float scale = 0.5;
float firstX = -1;
float firstY = -1;
float translateX = 200;
float translateY = 200;

MainNet mainNet = new MainNet();
ElementNet en1 = new ElementNet();
ElementNet en2 = new ElementNet();

Token t1 = new Token(10);
Token t2 = new Token(10);
Token t3 = new Token(10);
Token t4 = new Token(10);



ReferenceToken rt1 = new ReferenceToken(10, mainNet, en1);
ReferenceToken rt2 = new ReferenceToken(10, mainNet, en2);

Token et1 = new Token(10);
Token et2 = new Token(10);
Token et3 = new Token(10);

Token et4 = new Token(10);
Token et5 = new Token(10);
Token et6 = new Token(10);


Place p1 = new Place("lol", "kek", 250, 150, 50);
Place p2 = new Place("lol", "kek", 800, 150, 50);
Place p3 = new Place("lol", "kek", 250, 500, 50);
Place p4 = new Place("lol", "kek", 800, 500, 50);

Place ep1 = new Place("lol", "kek", 0, 0, 50);
Place ep2 = new Place("lol", "kek", 550, 0, 50);

Place ep3 = new Place("lol", "kek", 0, 0, 50);
Place ep4 = new Place("lol", "kek", 550, 0, 50);

Transition tr1 = new Transition(400, 150, 50);
Transition tr2 = new Transition(400, 500, 50);

Transition etr1 = new Transition(150, 0, 50);
Transition etr2 = new Transition(150, 0, 50);

ActionController controller = new ActionController();


{
  mainNet.addPlace(p1);
  mainNet.addPlace(p2);
  mainNet.addPlace(p3);
  mainNet.addPlace(p4);
  mainNet.addTransition(tr1);
  mainNet.addTransition(tr2);


  en1.addPlace(ep1);
  en1.addPlace(ep2);
  en1.addTransition(etr1);
  ep1.addConnectionTo(etr1);
  ep2.addConnectionFrom(etr1);

  en2.addPlace(ep3);
  en2.addPlace(ep4);
  en2.addTransition(etr2);
  ep3.addConnectionTo(etr2);
  ep4.addConnectionFrom(etr2);



  p1.addToken(t1);
  p1.addToken(t2);
  p3.addToken(t3);
  p3.addToken(t4);
  p1.addToken(rt1);
  p1.addToken(rt2);
  p1.addConnectionTo(tr1);
  p2.addConnectionFrom(tr1);
  p3.addConnectionTo(tr2);
  p4.addConnectionFrom(tr2);

  ep1.addToken(et1);
  ep1.addToken(et2);
  ep1.addToken(et3);

  ep3.addToken(et4);
  ep3.addToken(et5);
  ep3.addToken(et6);

  en1.addToken(et1);
  en1.addToken(et2);
  en1.addToken(et3);

  en2.addToken(et4);
  en2.addToken(et5);
  en2.addToken(et6);

  mainNet.addToken(t1);
  mainNet.addToken(t2);
  mainNet.addToken(t3);
  mainNet.addToken(t4);
  mainNet.addReferenceToken(rt1);
  mainNet.addReferenceToken(rt2);

  p2.addConnectionTo(tr2);
  p4.addConnectionFrom(tr2);

  controller.addAction(p1, p2, tr1, t1, 10, 30);
  controller.addAction(p1, p2, tr1, t2, 20, 40);
  controller.addAction(p3, p4, tr2, t3, 100, 120);
  controller.addAction(p3, p4, tr2, t4, 20, 40);

  controller.addAction(p2, p4, tr2, t1, 50, 70);
  controller.addAction(p2, p4, tr2, t2, 55, 75);

  controller.addAction(p1, p2, tr1, rt1, 10, 30);
  controller.addAction(p2, p4, tr2, rt1, 50, 70);

  controller.addAction(p1, p2, tr1, rt2, 30, 50);
  controller.addAction(p2, p4, tr2, rt2, 60, 80);

  controller.addAction(ep1, ep2, etr1, et1, 5, 25);
  controller.addAction(ep1, ep2, etr1, et2, 10, 30);
  controller.addAction(ep1, ep2, etr1, et3, 20, 40);
}

int currentTime = 0;

void draw() {
  clear();
  background(204);
  translate(translateX, translateY);
  scale(scale);
  mainNet.draw();
  controller.moveActions(currentTime);
  currentTime++;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e >= 1 && scale >= 0) {
    scale /= 1.05;
  } else {
    scale *= 1.05;
  }
}
void mousePressed() {
  if (mouseButton == LEFT) {
    firstX = mouseX;
    firstY = mouseY;
  }
}

void mouseDragged() {
  if (firstX >= 0) {
    translateX = translateX + (mouseX - firstX);
    translateY = translateY + (mouseY - firstY);
    firstX = mouseX;
    firstY = mouseY;
  }
}
