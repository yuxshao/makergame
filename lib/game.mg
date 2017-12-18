namespace key = open "key.mg";

private namespace p {
  extern void end_game();
}

bool obj_alive (object o) {
  foreach (object x)
    if (x == o) return true;
  return false;
}

// objects that remove all other objects
// TODO: Should remove at start of step. but awkward syntax then...
//       To get this right, need real custom virtual functions
object room {
  event create {
    foreach (object r) { if (r != this) delete r; }
    key::set_key();
  }
}

void end() { p::end_game(); }
