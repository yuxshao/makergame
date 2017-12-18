object parent {
  event create(int x)  { std::print::i(x); }
}

object daughter : parent { }
object son : parent { 
  event create { super(5); } // super with arguments from parent
}

object granddaughter : daughter { }
object grandson : daughter {
  event create {
    super(6); // super with arguments from grandparent
  }
}

object main {
  event create {
    create daughter(3); // create with arguments from parent
    create granddaughter(4); // create with arguments from grandparent
    create son;
    create grandson;
    std::game::end();
  }
}
