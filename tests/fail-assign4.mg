object helper { }
object main {
  event create {
    helper x;
    create helper = x; // not an lvalue
  }
}
