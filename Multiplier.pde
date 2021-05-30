public class Multiplier {
  int row, col;

  Multiplier(int r, int c){
   row=r;
   col=c;
  }
void advance(){
  //moves bricks down by one row when the ball reaches the botttom
  row++;
  }
  float getX(){
     return width/Ballz.BRICKS_PER_ROW*col;
  }

  float getY(){
     return width/Ballz.BRICKS_PER_ROW*row;
  }

}
