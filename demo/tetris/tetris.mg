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

int boardOffsetX = 11;
int boardOffsetY = 2;

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

  void settlePosition(Board board) {
    x = piece.x + x;
    y = piece.y + y;
    piece = none;
    if (y < 0) { create game_over; return; }
    board.pieces[y][x] = this;
  }

  event draw {
    int draw_x = x; int draw_y = y;
    // with a piece, x and y are relative positions to the piece.
    if (piece != none) {
      draw_x = x + piece.x;
      draw_y = y + piece.y;
    }
    draw_x += boardOffsetX;
    draw_y += boardOffsetY;
    draw_x *= 20; draw_y *= 20;
    std::draw_sprite(s, draw_x, draw_y);
  }
}

object Piece {
  Block blocks[4];
  Board board;
  int x; int y;
  int interval;
  int curr_timer;
  event create(Board b, int interval) {
    board = b;
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

  bool isColliding() {
    for (int i = 0; i < 4; ++i)
      if (board.occupied(blocks[i].x + x, blocks[i].y + y))
        return true;
    return false;
  }

  void rotateLeft() {
    for (int i = 0; i < 4; ++i) blocks[i].rotateLeft();
    if (isColliding())
      for (int i = 0; i < 4; ++i) blocks[i].rotateRight();
  }

  void rotateRight() {
    for (int i = 0; i < 4; ++i) blocks[i].rotateRight();
    if (isColliding())
      for (int i = 0; i < 4; ++i) blocks[i].rotateLeft();
  }

  void moveLeft() { --x; if (isColliding()) ++x; }
  void moveRight() { ++x; if (isColliding()) --x; }
  void moveDown() {
    curr_timer = interval;
    ++y;
    if (isColliding()) {
      --y;
      settlePosition();
    }
  }

  void settlePosition() {
    for (int i = 0; i < 4; ++i) {
      blocks[i].settlePosition(board);
      blocks[i].piece = none;
    }
    board.checkRows();
    create Piece(board, 60);
    destroy this;
  }

  event step {
    if (std::key::is_pressed(std::key::Left))  moveLeft();
    if (std::key::is_pressed(std::key::Right)) moveRight();
    if (std::key::is_down(std::key::Down)) {
      if (curr_timer > 3) curr_timer = 3;
    }
    if (std::key::is_pressed(std::key::Z)) rotateLeft();
    if (std::key::is_pressed(std::key::X)) rotateRight();
    if (--curr_timer == 0) moveDown();
  }
}

object Board {
  Block pieces[24][10];

  event create {
    for (int y = 0; y < 24; ++y)
      for (int x = 0; x < 10; ++x)
        pieces[y][x] = none;
  }

  void checkRows() {
    for (int y = 0; y < 24; ++y)
      checkRow(y);
  }

  void checkRow(int r) {
    // check if row full
    for (int x = 0; x < 10; ++x)
      if (pieces[r][x] == none)
        return;

    // remove things in row
    for (int x = 0; x < 10; ++x)
      destroy pieces[r][x];

    // move upper rows down
    for (int y = r; y > 0; --y)
      for (int x = 0; x < 10; ++x) {
        pieces[y][x] = pieces[y-1][x];
        if (pieces[y][x] != none)
          ++pieces[y][x].y;
      }

    for (int x = 0; x < 10; ++x)
      pieces[0][x] = none;
  }

  bool occupied(int x, int y) {
    if (x < 0 || x >= 10 || y >= 24) return true;
    if (y < 0) return false;
    if (pieces[y][x] != none) return true;
    return false;
  }
}

object game_over : std::room {
  event create {
    super();
    std::set_window_clear(255, 0, 0);
    std::printstr("game over");
  }
}

object main : std::room {
  event create {
    super();
    std::set_window_title("Tetris");
    Board b = create Board;
    create Piece(b, 60);
  }

  event step {
    super();
    std::set_window_size(640, 480);
  }
}
