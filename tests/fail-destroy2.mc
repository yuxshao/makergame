extern void end_game();

main m; 
main {
  create {
    int x;
    x = destroy m; /* error: cannot assign result of destroy */
  }
}
