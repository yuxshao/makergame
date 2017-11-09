void foo(int a, bool b)
{
}

void bar()
{
}

void main()
{
  foo(42, true);
  foo(42, bar()); /* int and void, not int and bool */
}
