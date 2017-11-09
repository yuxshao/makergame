void foo(int a, bool b)
{
}

void main()
{
  foo(42, true);
  foo(42); /* Wrong number of arguments */
}
