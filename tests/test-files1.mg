
// load a file
namespace n = open "test-helpers/simple.mg";

object main {
  event create {
    // set a value defined in that file
    n::x = 3;
    std::print::i(n::x);
    std::game::end();
  }
}
