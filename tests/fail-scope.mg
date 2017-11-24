object main {
event create {
  x = 3; /* error: variable used before defined */
  int x;
}
}
