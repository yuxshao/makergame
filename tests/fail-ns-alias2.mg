// namespace alias cycle
namespace A = B;
namespace B = A;

object main { }
