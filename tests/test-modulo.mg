using std;
namespace print = std::print;

object main {
  event create {
    print::i(5 % 2);
    print::i(-5 % 2);
    print::f(6 % 2.5);
    print::f(5.5 % 2);
    print::f(5.5 % 2.5);
    std::game::end();
  }
}
