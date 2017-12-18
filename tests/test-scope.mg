
object main {
event create {
  int x;
  x = 3;
  std::print::i(x);

  int y;
  y = 4;
  std::print::i(y);

  if (x == 3) {
    std::print::i(x);
    int x; // OK: can redeclare in different block
    x = 5;
    std::print::i(x);
  }
  std::print::i(x);
  std::end_game();
}
}
