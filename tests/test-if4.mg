
object main {
event create
{
  if (false) std::print::i(42); else std::print::i(8);
  std::print::i(17);
  std::end_game();
  return;
}
}
