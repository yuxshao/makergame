extern void end_game();

object main {
  event create { destroy 5; } /* error: can't destroy non-object ref */
}
