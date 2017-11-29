int compute[10](int x) {
  int ret[10];
  return ret;
}

object main {
  event create {
    compute(5)[3] = 5; // error: cannot assign to element of rvalue
  }
}
