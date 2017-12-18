namespace n {
  private namespace p { int x; }
  namespace q = p;
}

object main {
  event create {
    n::q::x = 3; // x is accessible through q
    std::print::i(n::q::x);
    std::end_game();
  }
}
