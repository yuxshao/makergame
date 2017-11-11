extern void end_game();

object main {
  int compute() { return 3; }
  event create { print(0); end_game(); }
}
