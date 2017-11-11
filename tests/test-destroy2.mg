extern void end_game();

object helper {
  event create { destroy this; }
}

object main {
  event create {
    create helper;
    int i;
    i = 0; /* count # helpers */
    foreach (helper h) { i = i + 1; }
    print(i);
    end_game();
  }
}
