int fib(int x)
{
  if (x < 2) return 1;
  return fib(x-1) + fib(x-2);
}

object main {
event create
{
  std::print::i(fib(0));
  std::print::i(fib(1));
  std::print::i(fib(2));
  std::print::i(fib(3));
  std::print::i(fib(4));
  std::print::i(fib(5));
  std::end_game();
  return;
}
}
