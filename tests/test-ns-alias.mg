extern void end_game();

namespace a {
  namespace b { int x; }
  namespace c {
    int x;
    namespace d { int x; }
  }
  namespace D = c::d;
}

namespace B = a::b;
namespace C = a::c;
namespace D = a::c::d;
namespace DD = a::D;

object main {
  event create {
    a::b::x = 1;
    print(B::x);
    a::c::x = 2;
    print(C::x);
    a::c::d::x = 3;
    print(a::D::x);
    print(D::x);
    print(DD::x);
    end_game();
  }
}
