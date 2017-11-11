extern void end_game();

object main {
  int x;
  event create { this.x = 3; }
  event step {
    int x;
    x = 5;
    print(this.x);
    print(x);
    end_game();
  }
}
