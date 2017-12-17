object parent {
  event create  { std::printstr("create"); }
  event step    { std::printstr("step"); }
  event draw    { std::printstr("draw"); }
  event destroy { std::printstr("destroy"); }
}

object child : parent { } // nothing should be overridden

object main {
  int i;
  child c;
  event create {
    i = 0;
    c = create child;
  }

  event step {
    if (i >= 1) { destroy c; std::end_game(); }
    else ++i;
  }
}
