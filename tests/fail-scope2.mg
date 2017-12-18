object main {
event create {
  int x;
  x = 3;
  {
    int y;
    y = 4;
  }
  std::print::i(x);
  std::print::i(y); /* error: y not in outer scope */
}
}
