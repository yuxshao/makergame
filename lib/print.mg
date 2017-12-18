private namespace p {
  extern void print(int x);
  extern void printb(bool x);
  extern void print_float(float x);
  extern void printstr(string x);
}

void i(int x) { p::print(x); }
void b(bool x) { p::printb(x); }
void f(float x) { p::print_float(x); }
void s(string x) { p::printstr(x); }
