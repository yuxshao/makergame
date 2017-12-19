// makeshift number drawing
using std::spr;

object Draw {
  sprite spr;
  int x; int y; int width; int height;
  int n; int digits;

  event create(int x, int y, int digits) {
    this.x = x; this.y = y; this.digits = digits;
    spr = load("img/numbers.png");
  }

  event draw {
    int div = 1;
    for (int i = 0; i < digits-1; ++i) div *= 10;
    int x = x;
    int n = this.n;
    while (div > 0) {
      int d = (n / div) % 10;
      render_rect(spr, x, y, [8 * d, 0, 8, 8]);
      x += 8;
      div /= 10;
    }
  }
}
