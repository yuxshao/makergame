int gcd(int a, int b) {
  while (a != b)
    if (a > b) a = a - b;
    else b = b - a;
  return a;
}

object main {
event create
{
  std::print::i(gcd(14,21));
  std::print::i(gcd(8,36));
  std::print::i(gcd(99,121));
  std::end_game();
  return;
}
}
