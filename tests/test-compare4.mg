object helper { }
object aide { }

object main {
  event create {
    helper h = create helper;
    helper g = none;
    std::print::b(h == g);
    std::print::b(h == none);
    std::print::b(g == none);

    aide a = none;
    std::print::b(a == none);
    std::game::end();
  }
}
