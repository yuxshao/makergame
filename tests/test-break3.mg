
object helper { }
object main {
  event create {
    create helper;
    create helper;
    create helper;
    create helper;
    int i;
    i = 0;
    foreach (helper h) {
      if (i == 2) break;
      std::print::i(i);
      i = i + 1;
    }
    std::game::end();
  }
}
