object main {
event create
{
  if (true) {
    42;
  } else {
    bar; /* Error: undeclared variable */
  }
}
}
