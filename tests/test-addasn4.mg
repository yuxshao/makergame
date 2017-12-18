object main {
event create
{
  int x;
  x = 0;
  std::print::i((x += 2) += 2);
  std::print::i(x);
  std::game::end();
}
}
