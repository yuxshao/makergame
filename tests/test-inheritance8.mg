object parent {
  event destroy { std::print::s("parent destroy"); }
}

object son : parent {
  event destroy { std::print::s("son destroy"); }
}

object daughter : parent {
  event destroy { std::print::s("daughter destroy"); super(); super(); }
}

object main {
  event create {
    std::print::s("destroy");
    create son;
    create daughter;
    foreach (parent p) destroy p;

    std::print::s("delete");
    create son;
    create daughter;
    create parent;
    foreach (parent p) delete p;

    std::game::end();
  }
}
