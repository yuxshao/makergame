extern void end_game();

main {
  create {
    int x;
    x = create main; /* error: must assign to object type */
  }
}
