namespace n = open "test-helpers/private.mg";

object main {
  event create {
    n::a::x = 0; // error: n::a is private
  }
}
