final static float BALL_RADIUS=15;

public class Ball {
  float x,y;
  float dx,dy;
  boolean active, readyToLaunch;

  Ball(float initX, float initY){
    x = initX;
    y = initY;
    active = false;
    readyToLaunch = true;
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

  void checkCollision(ArrayList<Brick> bmap, ArrayList<Multiplier> mmap, ArrayList<Ball> balls){
      // code to be added here
      for(int i=0; i<bmap.size();i++){
        Brick b = bmap.get(i);
        float brickX = b.getX();
        float brickY = b.getY();
        
        if ((brickX < x) && (x < brickX+BRICK_WIDTH)) {// ball on the vertical of the brick
           if (abs(y-brickY)<BALL_RADIUS) { //collision on top edge 
               y-= BALL_RADIUS; // to bounce off and avoid continuous hit when running parallel to edge
               dy*= -1; //revert vertical component of velocity to bounce off
               if (b.hit()) //update brick with hit and remove from map if done
                  bmap.remove(i--);
           }
           else if (abs(brickY+BRICK_WIDTH - y) < BALL_RADIUS){  // collision on bottom edge
               y+= BALL_RADIUS; // to bounce off and avoid continuous hit when running parallel to edge
               dy*= -1; //revert vertical component of velocity to bounce off
               if (b.hit()) //update brick with hit and remove from map if done
                  bmap.remove(i--);
           }
        }
        if ((brickY < y) && (y < brickY+BRICK_WIDTH)) {// ball on the horizontal of the brick
           if (abs(x-brickX)<BALL_RADIUS) {//collision on left edge 
             x-= BALL_RADIUS;// to bounce off and avoid continuous hit when running parallel to edge
             dx*= -1; //revert horizontal component of velocity to bounce off
             if (b.hit()) //update brick with hit and remove from map if done
                bmap.remove(i--);
           }
           else if (abs(brickX+BRICK_WIDTH - x) < BALL_RADIUS){  // collision on right edge
             x+= BALL_RADIUS;// to bounce off and avoid continuous hit when running parallel to edge
             dx*= -1; //revert horizontal component of velocity to bounce off
             if (b.hit()) //update brick with hit and remove from map if done
                bmap.remove(i--);
           }
        }
      }
      for(int i=0; i<mmap.size();i++){
        Multiplier m = mmap.get(i);
        float MultiplierX = m.getX();
        float MultiplierY = m.getY();
        
        if (dist (x,y,MultiplierX,MultiplierY)<BALL_RADIUS+BRICK_WIDTH/4) {// ball on the vertical of the brick
                //Ball newball= new Ball(width/2, height - BALL_RADIUS);
                Ball newball= new Ball(MultiplierX,MultiplierY);
                newball.setLaunchVector(HALF_PI,20); // drop down fast
                newball.activate();
                balls.add(newball);
                mmap.remove(i--);
           }
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
    y = height - BALL_RADIUS;
  }


}
