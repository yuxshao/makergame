extern void end_game();

main {
  create {
    foreach (asdf x) { print(3); } /* error: obj nonexistent */
  }
}
