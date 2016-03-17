/**
* This is the class for a Treasure object, which is a subclass of RandomOccupant.
*
* @author Michael Fekadu
* @version Project 3
* @version CPE102-01
* @version Fall 2015
*/

public class Treasure extends RandomOccupant
{
   private boolean found;
   
   public Treasure(Maze maze)
   {
      super(maze);
      this.found = false;
      location().setTreasure(this);
   }
   
   public Treasure(Maze maze, long seed)
   {
      super(maze, seed);
      this.found = false;
      location().setTreasure(this);
   }
   
   public Treasure(Maze maze, Square location)
   {
      super(maze, location);
      found = false;
      location.setTreasure(this);
   }
   
   public boolean found() {return found;}
   
   public void setFound() {this.found = true;}

   @Override
   public void move() {}

}