extern void end_game();

object helper {
  int x;
  event create { x = 5; }
}

helper make() { return create helper; }

object main {
  event create {
    // member variables of anything resolving to an object can be assigned
    // not just chains of identifiers

    make().x = 3;
    foreach (helper h) { print(h.x); destroy h; }

    (create helper).x = 4;
    foreach (helper h) { print(h.x); destroy h; }

    print(make().x);

    helper h;
    (h = create helper).x = 4;
    print(h.x);

    // assignments are also lvalues
    (h.x = 5) = 6;
    print(h.x);

    end_game();
  }
}
