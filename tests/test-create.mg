extern void end_game();

object helper {
  int y;
  event create { this.y = 3; }
}

object main {
  int y;
  helper h;
  event create { this.y = 4; this.h = create helper; }
  event step {
    int y;
    y = 5;
    print(y);
    print(this.y);
    print(this.h.y);
    end_game();
  }
}
