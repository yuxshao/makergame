int compute() { return 3; }
object main {
  event create {
    compute() = 5; // not an lvalue
  }
}
