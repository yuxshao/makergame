void foo()
{
  if (true) return 42; /* Should return void */
  else return;
}

void main()
{
  return 42;
}
