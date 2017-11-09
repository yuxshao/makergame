void foo(int a, bool b)
{
}

void main()
{
  foo(42, true);
  foo(42, 42); /* Fail: int, not bool */
}
