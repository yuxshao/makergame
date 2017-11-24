object main {
event create
{
  std::print(1 + 2);
  std::print(1 - 2);
  std::print(1 * 2);
  std::print(100 / 2);
  std::print(99);
  std::printb(1 == 2);
  std::printb(1 == 1);
  std::print(99);
  std::printb(1 != 2);
  std::printb(1 != 1);
  std::print(99);
  std::printb(1 < 2);
  std::printb(2 < 1);
  std::print(99);
  std::printb(1 <= 2);
  std::printb(1 <= 1);
  std::printb(2 <= 1);
  std::print(99);
  std::printb(1 > 2);
  std::printb(2 > 1);
  std::print(99);
  std::printb(1 >= 2);
  std::printb(1 >= 1);
  std::printb(2 >= 1); 
  std::end_game();
}
}
