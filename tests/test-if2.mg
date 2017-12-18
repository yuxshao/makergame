object main {
event create
{
  if (true) std::print::i(42); else std::print::i(8);
  std::print::i(17);
  std::game::end();
  return;
}
}
