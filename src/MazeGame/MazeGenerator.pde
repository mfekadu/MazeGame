import java.util.*;
/**
 * Class MazeGenerator - builds the Maze cells and walls.
 */
public class MazeGenerator
{
    private int ROWS;
    private int COLS;                                 // dimensions of maze
    private int[][] maze;                                       // the maze of cells
    private int[][] Stack;                                      // cell stack to hold a list of cell locations
    public static final int N = 1;                          // direction constants
    public static final int E = 2;
    public static final int S = 4;
    public static final int W = 8;  
    
    private void init_cells()
    {
        int i, j;

        // create a maze of cells
        maze = new int[ROWS][COLS];

        // set all walls of each cell in maze by setting bits :  N E S W
        for (i = 0; i < ROWS; i++)
            for (j = 0; j < COLS; j++)
                maze[i][j] = (N + E + S + W);

        // create stack for storing previously visited locations
        Stack = new int[ROWS*COLS][2];

        // initialize stack
        for (i = 0; i < ROWS*COLS; i++)
            for (j = 0; j < 2; j++)
                Stack[i][j] = 0;
    }

    // use depth first search to create a maze
    public int[][] generate_maze(int rows, int cols)
    {
        int i, j, r, c;
        int[] curr = new int[2];
        Random rand = new Random();
        
        ROWS = rows;
        COLS = cols;
        
        init_cells();
    
        // arrays of single step movements between cells
        //          north    east     south    west    
        int[][] move = {{-1, 0}, { 0, 1}, { 1, 0}, { 0,-1}};
        int[][] next = {{0, 0}, { 0, 0}, { 0, 0}, { 0,0}};

        // choose a cell at random and make it the current cell
        r = rand.nextInt(ROWS);
        c = rand.nextInt(COLS);
    
        // current search location
        curr[0] = r;  
        curr[1] = c;
        int visited  = 1;
        int total = ROWS*COLS;
        int tos   = 0;                              // index for top of cell stack 
   
        while (visited < total)
        {
            //  find all neighbors of current cell with all walls intact
            j = 0;
            for (i = 0; i < 4; i++)
            {
                r = curr[0] + move[i][0];
                c = curr[1] + move[i][1];

                //  check for valid next cell
                if ((0 <= r) && (r < ROWS) && (0 <= c) && (c < COLS))
                {
                    // check if previously visited
                    if (((maze[r][c] & N) == N) && ((maze[r][c] & E)==E) && ((maze[r][c] & S)==S) && ((maze[r][c] & W)==W))
                    {
                        // not visited, so add to possible next cells
                        next[j][0] = r;
                        next[j][1] = c;
                        j++;
                    }
                }
            }
        
            if (j > 0)
            {
                // current cell has one or more unvisited neighbors, so choose one at random  
                // and knock down the wall between it and the current cell
                i = rand.nextInt(j);

                if ((next[i][0] - curr[0]) == 0)    // next on same row
                {
                    r = next[i][0];
                    if (next[i][1] > curr[1])       // move east
                    {
                        c = curr[1];
                        maze[r][c] &= ~E;           // clear E wall
                        c = next[i][1];
                        maze[r][c] &= ~W;           // clear W wall
                    }
                    else                            // move west
                    {
                        c = curr[1];
                        maze[r][c] &= ~W;           // clear W wall
                        c = next[i][1];
                        maze[r][c] &= ~E;           // clear E wall
                    }
                }
                else                                // next on same column
                {
                    c = next[i][1];
                    if (next[i][0] > curr[0])       // move south    
                    {
                        r = curr[0];
                        maze[r][c] &= ~S;           // clear S wall
                        r = next[i][0];
                        maze[r][c] &= ~N;           // clear N wall
                    }
                    else                            // move north
                    {
                        r = curr[0];
                        maze[r][c] &= ~N;           // clear N wall
                        r = next[i][0];
                        maze[r][c] &= ~S;           // clear S wall
                    }
                }

                tos++;                              // push current cell location
                Stack[tos][0] = curr[0];
                Stack[tos][1] = curr[1];

                curr[0] = next[i][0];               // make next cell the current cell
                curr[1] = next[i][1];

                visited++;                          // increment count of visited cells
            }
            else
            {
                // reached dead end, backtrack
                // pop the most recent cell from the cell stack            
                // and make it the current cell
                curr[0] = Stack[tos][0];
                curr[1] = Stack[tos][1];
                tos--;
            }
        }
        return maze;
    }
}
