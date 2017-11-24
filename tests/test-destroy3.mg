
object helper { }

object main {
  event create {
    int i;
    for (i = 0; i < 5; i = i + 1) create helper;
    /* outer loop should not iterate over things that were destroyed */
    foreach (helper x) {
      std::printstr("outer");
      foreach (helper y) {
        std::printstr("inner");
        destroy y;
      }
    }
    std::end_game();
  }
}
