int gcd(int a, int b) {
  while (a != b) {
    if (a > b) a = a - b;
    else b = b - a;
  }
  return a;
}

object main {
event create
{
  std::print(gcd(2,14));
  std::print(gcd(3,15));
  std::print(gcd(99,121));
  std::end_game();
  return;
}
}
