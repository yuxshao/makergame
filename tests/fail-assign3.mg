void myvoid()
{
  return;
}

object main {
  event create {
    int i;

    i = myvoid(); /* Fail: assigning a void to an integer */
  }
}
