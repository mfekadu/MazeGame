/**
 * This is the class for a RandomOccupant object, which is a subclass of Occupant.
 *
 * @author Michael Fekadu
 * @version Project 3
 * @version CPE102-01
 * @version Fall 2015
 * <br>Revisions:
 *    <br>1.0.2 changed RandomOccupant(Maze maze) to move randomly.
 *    <br>1.0.1 Fixed move() to actually move in the correct direction relative to the random direction given. Also fixed some errors & cleaned up the code.
 *    <br>1.0.0 Initial version.
 */

import java.util.Random;

public abstract class RandomOccupant extends Occupant
{
   private Random random;
   
   private Maze maze;
   
   public RandomOccupant(Maze maze)
   {
      this.maze = maze;
      this.random = new Random();
      moveTo(maze.getSquare(random.nextInt(maze.rows()), random.nextInt(maze.rows())));
   }
   
   public RandomOccupant(Maze maze, long seed)
   {
      this.maze = maze;
      this.random = new Random(seed);
      moveTo(maze.getSquare(random.nextInt(maze.rows()), random.nextInt(maze.cols())));
   }
   
   public RandomOccupant (Maze maze, Square location)
   {
      this.maze = maze;
      this.random = new Random();
      moveTo(location);
   }
   
   public void move()
   {
      int row = location().row();
      int col = location().col();

      while(true)
      {
         int randInt = random.nextInt(4);

         if(super.location().wall(randInt) == false)
         {
            if (randInt == Square.UP)
            {
               moveTo(maze.getSquare(row - 1, col));
               break;
            }

            else if (randInt == Square.RIGHT)
            {
               moveTo(maze.getSquare(row, col + 1));
               break;
            }

            else if (randInt == Square.DOWN)
            {
               moveTo(maze.getSquare(row + 1, col));
               break;
            }

            else if (randInt == Square.LEFT)
            {
               moveTo(maze.getSquare(row, col - 1));
               break;
            }
         }
      }
   }
}