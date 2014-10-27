#include <stdio.h>
#define IN 1 /* inside a word */
#define OUT 0 /* outside a word */

// Written by Adam Olgin
// 9-27-13

// Solution A (arrays)
int main() {
	char x1[100] = "The quick brown fox jumped over the lazy dog.";
	
	int i = 0;
	int nl, nw, nc, state;
	char c;
	state = 0;
	nl = nw = nc = 0;

	while (c = x1[i] != '\0') {
		++nc;
		if (c == '\n')
			++nl;
		if (c == ' ' || c == '\n' || c == '\t')
			state = OUT;
		else if (state == OUT) {
			state = IN;
			++nw;
		}
		i++;
	}
	printf("%d %d %d\n", nl, nw, nc);
	return 0;
}
