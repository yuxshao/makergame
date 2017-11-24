
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
void main()
{
  compute();
  std::end_game();
}
