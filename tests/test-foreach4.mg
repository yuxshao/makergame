
object helper { }
object aide { }

void print_obj_count() {
  int i = 0;
  foreach (object o) ++i;
  std::print::i(i);
}

object main {
  event create {
    create helper;
    create aide;
    create aide;

    print_obj_count(); // 4 including myself
    foreach (object o) destroy o;

    print_obj_count();

    std::end_game();
  }
}

