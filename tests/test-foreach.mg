extern void end_game();

int y;
object helper {
  int y;

  event create { y = y + 2; this.y = y; }
}

object main {
  int y;
  event create {
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
