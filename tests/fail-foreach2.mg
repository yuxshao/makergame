object main {
  event create {
    foreach (asdf x) { std::print::i(3); } /* error: obj nonexistent */
  }
}
