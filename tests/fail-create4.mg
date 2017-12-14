object child : parent {
  event step { super(3); } // super() forbidden outside of create
}

object parent {
  event create(int x) { std::print(x); }
}

object main { }

