#include "hasht_ii.h"
#include <assert.h>

int main(void)
{
	size_t idxs[128];
	struct hasht_ii_data data[128];
	int i;
	int times = 0;
	struct hasht_ii h = { idxs, data, 128 };
	hasht_ii_init(&h);
	struct hasht_ii_entry tmp;

start:
	for(i = 0; i < 128; i++)
	{
		assert(!hasht_ii_ins(&h, i, i));
		assert(hasht_ii_has(&h, i));
	}

	for(i = 0; i < 128; i++)
	{
		assert(!hasht_ii_del(&h, i, &tmp));

		assert(tmp.key == i);
		assert(tmp.value == i);
		assert(!hasht_ii_has(&h, i));
	}

	if(++times < 10) goto start;

	times = 0;
start2:
	for(i = 0; i < 128; i++)
	{
		assert(!hasht_ii_ins(&h, i, i));
		assert(hasht_ii_has(&h, i));
	}

	for(i = 0; i < 128; i++)
	{
		assert(!hasht_ii_update(&h, i, i * 2));
		assert(hasht_ii_has(&h, i));
		assert(!hasht_ii_get(&h, i, &tmp));
		assert(tmp.key == i);
		assert(tmp.value == i * 2);
	}

	for(i = 0; i < 128; i++)
	{
		assert(!hasht_ii_del(&h, i, &tmp));
		assert(tmp.key == i);
		assert(tmp.value == i * 2);
		assert(!hasht_ii_has(&h, i));
	}

	if(++times < 10) goto start2;

	return 0;
}
