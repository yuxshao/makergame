extern void end_game();

main {
  create { destroy 5; } /* error: can't destroy non-object ref */
}
