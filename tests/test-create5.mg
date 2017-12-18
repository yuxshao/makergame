object child : parent {
  event create(int x) { super(); std::print::i(x); }
}

object parent {
  event create() { std::print::i(4); }
}

object main {
  event create {
    create child(3);
    std::end_game();
  }
}

