void foo(int a, bool b)
{
}

object main {
event create
{
  foo(42, true);
  foo(42, 42); /* Fail: int, not bool */
}
}
