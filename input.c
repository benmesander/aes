/* figure out section 3.4 of FIPS 197 - state array */

#include <stdio.h>
#include <inttypes.h>

#define Nb 4

int main(int argc, char **argv)
{
  size_t r, c;
  uint8_t in[16] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f };
  uint8_t state[4][4];

  /* create and print out state array from input */
  for (r = 0; r < Nb; r++) {
    for (c = 0; c < Nb; c++) {
      state[r][c] = in[r + 4*c];
      printf("%02x ", state[r][c]);
    }
    printf("\n");
  }

  /* print out state array in-memory order */
  for (r = 0; r < 16; r++) {
    printf("%02x", *(*state + r));
  }
  printf("\n");

  return 0;
}
