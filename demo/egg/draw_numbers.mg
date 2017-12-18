// makeshift number drawing
using std::spr;

object Draw {
  sprite spr[10];
  float x; float y;
  int n;
  int width;

  event create(int number, float x, float y) {
    this.x = x; this.y = y;
    n = number;
    spr = [load("numbers/0.png"), load("numbers/1.png"),
           load("numbers/2.png"), load("numbers/3.png"),
           load("numbers/4.png"), load("numbers/5.png"),
           load("numbers/6.png"), load("numbers/7.png"),
           load("numbers/8.png"), load("numbers/9.png")];
  }

  int draw_indiv(int n, float X) {
    if (n > 9) X = draw_indiv(n/10, X);
    render(spr[n%10], X, y);
    return (X + width(spr[n%10]));
  }

  event draw {
    int n = this.n;
    if (n < 0) n = 0;
    draw_indiv(n, x);
  }
}
