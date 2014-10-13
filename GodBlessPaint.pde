PImage img, tmp, color_ref_img;
boolean stopped = true;
color ink_color = color(0, 200, 100);
color border_color = color (0);
color canvas_color = color(255);
int binary_thre = 200;
int gradient_power = 10;

void setup(){
  String file_name = "sample.png";
  img = loadImage(file_name);
  tmp = loadImage(file_name);
  color_ref_img = loadImage("color_ref_sample.png");
  size(img.width, img.height);
  background(255);
  binarize_image(img);
  binarize_image(tmp);
}

boolean flag = true;
void draw(){
  if(flag){
    delay(1000);
  }
  if(stopped){
    plot_ink(ink_color);
  }
  proc();
  println(stopped);
  image(img, 0, 0);
  img.updatePixels();
}

void proc(){
  stopped = true;
  for(int x = 0; x < tmp.width; x++){
    for(int y = 0; y < tmp.height; y++){
      int center_x = x;
      int center_y = y;
      color center_color = tmp.get(center_x, center_y);
      if(center_color == canvas_color ||
         center_color == border_color
        ){
        continue;
      }
      for(int xx = -1; xx < 2; xx++){
        for(int yy = -1; yy < 2; yy++){
          int focus_x = x + xx;
          int focus_y = y + yy;
          if(out(focus_x, focus_y)){
            continue;
          }
          color focus_color = tmp.get(focus_x, focus_y);
          if(focus_color != canvas_color){
            continue;
          }
          if(random(100) < 90){
            continue;
          }
          color fill_color = gradify(center_color);
          img.set(focus_x, focus_y, fill_color);
          stopped = false;
        }
      }
    }
  }
  tmp = img.get(0, 0, img.width, img.height);
}

boolean out(int x, int y){
  if(x < 0 || img.width - 1 < x || y < 0 || img.height - 1 < y){
    return true;
  }else{
    return false;
  }
}

void binarize_image(PImage img){
  for(int x = 0; x < img.width; x++){
    for(int y = 0; y < img.height; y++){
      color c = img.get(x, y);
      if((red(c) + green(c) + blue(c)) / 3 < binary_thre){
        img.set(x, y, color(0));
      }else{
        img.set(x, y, color(255));
      }
    }
  }
}

color gradify(color c){
  //tune here yourself
  return color(
  red(c) + random(-gradient_power / 2, gradient_power / 2 + 1),
  green(c)+random(-gradient_power / 3, gradient_power / 3 + 1),
  blue(c)+random(-gradient_power, gradient_power + 1));
}

void plot_ink(color ink_color){
  for(int x = 0; x < tmp.width; x++){
    for(int y = 0; y < tmp.height; y++){
      color focus_color = tmp.get(x, y);
      if(focus_color == canvas_color){
        img.set(x, y, ink_color);
        println(x, y);
        return;
      }
    }
  }
}

void mousePressed(){
  tmp.set(mouseX, mouseY, color(255, 0, 0));
}

void keyPressed(){
  if(key == 'a'){
    gradient_power++;
  }else if(key == 'A'){
    gradient_power--;
  }else if(key == 'b'){
    flag = false;
  }
  println(gradient_power);
}
