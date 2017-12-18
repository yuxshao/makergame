object parent {
  event step { std::print::s("hello!"); }
}

object child : parent {
  event step { std::print::s("hey!"); } 
}

object main {
  int i;
  event create {
    i = 2;
    create parent;
    create child;
  }

  event step {
    i -= 1; // run for 2 steps
    if (i == 0)
      std::game::end();
  }
}
