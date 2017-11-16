extern void end_game();

namespace sp {
  object hello {
    int this; /* error in namespace */
  }
}

object main {
  event create {
    printstr("hey");
    end_game();
  }
}
