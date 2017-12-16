object helper { }
object aide { }

object main {
  event create {
    helper h = create helper;
    helper g = none;
    std::printb(h == g);
    std::printb(h == none);
    std::printb(g == none);

    aide a = none;
    std::printb(a == none);
    std::end_game();
  }
}
