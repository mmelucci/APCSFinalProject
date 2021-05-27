public class Brick {
  float x, y;
  int row, column;
  color c;
  int strength;

  /*Constructor for brick in position row = r and column = c
    sets x and y where the brick will be displayed; sets initial strength and color*/
  Brick(int r, int c, int strength) {
    // code here
  }

  // manage hit: decrement strength; change color accordingly; return true if strength reached 0 -> brick destroyed
  boolean hit(){
   return true; // just for compiling- true means brick strength = 0
  }

  // display brick at x,y
  void display(){
    // code here
  }

  float getX(){
    // code here
    return 0;
  }

  float getY() {
    // code here
    return 0;
  }

  int getStrength(){ //might not be needed after all
    // code here
    return 1;
  }


}
