

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    // make the manager
    Interactive.make( this );    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton [NUM_ROWS][NUM_COLS];
    for (int row = 0; row < NUM_ROWS; row ++)
    {
        for(int col = 0; col < NUM_COLS; col ++)
            buttons [row][col] = new MSButton (row,col);
    }
    for (int i = 0; i < 60; i++)
    {
        setBombs();
    }
}
public void setBombs()
{
    //your code
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);
    if (!bombs.contains(buttons[row][col]));
        bombs.add(buttons[row][col]);
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for (int row =0; row < NUM_ROWS; row++)
        for (int col =0; col < NUM_COLS; col++)
        {
            if (bombs.contains(buttons[row][col])&&buttons[row][col].isMarked() == false)
                return false;
            else if (bombs.contains(buttons[row][col])==false&&buttons[row][col].isMarked())
                return false;
        }
    return true;
}
public void displayLosingMessage()
{
    //your code here
    for(int i=0;i<bombs.size();i++)
        if (bombs.get(i).isClicked()==false)
        {
            bombs.get(i).mousePressed();
            buttons[9][6].setLabel("G");
            buttons[9][7].setLabel("a");
            buttons[9][8].setLabel("m");
            buttons[9][9].setLabel("e");
            buttons[9][11].setLabel("O");
            buttons[9][12].setLabel("v");
            buttons[9][13].setLabel("e");
            buttons[9][14].setLabel("r");
        }
}
public void displayWinningMessage()
{
    //your code here
    for(int i=0; i<bombs.size();i++)
    {
        if (bombs.get(i).isMarked() == true)
            {
                buttons[1][7].setLabel("W");
                buttons[1][8].setLabel("i");
                buttons[1][9].setLabel("n");
                buttons[1][10].setLabel("n");
                buttons[1][11].setLabel("e");
                buttons[1][12].setLabel("r");
            }
    }
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    public void mousePressed () 
    {
        //your code here
        clicked = true;
        if (keyPressed == true)
        {
            marked =! marked;
            if (!marked)
                clicked = false;
        }
        else if (bombs.contains(this))
                displayLosingMessage();
        else if (countBombs(r,c) > 0)
                setLabel(" " + countBombs(r,c));
        else
        {
            if(isValid(r-1,c-1))
                if(!buttons[r-1][c-1].isClicked())
                    buttons[r-1][c-1].mousePressed();
            if(isValid(r-1,c))
                if(!buttons[r-1][c].isClicked())
                    buttons[r-1][c].mousePressed();
            if(isValid(r-1,c+1))
                if(!buttons[r-1][c+1].isClicked())
                    buttons[r-1][c+1].mousePressed();
            if(isValid(r,c-1))
                if(!buttons[r][c-1].isClicked())
                    buttons[r][c-1].mousePressed();
            if(isValid(r,c+1)) 
                if(!buttons[r][c+1].isClicked())
                    buttons[r][c+1].mousePressed();
            if(isValid(r+1,c-1))
                if(!buttons[r+1][c-1].isClicked())
                    buttons[r+1][c-1].mousePressed();
            if(isValid(r+1,c))
                if(!buttons[r+1][c].isClicked())
                    buttons[r+1][c].mousePressed();
            if(isValid(r+1,c+1)) 
                if(!buttons[r+1][c+1].isClicked())
                    buttons[r+1][c+1].mousePressed();
        }
}

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if (r<NUM_ROWS && r >= 0 && c <NUM_COLS && c >= 0)
            return true;
        else
            return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if (isValid(row-1,col-1))
        {
            if (bombs.contains(buttons[row-1][col-1]))
                numBombs++;
        }
        if (isValid(row-1,col))
        {
            if (bombs.contains(buttons[row-1][col]))
                numBombs++;
        }
        if (isValid(row-1,col+1))
        {
            if (bombs.contains(buttons[row-1][col+1]))
                numBombs++;
        }
        if (isValid(row,col-1))
        {
            if (bombs.contains(buttons[row][col-1]))
                numBombs++;
        }
        if (isValid(row,col+1))
        {
            if (bombs.contains(buttons[row][col+1]))
                numBombs++;
        }
        if (isValid(row+1,col-1))
        {
            if (bombs.contains(buttons[row+1][col-1]))
                numBombs++;
        }
        if (isValid(row+1,col))
        {
            if (bombs.contains(buttons[row+1][col]))
                numBombs++;
        }
        if (isValid(row+1,col+1))
        {
            if (bombs.contains(buttons[row+1][col+1]))
                numBombs++;
        }
        return numBombs;
    }
}