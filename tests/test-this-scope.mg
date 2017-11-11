extern void end_game();

object main {
  int x;
  int y;
  event create {
    x = 0;
    this.y = 1;
    print(this.x);
    print(y);

    int y;
    y = 2;
    print(y);
    print(this.y);

    this.y = 3;
    print(y);
    print(this.y);

    end_game();
  }
}
