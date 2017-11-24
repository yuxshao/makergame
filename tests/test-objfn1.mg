
int number() { return 3; }

object helper {
  int number() { return 4; }
  int get_number() { return number(); } // number is shadowed in class helper
  event create { }
}
object main {
  helper make() { return create helper; }
  event create {
    helper h;
    h = make(); // self member function test
    h = this.make();

    std::print(h.number()); // other member function test
    std::print((create helper).number()); 

    std::print(h.get_number());
    std::print(number()); // number is not shadowed in object main

    std::end_game();
  }
}
