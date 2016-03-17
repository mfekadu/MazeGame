/**
 * This is the class for a Monster object, which is a subclass of RandomOccupant.
 *
 * @author Michael Fekadu
 * @version Project 3
 * @version CPE102-01
 * @version Fall 2015
 */

public class Monster extends RandomOccupant
{  
   public Monster(Maze maze)
   {
      super(maze);
   }
   
   public Monster(Maze maze, long seed)
   {
      super(maze, seed);
   }
   
   public Monster(Maze maze, Square location)
   {
      super(maze, location);
   }

}
