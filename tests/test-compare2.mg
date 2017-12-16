// comparisons with inheritance chains
object helper : parent { }
object parent { }

object main {
  event create {
    helper h = create helper;
    parent P = create parent;
    parent H = h;
    std::printb(h == h);
    std::printb(H == h);
    std::printb(h == H);
    std::printb(h == P);
    std::printb(P == h);
    std::end_game();
  }
}
