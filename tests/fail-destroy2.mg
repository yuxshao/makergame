extern void end_game();

main m; 
object main {
  event create {
    int x;
    x = destroy m; /* error: cannot assign result of destroy */
  }
}
