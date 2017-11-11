extern void end_game();

object main {
  event create {
    foreach (int x) { print(x); } /* error: can only loop over objs */
  }
}
