#include <stdio.h>

// Written by Adam Olgin
// 9-27-13

// Solution A (arrays)
main() {

	char x1[100] = "The 25 quick brown foxes jumped over the 27 lazy dogs 17 times";

	int c, i, nwhite, nother;
	int ndigit[10];
	
	c = i = nwhite = nother = 0;
	for (i = 0; i < 10; ++i)
		ndigit[i] = 0;
	
	while (x1[c] != '\0')
		if (x1[c] >= '0' && x1[c] <= '9')
			++ndigit[x1[c]-'0'];
		else if (x1[c] == ' ' || x1[c] == '\n' || x1[c] == '\t')
			++nwhite;
		else
			++nother;
   }
	printf("digits =");
	for (i = 0; i < 10; ++i) {
		printf(" %d", ndigit[i]);
    }
	printf(", white space = %d, other = %d\n", nwhite, nother);
	return 0;
}




