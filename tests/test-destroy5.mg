extern void end_game();

object helper { }

object main {
  int j;
  event create {
    this.j = 0;
    int i;
    for (i = 0; i < 5; i = i + 1) create helper;
    /* outer loop should not iterate over things that were destroyed */
    foreach (helper x) {
      printstr("outer");
      foreach (helper y) {
        printstr("inner");
        destroy x; // 1st helper destroyed 5 extra times; should not break
        destroy y;
      }
    }
  }
  event step {
    if (this.j > 100) end_game();
    this.j = this.j + 1;
  }
}
