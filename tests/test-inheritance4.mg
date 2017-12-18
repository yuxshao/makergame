object parent {
  void compute() { std::print::s("parent compute"); }
  event create { std::print::s("parent create"); }
}

object child : parent {
  void compute() { std::print::s("child compute"); }
  event create { std::print::s("child create"); } 
}

object main {
  int i;
  event create {
    child c = create child; // child create
    c.compute();            // child compute

    parent p = create parent; // parent create
    p.compute();              // parent compute

    p = c;
    p.compute(); // parent compute, despite pointing to child, since non-virtual
    std::end_game();
  }
}
