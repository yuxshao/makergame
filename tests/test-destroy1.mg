extern void end_game();

object helper {
  int y;
  event create { this.y = 3; }
  event destroy { print(this.y); end_game(); }
}

object main {
  int y;
  helper h;
  event create { this.h = create helper; }
  event step {
    destroy this.h;
  }
}
