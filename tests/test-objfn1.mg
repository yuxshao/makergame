extern void end_game();

object main {
  int compute() { return 3; }
  event create { print(this.compute()); end_game(); }
}
