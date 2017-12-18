object son : parent {
  event step {
    std::print::s("child step");
    super();
  }

  event draw {
    std::print::s("child draw");
    super();
  }
}

object daughter : parent {
  event step {
    super();
    std::print::s("daughter step");
  }

  event draw {
    super();
    std::print::s("daughter draw");
  }
}

object parent {
  event step { std::print::s("parent step"); }
  event draw { std::print::s("parent draw"); }
}

object main {
  int i;
  event create {
    i = 0;
    create son;
    create daughter;
  }

  event step { std::end_game(); }
}
