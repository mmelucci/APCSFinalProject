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
      if (y >= height - BALL_RADIUS || y <= BALL_RADIUS) dy *= -1; //TBD when ball reaches bottom it stops there and becomes inactive
  }

  void checkCollision(ArrayList<Brick> bmap){
      // code to be added here
      for(int i=0; i<bmap.size();i++){
        Brick b = bmap.get(i);
        float brickX = b.getX();
        float brickY = b.getY();
        
        if ((x+dx>brickX && x+dx<brickX+BRICK_WIDTH) &&     //ball collides with brick - TBD calculate which side teh brick is hit from and make ball bounce
            (y+dy>brickY && y+dy<brickY+BRICK_WIDTH) ) {
          if (b.hit()) //update brick with hit and remove from map if done
            bmap.remove(i);
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
  
  //void checkCollision(ArrayList<Multiplier> m){
  //  // code to be added here
  //}

}
