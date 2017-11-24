void main()
{
  std::printb(true);
  std::printb(false);
  std::printb(true && true);
  std::printb(true && false);
  std::printb(false && true);
  std::printb(false && false);
  std::printb(true || true);
  std::printb(true || false);
  std::printb(false || true);
  std::printb(false || false);
  std::printb(!false);
  std::printb(!true);
  std::print(-10);
  std::print(-(-42));
  std::end_game();
}
