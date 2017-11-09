extern void end_game();

int y;
helper {
  int y;

  create { y = y + 2; this.y = y; }
}

main {
  int y;
  create {
    this.y = 3; /* this is not printed since it's not a helper */

    int x;
    for (x = 0; x < 5; x = x + 1)
      create helper;

    foreach (helper h) {
      print(h.y);
    }

    end_game();
  }
}
