int x;
int get_global() { return x; }
int set_global(int y) { x = y; }

object main {
  int x;
  int set(int x) {
    // manipulates member x with parameter x
    this.x = x;

    // manipulates local x
    int x = x + 1;
    std::print(x);
  }

  event create {
    // manipulates member x
    set(2);
    std::print(x); 

    // manipulates global x
    set_global(1);
    std::print(get_global());
    std::end_game();
  }
}
