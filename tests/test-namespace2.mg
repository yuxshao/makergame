namespace A {
  int y; int z;
  void compute(int x) { std::print::s("A"); std::print::i(x); std::print::i(y); }
  void compute2(int x) { std::print::s("A2"); std::print::i(x); std::print::i(z); }
}

namespace B {
  void compute() { std::print::s("B"); }
}

void compute2() { std::print::s("main2"); }

using A;
using B;
int z;

object main {
  event create {
    compute(); // B
    y = 5; // overwrites A::z
    A::compute(10); // A 10 5
    compute2(); // main2
    A::z = 5;
    z = 10; // does not overwrite A::z
    A::compute2(20); // A2 20 5
    std::game::end();
  }
}
