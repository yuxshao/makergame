namespace sp {
  object hello {
    int this; /* error in namespace */
  }
}

object main {
  event create {
    std::print::s("hey");
    std::game::end();
  }
}
