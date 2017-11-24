int foo() {}

int bar() {
  int a;
  void b; /* Error: illegal void local b */
  bool c;

  return;
}

void main() { }
