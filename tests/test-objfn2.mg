int x;
object helper {
  event create {
    x = 3; std::print(x);
  }
}
object main {
  int x;
  int set(int x) { this.x = x; } // sets local to parameter x
  event create {
    set(4);
    std::print(x); // gets local x
    create helper; // gets the global x
    std::end_game();
  }
}
