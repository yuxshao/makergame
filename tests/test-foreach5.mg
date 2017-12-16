object aide { }

object main {
  event create {
    aide a = create aide;
    create aide;

    std::printb(std::is_alive(a));
    destroy(a);
    std::printb(std::is_alive(a));

    std::end_game();
  }
}

