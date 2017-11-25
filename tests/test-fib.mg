int fib(int x)
{
  if (x < 2) return 1;
  return fib(x-1) + fib(x-2);
}

object main {
event create
{
  std::print(fib(0));
  std::print(fib(1));
  std::print(fib(2));
  std::print(fib(3));
  std::print(fib(4));
  std::print(fib(5));
  std::end_game();
  return;
}
}
