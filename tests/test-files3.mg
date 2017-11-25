
namespace c = open "test-helpers/circular.mg"; // includes itself

object main {
  event create {
    c::x = 12;
    std::print(c::c::x);
    std::print(c::c::c::x);
    std::print(c::c::c::c::x);
    std::end_game();
  }
}
