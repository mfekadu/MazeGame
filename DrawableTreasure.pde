/**
* This is the class for a DrawableTreasure, which is a Treasure object that can be drawn.
*
* @author Michael Fekadu
* @version Project 3
* @version CPE102-01
* @version Fall 2015
*/

public class DrawableTreasure extends Treasure implements Drawable
{
   public DrawableTreasure(Maze maze)
   {
      super(maze);
   }

   public DrawableTreasure(Maze maze, long seed)
   {
      super(maze, seed);
   }

   public DrawableTreasure(Maze maze, Square location)
   {
      super(maze, location);
   }

   @Override
   public void draw()
   {
      if (location().seen())
      {
         int x = Square.SQUARE_SIZE*location().col() + Square.SQUARE_SIZE/2;
         int y = Square.SQUARE_SIZE*location().row() + Square.SQUARE_SIZE/2;
         PImage coin = loadImage("http://i.imgur.com/MPvZNCP.png","png");
         coin.resize(20,20);
         image(coin,x,y);
       }
   }

}