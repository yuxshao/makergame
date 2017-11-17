extern void end_game();

int i;

object main {
  event create {
    if (i < 5) {
      destroy this;
      i += 1;
      print(i);
      create main;
    }
    else end_game();
  }
}
