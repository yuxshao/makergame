
namespace one = open "test-helpers/simple.mg";

namespace two = open "test-helpers/simple2.mg";

object main {
  event create {
    // set a value defined in that file
    one::x = 1;
    two::x = 2;
    std::print(one::x);
    std::print(two::one::x); // two::one refers to the same as one
    std::print(two::x);
    std::end_game();
  }
}
