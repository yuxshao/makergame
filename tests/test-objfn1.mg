extern void end_game();

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

    print(h.number()); // other member function test
    print((create helper).number()); 

    print(h.get_number());
    print(number()); // number is not shadowed in object main

    end_game();
  }
}
