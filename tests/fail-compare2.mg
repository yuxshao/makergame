object helper { }
object aide { }

object main {
  event create {
    helper h;
    aide a;
    std::print::b(a == h); // cannot compare unrelated objects
    std::game::end();
  }
}
