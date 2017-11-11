extern void end_game();

object main {
  event create {
    foreach (asdf x) { print(3); } /* error: obj nonexistent */
  }
}
