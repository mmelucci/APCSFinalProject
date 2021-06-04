public class Multiplier {
  int row, col;

  Multiplier(int r, int c){
   row=r;
   col=c;
  }
void advance(){
  //moves multiplier down by one row when the ball reaches the botttom
  row++;
  }
  float getX() {
    return width/BRICKS_PER_ROW*col+BRICK_GAP+BRICK_WIDTH/2;
  }

  float getY() {
    return width/BRICKS_PER_ROW*row+BRICK_GAP+BRICK_WIDTH/2;
  }
  void display () {//Display a multiplier at the center of the square at col, row
     fill(255);
    ellipse (getX(),getY(),BRICK_WIDTH/2,BRICK_WIDTH/2);
 
    
  }

}
