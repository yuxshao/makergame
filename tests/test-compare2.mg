// comparisons with inheritance chains
object helper : parent { }
object parent { }

object main {
  event create {
    helper h = create helper;
    parent P = create parent;
    parent H = h;
    std::print::b(h == h);
    std::print::b(H == h);
    std::print::b(h == H);
    std::print::b(h == P);
    std::print::b(P == h);
    std::end_game();
  }
}
