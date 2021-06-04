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
     return width/Ballz.BRICKS_PER_ROW*col; //@PVM: change it to be the center of the square since the multiplier is a small circular object
  }

  float getY(){
     return width/Ballz.BRICKS_PER_ROW*row; //@PVM: change it to be the center of the square since the multiplier is a small circular object
  }
  
  void display () {//Display a multiplier at the center of the square at col, row
     fill(255);
    ellipse (getX(),getY(),BRICK_WIDTH/2,BRICK_WIDTH/2);
 
    
  }

}
