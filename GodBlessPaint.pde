String file;
PImage img;
PImage tmp;
PImage cRef;

void setup(){
  file = sketchPath+"/sample.jpg";
  img = loadImage(file);
  tmp = loadImage(file);
  cRef = loadImage(sketchPath+"/sample.jpg");
  size(img.width, img.height+cRef.height);
  background(255);
  img = binaryImage(img);
  tmp = binaryImage(img);
}

void draw(){
  proc();
  image(img, 0, 0);
  img.updatePixels();
  if((int)random(10) == 0){
    getBlow();
  }
  //image(cRef, 0, img.height);
  //delay(1);
}

void getBlow(){
  for(int i=0; i<2; i++){
    //color c = getPix(cRef, (int)random(cRef.width), (int)random(cRef.height));
    color c = color((int)random(255), (int)random(255), (int)random(255));
    setPix(img, (int)random(img.width), (int)random(img.height), c);
  }
}

color fillColor = color(255, 0, 255);
color borderColor = color (0, 0, 0);
color backColor = color(255, 255, 255);
void proc(){
  for(int x=0; x<tmp.width; x++){
    for(int y=0; y<tmp.height; y++){
      int cx = x;
      int cy = y;
      color cColor = getPix(tmp, cx, cy);
      for(int xx=-1; xx<2; xx++){
        for(int yy=-1; yy<2; yy++){
          int fx = x+xx;
          int fy = y+yy;
          if(out(fx, fy)){
            continue;
          }
          color fColor = getPix(tmp, fx, fy);
          if(random(100) < 90){
            continue;
          }
          if(fColor == borderColor || cColor == backColor || cColor == borderColor){
            continue;
          }
          fillColor = gradify(cColor);
          if(fColor == backColor){
            setPix(img, fx, fy, fillColor);
          }
        }
      }
    }
  }
  copyImg(img, tmp);
}

void copyImg(PImage org, PImage tar){
  for(int x=0; x<org.width; x++){
    for(int y=0; y<org.height; y++){
      setPix(tar, x, y, getPix(org, x, y));
    }
  }
}

color pickColor = color(255, 0, 0);
void mousePressed(){
  if(mouseY < img.height){
    setPix(tmp, mouseX, mouseY, pickColor);
  }else{
    pickColor = getPix(cRef, mouseX, mouseY-img.height);
  }
}

color getPix(PImage img, int x, int y){
  return img.pixels[img.width*y+x];
}

color setPix(PImage img, int x, int y, color c){
  img.pixels[img.width*y+x] = c;
  return c;
}

boolean out(int x, int y){
  if(x < 0 || img.width-1 < x || y < 0 || img.height-1 < y){
    return true;
  }else{
    return false;
  }
}

int bThre = 210;
PImage binaryImage(PImage img){
  for(int x=0; x<img.width; x++){
    for(int y=0; y<img.height; y++){
      color c = getPix(img, x, y);
      if((red(c)+green(c)+blue(c))/3 < bThre){
        setPix(img, x, y, color(0,0,0));
      }else{
        setPix(img, x, y, color(255, 255, 255));
      }
    }
  }
  return img;
}

color gradify(color c){
  color gc = color(red(c)+random(-thre/2, thre/2+1), green(c)+random(-thre/3, thre/3+1), blue(c)+random(-thre, thre+1));
  return gc;
}

int thre = 20;
void keyPressed(){
  if(key == 'a'){
    thre++;
  }else if(key == 'A'){
    thre--;
  }else if(key == 'b'){
    getBlow();
  }
  println(thre);
}
