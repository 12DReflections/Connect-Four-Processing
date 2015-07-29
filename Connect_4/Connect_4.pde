int w = 7, h = 6, bs = 100, player = 1; //block size 100 pixels
int[][] board = new int[h][w];

void setup(){
   size(600,700); //normally size(w*bs, h*bs);
  ellipseMode(CORNER); 
  
}

//Return piece location, and 0 is off the board
int p(int y, int x) {
            //if off the board return 0, else return board location 
   return( y<0 || x<0 || y>=h ||x>=w) ? 0 : board[y][x]; 
}

//Get Winner
int getWinner(){ //rows, colums, diagonals
  //test 4 in a row horizontal, then that player is winnter
  for( int y=0; y<h; y++) for( int x=0; x<w; x++)
     if( p(y,x) != 0  &&  p(y,x) == p(y, x+1)  && p(y,x) == p(y,x+2)  && p(y,x) ==p(y,x+3)) {
       return p(x,y); 
  }
  //test vertical 4 in a row, then player is winner
  for( int y=0; y<h; y++) for( int x=0; x<w; x++)
     if( p(y,x) != 0  &&  p(y,x) == p(y+1, x)  && p(y,x) == p(y+2,x)  && p(y,x) ==p(y+3,x)) {
       return p(x,y); 
  }
  //test diagonal, d = direction
  for( int y=0; y<h; y++) for( int x=0; x<w; x++) for( int d=-1; d <=1; d+=2)
     if( p(y,x) != 0  &&  p(y,x) == p(y+1*d, x+1)  &&  p(y,x) == p(y+2*d, x+2) ){
       return p(x,y); 
  }
  //possibility to still go, if still possible turns return 0
  for( int y=0; y<h; y++) for( int x=0; x<w; x++)
     if(p(y,x) == 0) {
       return 0;
     }
  
   return -1; //tie
   
 }


//Check for where to drop peice
int nextSpace(int x) {
  //start at bottom, if bottom square is available, use it (y variable)
    for(int y = h-1; y> 0; y--){
     if(board[y][x] == 0) 
        return y; 
    }
    return -1;
}

void mousePressed(){
  int x = mouseX / bs, y = nextSpace(x); //xpos is relative to click, y is height available
  
   //if position is available, put a piece in that slow
  if( y>= 0){
   board[y][x] = player;
   
   //if player is one, switch 2, else switch back to one
   player = player==1 ? 2:1;
  }
  
}

void draw() {
  
  if( getWinner() == 0){
    //Game Board - series of squares 100x100 for board
    for( int j=0; j<h; j++) for( int i=0; i<w; i++) {
        fill(255);
        rect(i*bs, j*bs, bs, bs); 
        
        if( board[j][i] > 0) {
         //          1 then red, else 0       2 then green,        
         fill(board[j][i] == 1 ? 255:0,  board[j][i] == 2 ? 255:0, 0);
         ellipse(i*bs, j*bs, bs, bs);
         } 
    }
  } else {
     background(0); 
     fill(255); 
     text("The winner is: " + getWinner() + ". Space Restarts", width/2, height/2);
     if( keyPressed && key == ' ') {
       player = 1;  
       for( int y=0; y<h; y++) for( int x=0; x<w; x++){
          board[y][x] = 0; 
       }

     }
  }
  
}
