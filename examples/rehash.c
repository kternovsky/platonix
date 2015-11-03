#include "hasht_ii.h"
#include <string.h>
int main(void)
{
	int i;
	size_t idxs[32];
	size_t idxs2[64];
	struct hasht_ii_data data[32];
	struct hasht_ii_data data2[64];
	struct hasht_ii h = { idxs, data, 32 };
	hasht_ii_init(&h);

	for(i = 0; i < 32; i++)
	{
		hasht_ii_ins(&h, i, i);
	}

	memcpy(idxs2, idxs, 32 * sizeof *idxs);
	memcpy(data2, data, 32 * sizeof *data);
	h.index = idxs;
	h.data = data;
	h.cap = 64;
	hasht_ii_rehash(&h, 32);
	return 0;
}
