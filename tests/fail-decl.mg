object main {
  event step {
    int x;
    int x; // error: redeclaration in same block
  }
}
