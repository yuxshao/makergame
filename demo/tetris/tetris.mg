// TODO: make sure path is set
bool possible_pieces[7][4][3] = [
  [[false, true , false], // long
   [false, true , false],
   [false, true , false],
   [false, true , false]],

  [[true , true , false], // box
   [true , true , false],
   [false, false, false],
   [false, false, false]],

  [[false, false, true ], // L
   [true , true , true ],
   [false, false, false],
   [false, false, false]],

  [[true , false, false], // periscope
   [true , true , true ],
   [false, false, false],
   [false, false, false]],

  [[false, true , true ], // s
   [true , true , false],
   [false, false, false],
   [false, false, false]],

  [[true , true , false], // z
   [false, true , true ],
   [false, false, false],
   [false, false, false]],

  [[false, true , false], // t
   [true , true , true ],
   [false, false, false],
   [false, false, false]]];

object Block {
  int x; int y;
  sprite s;
  Piece piece; // need to set piece to none at some point
  event create(int x, int y, Piece p) {
    s = std::load_image("block.png");
    this.x = x; this.y = y; piece = p;
  }

  void rotateLeft() {
    int newX = -y; int newY = x;
    y = newY; x = newX;
  }

  void rotateRight() {
    rotateLeft(); rotateLeft(); rotateLeft();
  }

  event draw {
    int draw_x = 20 * (x + piece.x);
    int draw_y = 20 * (y + piece.y);
    std::draw_sprite(s, draw_x, draw_y);
  }
}


object Piece {
  Block blocks[4];
  int x; int y;
  int interval;
  int curr_timer;
  event create(int interval) {
    curr_timer = this.interval = interval;
    x = 5; y = 0;

    int choice = std::irandom(7);
    int k = 0;
    for (int y = 0; y < 4; ++y)
      for (int x = 0; x < 3; ++x)
        if (possible_pieces[choice][y][x]) {
          // centres of pieces are at x = 1, y = 1
          blocks[k] = create Block(x-1, y-1, this);
          ++k;
        }
  }

  void rotateLeft() {
    for (int i = 0; i < 4; ++i) blocks[i].rotateLeft();
  }

  void rotateRight() {
    for (int i = 0; i < 4; ++i) blocks[i].rotateRight();
  }

  event step {
    if (std::key::is_pressed(std::key::Left)) --x;
    if (std::key::is_pressed(std::key::Right)) ++x;
    if (std::key::is_pressed(std::key::Z)) rotateLeft();
    if (std::key::is_pressed(std::key::X)) rotateRight();
    if (--curr_timer == 0) {
      curr_timer = interval;
      ++y;
    }
  }
}

/*object TetrisController {
  bool board[24][10];
  Block pieces[24][10];
  NextPiece next;
  CurrentPiece current;

  event create {
    for (int i = 0; i < 24; ++i)
      for (int j = 0; j < 10; ++j)
        board[i][j] = false;

  }

  void real_step() {
    
  }
}*/

object main : std::room {
  event create {
    super();
    create Piece(60);
  }
}
