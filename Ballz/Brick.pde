public class Brick {
  int row, col;
  color c;
  int strength;
  final color FULL_HEALTH_COLOR=color(172, 5, 121);
  final color NO_HEALTH_COLOR=color(184,185 ,55 );
  final static int MAX_HEALTH=40;
  
  /*Constructor for brick in position row = r and column = c
   sets x and y where the brick will be displayed; sets initial strength and color*/
  Brick(int r, int c, int strength) {
    this.row=r;
    this.col=c;
    this.strength=strength;
    updateColor();
    // code here
  }
  boolean advance(){
  //moves bricks down by one row when the ball reaches the botttom
  row++;
  return row>=NUM_ROWS;
  
  
  }
  // manage hit: decrement strength; change color accordingly; return true if strength reached 0 -> brick destroyed
  boolean hit() {
    strength=strength-1; //true means brick strength = 0
    updateColor();
    return strength==0;
  }

  void updateColor() {
    float colormultiplier=1.0*strength/MAX_HEALTH;
    float r=colormultiplier*red(FULL_HEALTH_COLOR)+(1-colormultiplier)*red(NO_HEALTH_COLOR);
    float g=colormultiplier*green(FULL_HEALTH_COLOR)+(1-colormultiplier)*green(NO_HEALTH_COLOR);
    float b=colormultiplier*blue(FULL_HEALTH_COLOR)+(1-colormultiplier)*blue(NO_HEALTH_COLOR);
    this.c=color(r,g,b);
  }
  // display brick at x,y
  void display() {
    fill(c);
    rect (getX(),getY(),BRICK_WIDTH,BRICK_WIDTH);
    textSize(24);
    fill(0);
    text(strength, getX()+BRICK_WIDTH/3, getY() + BRICK_WIDTH/8*5);
    
  }

  float getX() {
    return width/BRICKS_PER_ROW*col+BRICK_GAP;
  }

  float getY() {
    return width/BRICKS_PER_ROW*row+BRICK_GAP;
  }

  int getStrength() { //might not be needed after all
    // code here
    return strength;
  }
}
