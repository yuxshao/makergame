int compute() { return 3; }
void main() {
  compute() = 5; // not an lvalue
}
