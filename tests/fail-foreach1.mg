object main {
  event create {
    foreach (int x) { std::print(x); } /* error: can only loop over objs */
  }
}
