
namespace A = a; // alias can be defined before what it refers to.
namespace a { int x; }

object main {
  event create {
    a::x = 1;
    std::print(A::x);
    std::end_game();
  }
}
