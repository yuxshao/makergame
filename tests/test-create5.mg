object child : parent {
  event create(int x) { super(); std::print(x); }
}

object parent {
  event create() { std::print(4); }
}

object main {
  event create {
    create child(3);
    std::end_game();
  }
}

