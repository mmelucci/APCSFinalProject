final static float BALL_RADIUS=15;

public class Ball {
  float x,y;
  float dx,dy;
  boolean active, readyToLaunch;

  Ball(float initX){
    x = initX;
    y = 790;
    active = false;
    readyToLaunch = true;
      // code to be added here
  }

  void setLaunchVector(float angle, float speed){
    dx = speed * cos(angle);
    dy = speed * sin(angle);
  }

  void move(){ 
      x += dx;
      y += dy;
      if (x >= width - BALL_RADIUS || x <= BALL_RADIUS) dx *= -1;
      if (y <= BALL_RADIUS) dy *= -1; 
      if (y >= height - BALL_RADIUS){ // reached the bottom of screen
        deActivate();
        if (!firstBallDone){// if it is the first ball to reach the bottom
            startX = x; // set the startX for next round
            firstBallDone = true; 
        }
      }
  }

  void checkCollision(ArrayList<Brick> bmap){
      // code to be added here
      for(int i=0; i<bmap.size();i++){
        Brick b = bmap.get(i);
        float brickX = b.getX();
        float brickY = b.getY();
        
        if ((brickX < x) && (x < brickX+BRICK_WIDTH)) {// ball on the vertical of the brick
           if ((abs(y-brickY)<BALL_RADIUS) || //collision on top edge OR
               (abs(brickY+BRICK_WIDTH - y) < BALL_RADIUS)){  // collision on bottom edge
             dy*= -1; //revert vertical component of velocity to bounce off
             if (b.hit()) //update brick with hit and remove from map if done
                bmap.remove(i);
           }
        }
        if ((brickY < y) && (y < brickY+BRICK_WIDTH)) {// ball on the horizontal of the brick
           if ((abs(x-brickX)<BALL_RADIUS) || //collision on left edge OR
               (abs(brickX+BRICK_WIDTH - x) < BALL_RADIUS)){  // collision on right edge
             dx*= -1; //revert horizontal component of velocity to bounce off
             if (b.hit()) //update brick with hit and remove from map if done
                bmap.remove(i);
           }
        }
        
        //if ((x+dx>brickX && x+dx<brickX+BRICK_WIDTH) &&     //ball collides with brick - TBD calculate which side teh brick is hit from and make ball bounce
        //    (y+dy>brickY && y+dy<brickY+BRICK_WIDTH) ) {
        //  if (b.hit()) {//update brick with hit and remove from map if done
        //    bmap.remove(i);
        //  }
        //}
      }
  }

  void display(){
      fill(255);
      ellipse(x,y,BALL_RADIUS,BALL_RADIUS);
  }

  boolean isActive(){
    return active;
  }
  
  boolean isReadyToLaunch(){
    return readyToLaunch;
  }
  
  void activate(){
    active = true;
    readyToLaunch = false;
  }
  
  void deActivate(){
    active = false;
  }
  
  void readyToLaunch(){ // prepare the ball for launch
    readyToLaunch = true;
    x = startX;
  }
  
  //void checkCollision(ArrayList<Multiplier> m){
  //  // code to be added here
  //}

}
