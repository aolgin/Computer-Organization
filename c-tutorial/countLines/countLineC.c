#include <stdio.h>
#define IN 1 /* inside a word */
#define OUT 0 /* outside a word */

// Written by Adam Olgin
// 9-27-13

// Solution C (native pointers)
int main() {
	char x1[100] = "The quick brown fox jumped over the lazy dog.";
	int nl, nw, nc, state;
	state = OUT;
	nl = nw = nc = 0;
	char *x1ptr = x1;
	
	while (*x1ptr != '\0') {
		++nc;
		if (*x1ptr == '\n'))
			++nl;
		if (*x1ptr == ' ' || *x1ptr == '\n' || *x1ptr == '\t'))
			state = OUT;
		else if (state == OUT) {
			state = IN;
			++nw;
		}
		*x1ptr++;
	}
	printf("%d %d %d\n", nl, nw, nc);
	return 0;
}
