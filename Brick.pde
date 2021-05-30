public class Brick {
  int row, col;
  color c;
  int strength;
  final static int BRICKS_PER_ROW=5;
  final color FULL_HEALTH_COLOR=color(255, 0, 0);
  final color NO_HEALTH_COLOR=color(0, 255, 0);
  final static int MAX_HEALTH=15;
  /*Constructor for brick in position row = r and column = c
   sets x and y where the brick will be displayed; sets initial strength and color*/
  Brick(int r, int c, int strength) {
    this.row=r;
    this.col=c;
    this.strength=strength;
    updateColor();
    // code here
  }

  // manage hit: decrement strength; change color accordingly; return true if strength reached 0 -> brick destroyed
  boolean hit() {
    strength=strength-1; //true means brick strength = 0
    updateColor();
    return strength==0;
  }

  void updateColor() {
    float colormultiplier=strength/MAX_HEALTH;
    float r=colormultiplier*red(FULL_HEALTH_COLOR)+(1-colormultiplier)*red(NO_HEALTH_COLOR);
    float g=colormultiplier*green(FULL_HEALTH_COLOR)+(1-colormultiplier)*green(NO_HEALTH_COLOR);
    float b=colormultiplier*blue(FULL_HEALTH_COLOR)+(1-colormultiplier)*blue(NO_HEALTH_COLOR);
    this.c=color(r,g,b);
  }
  // display brick at x,y
  void display() {
    fill(c);
    rect (getX(),getY(),width/BRICKS_PER_ROW,width/BRICKS_PER_ROW);
  }

  float getX() {
    return width/BRICKS_PER_ROW*col;
  }

  float getY() {
    return width/BRICKS_PER_ROW*row;
  }

  int getStrength() { //might not be needed after all
    // code here
    return strength;
  }
}
