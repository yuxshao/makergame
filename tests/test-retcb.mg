extern void end_game();

int compute() {
  int i;
  {
    i = 15;
    print(i);
    return i; /* ok: return at end of block */
  }
  i = 3;
  print(i);
  return i;
}
void main()
{
  compute();
  end_game();
}
