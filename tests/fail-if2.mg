object main {
event create
{
  if (true) {
    foo; /* Error: undeclared variable */
  }
}
}
