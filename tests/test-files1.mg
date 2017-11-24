extern void end_game();

// load a file
namespace n = open "test-helpers/simple.mg";

object main {
  event create {
    // set a value defined in that file
    n::x = 3;
    print(n::x);
    end_game();
  }
}
