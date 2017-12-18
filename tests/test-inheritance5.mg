object parent {
  event create  { std::print::s("create"); }
  event step    { std::print::s("step"); }
  event draw    { std::print::s("draw"); }
  event destroy { std::print::s("destroy"); }
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
