/**
* This is the class for a DrawableMonster, which is a Monster object that can be drawn.
*
* @author Michael Fekadu
* @version Project 3
* @version CPE102-01
* @version Fall 2015
*/

public class DrawableMonster extends Monster implements Drawable
{
   public DrawableMonster(Maze maze)
   {
      super(maze);
   }

   public DrawableMonster(Maze maze, long seed)
   {
      super(maze, seed);
   }

   public DrawableMonster(Maze maze, Square location)
   {
      super(maze, location);
   }

   @Override
   public void draw()
   {
      if (location().inView())
      {
         int x = Square.SQUARE_SIZE*location().col() + Square.SQUARE_SIZE/2;
         int y = Square.SQUARE_SIZE*location().row() + Square.SQUARE_SIZE/2;
         PImage mon = loadImage("http://i.imgur.com/GuMZfmj.png","png");
         mon.resize(25,25);
         image(mon,x,y);
      }
   }

}