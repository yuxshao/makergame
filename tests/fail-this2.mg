object main {
  event create {
    int this; /* error: this cannot be declared */

    this = 3;
  }
}
