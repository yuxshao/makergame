// used to be able to have files include themselves. now forbidden.
namespace c = open "test-helpers/circular.mg"; // includes itself

object main {
  event create {
    c::x = 12;
    std::print::i(c::c::x);
    std::print::i(c::c::c::x);
    std::print::i(c::c::c::c::x);
    std::end_game();
  }
}
