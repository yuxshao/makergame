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
    std::print::i(x);
  }

  event create {
    // manipulates member x
    set(2);
    std::print::i(x); 

    // manipulates global x
    set_global(1);
    std::print::i(get_global());
    std::game::end();
  }
}
