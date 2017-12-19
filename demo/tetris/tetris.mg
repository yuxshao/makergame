namespace spr    = std::spr;
namespace snd    = std::snd;
namespace key    = std::key;
namespace window = std::window;
namespace game   = std::game;

namespace Numbers = open "draw_numbers.mg";

// TODO: make sure path is set
bool possible_pieces[7][4][3] = [
  [[false, true , false], // t
   [true , true , true ],
   [false, false, false],
   [false, false, false]],

  [[true , false, false], // periscope
   [true , true , true ],
   [false, false, false],
   [false, false, false]],

  [[true , true , false], // z
   [false, true , true ],
   [false, false, false],
   [false, false, false]],

  [[true , true , false], // box
   [true , true , false],
   [false, false, false],
   [false, false, false]],

  [[false, true , true ], // s
   [true , true , false],
   [false, false, false],
   [false, false, false]],

  [[false, false, true ], // L
   [true , true , true ],
   [false, false, false],
   [false, false, false]],

  [[false, true , false], // long
   [false, true , false],
   [false, true , false],
   [false, true , false]]];

int boardOffsetX = 96;
int boardOffsetY = 40;
int tile_size = 8;

object Block {
  int x; int y;
  int type_x; int type_y;
  int type_rect[4];
  sprite s;
  Piece piece; // need to set piece to none at some point
  event create(int x, int y, Piece p) {
    s = std::spr::load("img/pieces.png");
    this.x = x; this.y = y; piece = p;
    setType(0, 0);
  }

  void setType(int x, int y) {
    type_x = x; type_y = y;
    type_rect = [tile_size*x, tile_size*y, tile_size, tile_size];
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
    if (y <= 0) { create game_over; return; }
    board.pieces[y][x] = this;
  }

  event draw {
    float draw_x = x; float draw_y = y;
    if (piece != none) {
      if (!piece.active) {
        draw_x = x + 13.5;
        draw_y = y + 9;
      }
      // with an active piece, x and y are relative positions to the piece.
      else {
        draw_x = x + piece.x;
        draw_y = y + piece.y;
      }
    }
    draw_x *= tile_size; draw_y *= tile_size;
    draw_x += boardOffsetX;
    draw_y += boardOffsetY;
    std::spr::render_rect(s, draw_x, draw_y, type_rect);
  }
}

object Piece {
  Block blocks[4];
  Board board;
  int x; int y;
  int interval;
  int curr_timer;
  bool active;
  Piece next;
  event create(Board b, int interval) {
    board = b;
    curr_timer = this.interval = interval;
    active = false;

    int piece_type_x = std::math::irandom(3);
    int piece_type_y = std::math::irandom(10);
    int choice = std::math::irandom(7);
    int k = 0;
    for (int y = 0; y < 4; ++y)
      for (int x = 0; x < 3; ++x)
        if (possible_pieces[choice][y][x]) {
          // centres of pieces are at x = 1, y = 1
          blocks[k] = create Block(x-1, y-1, this);
          blocks[k].setType(piece_type_x, piece_type_y);
          ++k;
        }
  }

  void activate() {
    active = true;
    next = create Piece(board, 60);
    x = 5; y = 1;
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
    //board.checkRows();
    destroy this;
    foreach (game_over g) { return; } // janky: dont create if in gameover
    next.activate();
  }

  event step {
    if (!active) return;
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

int board_width = 10;
int board_height = 20;
object Board {
  Block pieces[24][10];

  event create {
    for (int y = 0; y < board_height; ++y)
      for (int x = 0; x < board_width; ++x)
        pieces[y][x] = none;
  }

  /*void checkRows() {
    for (int y = 0; y < board_height; ++y)
      checkRow(y);
  }

  void checkRow(int r) {
    // check if row full
    for (int x = 0; x < board_width; ++x)
      if (pieces[r][x] == none)
        return;

    // remove things in row
    for (int x = 0; x < board_width; ++x)
      destroy pieces[r][x];

    // move upper rows down
    for (int y = r; y > 0; --y)
      for (int x = 0; x < board_width; ++x) {
        pieces[y][x] = pieces[y-1][x];
        if (pieces[y][x] != none)
          ++pieces[y][x].y;
      }

    for (int x = 0; x < board_width; ++x)
      pieces[0][x] = none;
  }*/

  bool occupied(int x, int y) {
    if (x < 0 || x >= board_width || y >= board_height) return true;
    if (y < 0) return false;
    if (pieces[y][x] != none) return true;
    return false;
  }
}

object game_over : game::room {
  event create {
    super();
    std::window::set_clear(255, 0, 0);
    std::print::s("game over");
  }
}

object main : game::room {
  Numbers::Draw piece_counts[7];
  Numbers::Draw level_count;
  Numbers::Draw top_count;
  Numbers::Draw score_count;
  Numbers::Draw lines_count;
  event create {
    super();
    std::window::set_clear(0, 0, 0);
    std::window::set_title("Tetris");
    std::window::set_size(256, 224);
    Board b = create Board;
    (create Piece(b, 60)).activate();
    for (int i = 0; i < 7; ++i)
      piece_counts[i] = create Numbers::Draw(48, 88+16*i, 3);

    level_count = create Numbers::Draw(208, 160, 2);
    top_count = create Numbers::Draw(192, 32, 6);
    score_count = create Numbers::Draw(192, 56, 6);
    lines_count = create Numbers::Draw(152, 16, 3);
    // next piece at 196 and 112
  }

  event step {
    super();
  }

  event draw {
    std::spr::render(std::spr::load("img/board.png"), 0, 0);
  }
}
