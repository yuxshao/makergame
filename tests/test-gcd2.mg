int gcd(int a, int b) {
  while (a != b)
    if (a > b) a = a - b;
    else b = b - a;
  return a;
}

void main()
{
  std::print(gcd(14,21));
  std::print(gcd(8,36));
  std::print(gcd(99,121));
  std::end_game();
  return;
}
