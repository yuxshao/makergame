namespace n {
  // std is imported into every namespace, so following is valid
  void do_something() { std::print::i(3); }
}

object main {
  event create {
    std::print::i(3);
    n::std::print::i(5); // error: n::std is private
  }
}
