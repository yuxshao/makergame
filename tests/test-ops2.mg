object main {
event create
{
  std::print::b(true);
  std::print::b(false);
  std::print::b(true && true);
  std::print::b(true && false);
  std::print::b(false && true);
  std::print::b(false && false);
  std::print::b(true || true);
  std::print::b(true || false);
  std::print::b(false || true);
  std::print::b(false || false);
  std::print::b(!false);
  std::print::b(!true);
  std::print::i(-10);
  std::print::i(-(-42));
  std::end_game();
}
}
