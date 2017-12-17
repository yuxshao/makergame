object son : parent {
  event step {
    std::printstr("child step");
    super();
  }

  event draw {
    std::printstr("child draw");
    super();
  }
}

object daughter : parent {
  event step {
    super();
    std::printstr("daughter step");
  }

  event draw {
    super();
    std::printstr("daughter draw");
  }
}

object parent {
  event step { std::printstr("parent step"); }
  event draw { std::printstr("parent draw"); }
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
