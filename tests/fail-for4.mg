object main {
event create
{
  int i;

  for (i = 0; i < 10 ; i = j + 1) {} /* j undefined */
}
}
