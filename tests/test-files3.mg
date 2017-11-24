extern void end_game();

namespace c = open "test-helpers/circular.mg"; // includes itself

object main {
  event create {
    c::x = 12;
    print(c::c::x);
    print(c::c::c::x);
    print(c::c::c::c::x);
    end_game();
  }
}
