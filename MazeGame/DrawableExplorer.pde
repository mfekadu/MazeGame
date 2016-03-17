/**
* This is the class for a DrawableExplorer, which is an Explorer object that can be drawn.
*
* @author Michael Fekadu
* @version Project 3
* @version CPE102-01
* @version Fall 2015
*/

public class DrawableExplorer extends Explorer implements Drawable
{
   public DrawableExplorer(Square location, Maze maze, String name)
   {
      super(location, maze, name);
   }

   @Override
   public void draw()
   {
      int x = Square.SQUARE_SIZE*location().col() + Square.SQUARE_SIZE/2;
      int y = Square.SQUARE_SIZE*location().row() + Square.SQUARE_SIZE/2;
      PImage cat = loadImage("http://i.imgur.com/4jp6Wri.png", "png");
      cat.resize(25,9);
      image(cat, x, y);
   }

}