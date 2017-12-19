namespace spr    = std::spr;
namespace snd    = std::snd;
namespace key    = std::key;
namespace window = std::window;
namespace game   = std::game;

namespace Numbers = open "draw_numbers.mg";
Numbers::Draw piece_counts[7];
Numbers::Draw level_count;
Numbers::Draw top_count;
Numbers::Draw score_count;
Numbers::Draw lines_count;

namespace snds {
  sound clear;
  sound drop;
  sound level;
  sound move;
  sound tetris;
  sound turn;
  sound music;

  namespace snd = std::snd;
  void load() {
    clear  = snd::load("snd/clear.ogg");
    drop   = snd::load("snd/drop.ogg");
    level  = snd::load("snd/level.ogg");
    music  = snd::load("snd/music.ogg");
    move   = snd::load("snd/move.ogg");
    tetris = snd::load("snd/tetris.ogg");
    turn   = snd::load("snd/turn.ogg");
  }
}

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

int level_speed[19] = [48, 43, 38, 33, 28, 23, 18, 13, 8, 6, 5, 5, 5, 4, 4, 4, 3, 3, 3];
int current_speed() {
  int lv = level_count.n;
  if (lv < 19) return level_speed[lv];
  else if (lv < 29) return 2;
  else return 1;
}

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
    s = spr::load("img/pieces.png");
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
    if (y <= 0) { create game_over(score_count.n); return; }
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
    spr::render_rect(s, draw_x, draw_y, type_rect);
  }
}

object Piece {
  Block blocks[4];
  Board board;
  int x; int y;
  int curr_timer;
  int horiz_timer;
  int drop_points;
  bool active;
  int piece_type;
  int hard_drop;
  Piece next;
  event create(Board b) {
    drop_points = 0;
    board = b;
    curr_timer = current_speed();
    active = false;
    hard_drop = 3;

    int piece_type_x = std::math::irandom(3);
    int piece_type_y = std::math::irandom(10);
    piece_type = std::math::irandom(7);
    int k = 0;
    for (int y = 0; y < 4; ++y)
      for (int x = 0; x < 3; ++x)
        if (possible_pieces[piece_type][y][x]) {
          // centres of pieces are at x = 1, y = 1
          blocks[k] = create Block(x-1, y-1, this);
          blocks[k].setType(piece_type_x, piece_type_y);
          ++k;
        }
  }

  void activate() {
    ++piece_counts[piece_type].n;
    active = true;
    next = create Piece(board);
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
    else snd::play(snds::turn);
  }

  void rotateRight() {
    for (int i = 0; i < 4; ++i) blocks[i].rotateRight();
    if (isColliding())
      for (int i = 0; i < 4; ++i) blocks[i].rotateLeft();
    else snd::play(snds::turn);
  }

  void moveLeft() { --x; if (isColliding()) ++x; else snd::play(snds::move); }
  void moveRight() { ++x; if (isColliding()) --x; else snd::play(snds::move); }
  void moveDown() {
    curr_timer = current_speed();
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
    snd::play(snds::drop);
    board.checkRows();
    active = false;
    destroy this;
    score_count.n += drop_points;
    foreach (game_over g) { return; } // janky: dont create if in gameover
    next.activate();
    snd::play(snds::drop);
  }

  event step {
    if (!active) return;
    if (key::is_pressed(key::Left) || (key::is_down(key::Left) && horiz_timer == 0)) {
      horiz_timer = 5;
      moveLeft();
    }
    if (key::is_pressed(key::Right) || (key::is_down(key::Right) && horiz_timer == 0)) {
      horiz_timer = 5;
      moveRight();
    }
    if (key::is_down(key::Down)) {
      if (curr_timer > 3) {
        curr_timer = 3; ++drop_points;
      }
    }
    if (key::is_pressed(key::X)) rotateLeft();
    if (key::is_pressed(key::Z)) rotateRight();
    if (key::is_pressed(key::Space) && hard_drop == 0)
      while (active) { ++drop_points; moveDown(); }
    if (--curr_timer == 0) moveDown();
    if (horiz_timer > 0) --horiz_timer;
    if (hard_drop > 0) --hard_drop;
  }
}

int board_width = 10;
int board_height = 20;
int points[5] = [0, 40, 100, 300, 1200];
object Board {
  Block pieces[24][10];

  event create {
    for (int y = 0; y < board_height; ++y)
      for (int x = 0; x < board_width; ++x)
        pieces[y][x] = none;
  }

  void checkRows() {
    int lines = 0;
    for (int y = 0; y < board_height; ++y)
      if (checkRow(y)) ++lines;
    if (lines >= 4)
      snd::play(snds::tetris);
    else if (lines >= 1)
      snd::play(snds::clear);
    score_count.n += points[lines] * (level_count.n + 1);
  }

  bool checkRow(int r) {
    // check if row full
    for (int x = 0; x < board_width; ++x)
      if (pieces[r][x] == none)
        return false;

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

    ++lines_count.n;
    if (lines_count.n / 5 > level_count.n) {
      level_count.n = lines_count.n / 5;
      snd::play(snds::level);
    }
    if (level_count.n > 99) level_count.n = 99;
    return true;
  }

  bool occupied(int x, int y) {
    if (x < 0 || x >= board_width || y >= board_height) return true;
    if (y < 0) return false;
    if (pieces[y][x] != none) return true;
    return false;
  }
}

object main : game::room {
  event create {
    super();
    snds::load();
    std::window::set_clear(0, 0, 0);
    std::window::set_title("Tetris");
    std::window::set_size(256, 224);
  }

  event step {
    if (key::is_pressed(key::Space))
      create game_room;
  }

  event draw {
    spr::render(spr::load("img/title.png"), 0, 0);
  }
}

object game_room : game::room {
  event create {
    super();
    snd::loop(snds::music);
    Board b = create Board;
    for (int i = 0; i < 7; ++i)
      piece_counts[i] = create Numbers::Draw(48, 88+16*i, 3);

    level_count = create Numbers::Draw(208, 160, 2);
    top_count = create Numbers::Draw(192, 32, 6);
    score_count = create Numbers::Draw(192, 56, 6);
    lines_count = create Numbers::Draw(152, 16, 3);

    (create Piece(b)).activate();
  }

  event step {
    top_count.n = score_count.n;
    super();
  }

  event draw {
    std::spr::render(spr::load("img/board.png"), 0, 0);
  }
}

int game_over_fade = 120;
int game_over_delay = 120;
object game_over : game::room {
  int timer;
  int n;
  event create(int score) {
    super();
    n = score;
    window::set_clear(0, 0, 0);
    snd::stop(snds::music);
  }

  event step {
    ++timer;
    if (timer == game_over_fade)
      score_count = create Numbers::Draw(104, 136, 6);
    if (timer >= game_over_fade + game_over_delay && score_count.n < n) {
      int add = n/game_over_delay/2 + 1;
      score_count.n += n/game_over_delay/2;
      if (score_count.n > n) score_count.n = n;
    }
    super();
  }

  event draw {
    if (timer >= game_over_fade)
      spr::render(std::spr::load("img/game_over.png"), 0, 0);
  }
}

