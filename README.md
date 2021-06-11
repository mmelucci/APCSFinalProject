# APCSFinalProject
1. Ballers
2. Matt Melucci and Philip Von Mueffling
3. A fast-paced physics-based game where the player shoots a blast of small balls against a construction of bricks of different strengths. Bricks may require 1-100s of hits to get destroyed, with one shot per level. At every round, the bricks lower down one block, a new row is added at the top with strength >= level, and you lose if they reach the bottom. Some balls’ multipliers are placed so that when you hit them you increase the number of  balls for the next round.
4. Link to Prototype: https://docs.google.com/document/d/1h-q0VrV6gP10E9peiE5OlBkTiR4WUhYHEUUotGIDdRo/edit?usp=sharing
Link to Updated UML Diagram: https://lucid.app/lucidchart/invitations/accept/inv_ddc8aaac-f8ee-4704-97c9-69f189b17dd9 (JPG available in prototype linked above)
Link to In-class Demo Presentation: https://docs.google.com/presentation/d/1hopDZ69Swyy_nmSQdNZPSsiXaiQ41YEByGKbUI9YN-4/edit?usp=sharing
5. Compile/Run Instructions: Load the Ballz folder and run from Processing
5. Development Log:
5/26
Matt created the classes, instance variables, and method headers, along with comments on each method and the specifics of their function. Also, structured the main game view with the number of bricks and displayed a map filled with bricks as a basic template. Philip created and finished brick class working with the outline, using final variables so that we do not have to tediously change all of the values if we decided to change our max strength etc.
                              //
5/27
We primarily discussed our next steps in the breakout room and solidified the division of work, reviewing the skeleton of the project. Since Matt worked more on the prototype, Philip took one more class to code to balance the work. Matt will work on the Ball class and Round class, while Philip will complete the Brick, Multiplier, and Ball class. Then, we will both put together the main Ballz game loop to test for the demo. After dividing up the work, we continued to discuss the function of each method prior to starting the code for the other classes.
                              //
5/30/21
Philip added  methods in the Brick class and worked on the Multiplier class as well. Matt placed all the classes into a folder so that it was compatible for Processing. Philip created the ability for the bricks to display and then Matt worked on the Ball class, collision function, move() method, the constructor, and other methods within the Ballz folder. Balls in the display now bounce on walls and destroy bricks. Matt also structured the game views and created the Game Over screen.
                              //
5/31/21
Matt fixed the color intensity of the bricks so that the lighter green bricks are, the lower strength they have. Matt also implemented the launch of several balls. Matt then implemented the ball-brick collision such that the balls bounce off of bricks and walls.
                              //
6/1/21
Matt included a deActivate() method so that balls stop bouncing when they reach the bottom of the screen. He also modified move() and the active screen to display balls when inactive. Philip added text to display the strength of each brick on the bricks. Matt updated the development log on the Readme up to 5/31, and later added a basic automatic round loop so that the game progresses through rounds.
                              //
6/3/21
Matt implemented a basic aim and shooting mechanism for the user to see where the balls will be launched. He then fixed the starting position for the balls for subsequent rounds so that all balls start launching from the position at which the first ball lands. Matt renamed the game views as constants for better readability and set all balls to startX for launch, along with fixing a bug with mousepressed. The bug involved the balls switching direction when the user pressed down on the mouse. Matt then fixed the stroke on bricks and balls and formed the random row creation at every round so that bricks are at random positions in the rows. He also fixed the display of brick strength so that the strength display appeared in the middle of the bricks and displayed the balls at launch point. Philip updated the colors so they are more similar to the actual game and added a display of multipliers along with the multiplier functionality.
                              //
6/4/21
Matt completely updated the development log and made the game start with one ball. He also cleaned up old testing code for the demo branch that he created.
