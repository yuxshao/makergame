extern void end_game();

object main {
  event create { create 5; } /* error: can't create non-object type */
}
