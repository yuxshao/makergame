object parent {
  event destroy { std::printstr("parent destroy"); }
}

object son : parent {
  event destroy { std::printstr("son destroy"); }
}

object daughter : parent {
  event destroy { std::printstr("daughter destroy"); super(); super(); }
}

object main {
  event create {
    std::printstr("destroy");
    create son;
    create daughter;
    foreach (parent p) destroy p;

    std::printstr("delete");
    create son;
    create daughter;
    create parent;
    foreach (parent p) delete p;

    std::end_game();
  }
}
