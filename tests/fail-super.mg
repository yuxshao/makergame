object child : parent {
  event step { super(3); } // super for step takes no arguments
}

object parent {
  event create(int x) { std::print(x); }
}

object main { }
