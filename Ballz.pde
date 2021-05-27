ArrayList<Brick> bricks; // all bricks
ArrayList<Multiplier> mults; // all multipliers
ArrayList<Ball> balls; // all balls
int startX; // position of launch
int currentLevel; //current level
int gameView = 0;
// 0: Launch Screen
// 1: Game Screen
// 2: Gameover Screen (LATER)

void setup() {
  size(570, 810);
}

void draw() {
  background(0);
  // Display the contents of the current screen
  if (gameView == 0) {
    launchScreen();
  } else if (gameView == 1) {
    activeScreen();
  }
  //else if (gameScreen == 2) {
  //  gameOverScreen();
  //}

}

void mousePressed(){}

void aim() {}

void launchScreen(){

  /* THIS IS JUST FOR US TO SEE THE WHOLE BRICKS MAP - TEMPORARY
    we will build the array of bricks and call Bricks.display() for each of the bricks in the arraylist to build map
  */
   for (int r = 1; r< 9; r++){
    for (int c=0; c<7; c++){
     fill(50);
     rect(10+c*80,10+r*80,70,70); // Use this formula in Brick class to calculate x,y from column and row of brick
    }
   }
}

void activeScreen(){
/* Here we are gonna have to implement all the bouncing, hitting and multiplying action.
When all the balls get to the bottom of the screen the round ends by setting gameView = 0 that
triggers launchScreen()
*/

// code to be added here

}
