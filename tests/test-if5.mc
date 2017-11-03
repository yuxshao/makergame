extern void end_game();
int cond(bool b)
{
  int x;
  if (b)
    x = 42;
  else
    x = 17;
  return x;
}

void main()
{
 print(cond(true));
 print(cond(false));
 end_game();
 return;
}
