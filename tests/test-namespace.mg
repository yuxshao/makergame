extern void end_game();

int compute () { return 1; }

namespace a {
  int compute() { return 2; }
  aide b;
  object aide {
    int x;
    event create { x = 4; b = this; }
    int compute() { return 3; }
    aide make() { return create aide; }
    a::aide inner() { return create a::aide; }
  }

  namespace a {
    object aide {
      int y; int x;
      int compute() { return 6; }
      event create { x = 5; }
    }
  }
}

object main {
  event create {
    // no namespace specified gives regular fn
    print(compute());
    // appropriate outer namespace call
    print(a::compute());
    // returning an object defined in the namespace of the call
    print(a::b.make().compute());
    // member call from namespace
    print(a::b.compute());
    // member variable from namespace
    print(a::b.make().x);
    // returning an object defined inside a ns inside the ns of the call
    print(a::b.inner().x);
    print(a::b.inner().compute());
    end_game();
  }
}
