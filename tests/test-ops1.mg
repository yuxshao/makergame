object main {
event create
{
  std::print::i(1 + 2);
  std::print::i(1 - 2);
  std::print::i(1 * 2);
  std::print::i(100 / 2);
  std::print::i(99);
  std::print::b(1 == 2);
  std::print::b(1 == 1);
  std::print::i(99);
  std::print::b(1 != 2);
  std::print::b(1 != 1);
  std::print::i(99);
  std::print::b(1 < 2);
  std::print::b(2 < 1);
  std::print::i(99);
  std::print::b(1 <= 2);
  std::print::b(1 <= 1);
  std::print::b(2 <= 1);
  std::print::i(99);
  std::print::b(1 > 2);
  std::print::b(2 > 1);
  std::print::i(99);
  std::print::b(1 >= 2);
  std::print::b(1 >= 1);
  std::print::b(2 >= 1); 
  std::game::end();
}
}
