
// load a file
namespace n = open "test-helpers/simple.mg";

object main {
  event create {
    // set a value defined in that file
    n::x = 3;
    std::print(n::x);
    std::end_game();
  }
}
