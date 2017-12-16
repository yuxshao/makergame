object helper { }
object aide { }

object main {
  event create {
    helper h;
    aide a;
    std::printb(a == h); // cannot compare unrelated objects
    std::end_game();
  }
}
