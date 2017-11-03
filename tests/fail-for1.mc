void main()
{
  int i;
  for ( ; true ; ) {} /* OK: Forever */

  for (i = 0 ; i < 10 ; i = i + 1) {
    if (i == 3) return;
  }

  for (j = 0; i < 10 ; i = i + 1) {} /* j undefined */
}
