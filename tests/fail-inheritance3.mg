object parent { event create(int x)  { } }
object child : parent { }

object main {
  event create { create child; } // error: requires argument
}
