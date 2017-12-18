namespace A {
  object C { }
  object B {
    event create(C c) { std::print::s("create success"); }
    void compute(B b) { std::print::s("member success"); }
  }
  void compute(B b) { std::print::s("success"); }
}

object main {
  event create {
    A::B b = create A::B(create A::C);
    b.compute(b);
    A::compute(b);

    std::game::end();
  }
}
