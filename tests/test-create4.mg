object child : parent {
  event create(int x) { super(x+1); std::print(x); }
}

object parent {
  event create(int x) { std::print(x); }
}

object main {
  event create {
    create child(3);
    std::end_game();
  }
}

