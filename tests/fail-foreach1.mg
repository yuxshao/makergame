extern void end_game();

main {
  create {
    foreach (int x) { print(x); } /* error: can only loop over objs */
  }
}
