extern void end_game();

helper {
  int y;
  create { this.y = 3; }
}

main {
  int y;
  helper h;
  create { this.y = 4; this.h = create helper; }
  step {
    int y;
    y = 5;
    print(y);
    print(this.y);
    print(this.h.y);
    end_game();
  }
}
