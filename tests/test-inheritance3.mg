object parent {
  event step { std::printstr("hello!"); }
}

object child : parent {
  event step { std::printstr("hey!"); } 
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
      std::end_game();
  }
}
