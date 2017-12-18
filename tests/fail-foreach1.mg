object main {
  event create {
    foreach (int x) { std::print::i(x); } /* error: can only loop over objs */
  }
}
