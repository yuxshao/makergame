extern void end_game();

helper {
  int y;
  create { this.y = 3; }
  destroy { print(this.y); end_game(); }
}

main {
  int y;
  helper h;
  create { this.h = create helper; }
  step {
    destroy this.h;
  }
}
