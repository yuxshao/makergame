extern void end_game();

namespace a {
  namespace b { int x; }
  namespace c {
    int x;
    namespace d { int x; }
  }
  namespace D = c::d; // inner alias
}

namespace B = a::b; // regular alias
namespace BB = B; // alias to alias
namespace C = a::c;
namespace D = a::c::d; // alias to nested
namespace DD = a::D; // alias to alias of inner ns

object main {
  event create {
    a::b::x = 1;
    print(B::x);
    print(BB::x);
    a::c::x = 2;
    print(C::x);
    a::c::d::x = 3;
    print(a::D::x);
    print(D::x);
    print(DD::x);
    end_game();
  }
}
