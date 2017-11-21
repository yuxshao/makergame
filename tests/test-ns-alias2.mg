extern void end_game();

namespace A = a; // alias can be defined before what it refers to.
namespace a { int x; }

object main {
  event create {
    a::x = 1;
    print(A::x);
    end_game();
  }
}
