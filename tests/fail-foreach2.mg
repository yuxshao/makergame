object main {
  event create {
    foreach (asdf x) { std::print(3); } /* error: obj nonexistent */
  }
}
