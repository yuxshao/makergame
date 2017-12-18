
object helper {
  event create { destroy this; }
}

object main {
  event create {
    create helper;
    int i;
    i = 0; /* count # helpers */
    foreach (helper h) { i = i + 1; }
    std::print::i(i);
    std::end_game();
  }
}
