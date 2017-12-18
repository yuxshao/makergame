
object main {
event create
{
  float x;
  x = 3.0;
  x -= 3.0;
  std::print::f( x );

  std::end_game();
}
}
