void foo(int a, bool b)
{
}

void bar()
{
}

object main {
event create
{
  foo(42, true);
  foo(42, bar()); /* int and void, not int and bool */
}
}
