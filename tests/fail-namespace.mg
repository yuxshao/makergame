namespace sp {
  object hello {
    int this; /* error in namespace */
  }
}

object main {
  event create {
    std::printstr("hey");
    std::end_game();
  }
}
