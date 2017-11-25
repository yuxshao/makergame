void foo(int a, bool b)
{
}

object main {
event create
{
  foo(42, true);
  foo(42, true, false); /* Wrong number of arguments */
}
}
