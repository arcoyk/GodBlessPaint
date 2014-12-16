class Ink {
  color c = color(random(255), random(255), random(255), 100);
  // color c = color((int)random(200, 255), (int)random(200, 255), (int)random(200, 255))
  PVector p = new PVector(random(width), random(height));
  Ink() {
  }
  void run() {
    float motion = 8;
    p.x += random(-motion, motion);
    p.y += random(-motion, motion);
  }
  void show() {
    stroke(c);
    point(p.x, p.y);
  }
}

ArrayList<Ink> inks = new ArrayList<Ink>();
void setup() {
  size(500, 500);
  background(255);
}

void draw() {
  for (Ink ink : inks) {
    ink.run();
    ink.show();
  }
}

void mousePressed() {
  color c = color(random(255), random(255), random(255), 100);
  for (int i = 0; i < 100; i++) {
    Ink ink = new Ink();
    ink.p.x = mouseX;
    ink.p.y = mouseY;
    ink.c = c;
    inks.add(ink);
  }
}

void keyPressed() {
  for (int m = 0; m < 10; m++) {
    color c = color(random(255), random(255), random(255), 1);
    PVector p = new PVector(random(width), random(height));
    for (int i = 0; i < 100; i++) {
      Ink ink = new Ink();
      ink.p.x = p.x;
      ink.p.y = p.y;
      ink.c = c;
      inks.add(ink);
    }
  }
}

