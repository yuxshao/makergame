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
    end_game();
  }
}
