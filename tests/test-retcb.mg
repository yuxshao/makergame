
int compute() {
  int i;
  {
    i = 15;
    std::print(i);
    return i; /* ok: return at end of block */
  }
  i = 3;
  std::print(i);
  return i;
}
object main {
event create
{
  compute();
  std::end_game();
}
}
