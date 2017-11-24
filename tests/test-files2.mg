extern void end_game();

namespace one = open "test-helpers/simple.mg";

namespace two = open "test-helpers/simple2.mg";

object main {
  event create {
    // set a value defined in that file
    one::x = 1;
    two::x = 2;
    print(one::x);
    print(two::one::x); // two::one refers to the same as one
    print(two::x);
    end_game();
  }
}
