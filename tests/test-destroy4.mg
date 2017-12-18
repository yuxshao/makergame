
object helper {
  int i;
  event create { this.i = 3; }
}

object main {
  event create {
    helper h;
    h = create helper;
    destroy h;
    /* destroyed objects are immediately invisible to loops */
    foreach (helper h) { std::print::s("still exists!"); }
    /* refs to destroyed objects still work until at least end of event */
    std::print::i(h.i);
    std::end_game();
  }
}
