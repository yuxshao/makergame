
object main {
event create
{
  if (false) std::print(42); else std::print(8);
  std::print(17);
  std::end_game();
  return;
}
}
