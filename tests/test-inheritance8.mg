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
    create son;
    create daughter;
    foreach (parent p) destroy p;
    std::end_game();
  }
}
