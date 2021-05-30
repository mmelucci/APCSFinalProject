public class Multiplier {
  int row, col;

  Multiplier(int r, int c){
   row=r;
   col=c;
  }

  float getX(){
     return width/BRICKS_PER_ROW*col;
  }

  float getY(){
        return width/BRICKS_PER_ROW*row;
  }

}
