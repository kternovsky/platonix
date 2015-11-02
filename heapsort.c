#include "heap_intn.h"
#include <stdio.h>

int main(void)
{
	int i, tmp;
	int data[32];
	struct heap_intn h = { data, 0, 32 };

	for(i = 0; i < 32; i++)
	{
		if(scanf("%d", &data[i]) != 1)
			break;
	}

	h.sz = i;

	heap_intn_fix(&h);

	while(i--)
	{
		heap_intn_pop(&h, &tmp);
		printf("%d\n", tmp);
	}

	return 0;
}
