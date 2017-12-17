object parent {
  event create(int x)  { std::print(x); }
}

object child : parent { } // nothing should be overridden

object main {
  event create {
    create child(3);
    std::end_game();
  }
}
