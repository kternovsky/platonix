#include <stdio.h>
#include <assert.h>
#include "hset.h"

static void test_ins(void);
static void test_has(void);
static void test_del(void);
static void test_seq(void);
static void test_union(void);
static void test_intersection(void);
static void test_diff(void);
static void test_subset(void);

int main(int argc, char **argv)
{
	test_ins();
	test_has();
	test_del();
	test_seq();
	test_union();
	test_intersection();
	test_diff();
	test_subset();
	puts("Success");
}

void test_ins(void)
{
	int i;
	size_t idx[10];
	struct set_i_data data[10];
	struct set_i s = { idx, data, 10 };

	set_i_init(&s);

	for(i = 0; i < 10; i++)
		assert(!set_i_ins(&s, i) && "insert failed");
}

void test_has(void)
{
	int i;
	size_t idx[10];
	struct set_i_data data[10];
	struct set_i s = { idx, data, 10 };

	set_i_init(&s);

	for(i = 0; i < 10; i++)
	{
		set_i_ins(&s, i);
		assert(set_i_has(&s, i) && "has failed");
	}
}

void test_del(void)
{
	int i;
	size_t idx[10];
	struct set_i_data data[10];
	struct set_i s = { idx, data, 10 };

	set_i_init(&s);

	for(i = 0; i < 10; i++)
	{
		set_i_ins(&s, i);
	}

	for(i = 0; i < 10; i++)
	{
		int tmp;
		assert(!set_i_del(&s, i, &tmp) && "del failed");
		assert(!set_i_has(&s, i) && "still has after del");
	}
}

void test_seq(void)
{
	int i;
	int seen[10];
	size_t idx[10];
	struct set_i_data data[10];
	struct set_i s = { idx, data, 10 };
	struct set_i_vseq seq;

	set_i_init(&s);

	for(i = 0; i < 10; i++)
	{
		set_i_ins(&s, i);
	}

	assert(!set_i_iter(&seq, &s) && "iter failed");

	do
	{
		int tmp;
		assert(!seq.seq.ops->read(&seq.seq, &tmp) && "read failed");
		seen[tmp] = 1;
	} while(!seq.seq.ops->next(&seq.seq));

	for(i = 0; i < 10; i++)
	{
		assert(seen[i] && "sequence missing members");
	}
}

static void test_union(void)
{
	int i;
	size_t idx1[10], idx2[10], idx3[20];
	struct set_i_data data1[10], data2[10], data3[20];
	struct set_i s1 = { idx1, data1, 10 }, s2 = { idx2, data2, 10 },
		     s3 = { idx3, data3, 20 };

	set_i_init(&s1);
	set_i_init(&s2);
	set_i_init(&s3);

	for(i = 0; i < 10; i++)
		set_i_ins(&s1, i);

	for(i = 10; i < 20; i++)
		set_i_ins(&s2, i);

	assert(!set_i_union(&s3, &s1, &s2) && "union failed");

	for(i = 0; i < 20; i++)
	{
		assert(set_i_has(&s3, i) && "union missing members");
	}
}

static void test_intersection(void)
{
	int i;
	size_t idx1[10], idx2[10], idx3[5];
	struct set_i_data data1[10], data2[10], data3[20];
	struct set_i s1 = { idx1, data1, 10 }, s2 = { idx2, data2, 10 },
		     s3 = { idx3, data3, 5 };
	struct set_i_vseq seq;

	set_i_init(&s1);
	set_i_init(&s2);
	set_i_init(&s3);

	for(i = 0; i < 10; i++)
		set_i_ins(&s1, i);

	for(i = 0; i < 10; i++)
		set_i_ins(&s2, i + 5);

	assert(!set_i_intersection(&s3, &s1, &s2) && "union failed");
	assert(!set_i_iter(&seq, &s3) && "iter failed");

	do
	{
		int tmp;
		assert(!seq.seq.ops->read(&seq.seq, &tmp) && "read failed");
		assert(set_i_has(&s1, tmp) && set_i_has(&s2, tmp) && "intersection invalid");
	} while(!seq.seq.ops->next(&seq.seq));
}

static void test_diff(void)
{
	int i;
	size_t idx1[10], idx2[10], idx3[5];
	struct set_i_data data1[10], data2[10], data3[5];
	struct set_i s1 = { idx1, data1, 10 }, s2 = { idx2, data2, 10 },
		     s3 = { idx3, data3, 5 };
	struct set_i_vseq seq;

	set_i_init(&s1);
	set_i_init(&s2);
	set_i_init(&s3);

	for(i = 0; i < 10; i++)
		set_i_ins(&s1, i);

	for(i = 0; i < 10; i++)
		set_i_ins(&s2, i + 5);

	assert(!set_i_diff(&s3, &s1, &s2) && "diff failed");
	assert(!set_i_iter(&seq, &s3) && "iter failed");

	do
	{
		int tmp;
		assert(!seq.seq.ops->read(&seq.seq, &tmp) && "read failed");
		assert(set_i_has(&s1, tmp) && !set_i_has(&s2, tmp) && "difference invalid");
	} while(!seq.seq.ops->next(&seq.seq));
}
static void test_subset(void);

static void test_subset(void)
{
	int i;
	size_t idx1[10], idx2[10];
	struct set_i_data data1[10], data2[10];
	struct set_i s1 = { idx1, data1, 10 }, s2 = { idx2, data2, 10 };

	set_i_init(&s1);
	set_i_init(&s2);

	for(i = 0; i < 10; i++)
	{
		set_i_ins(&s1, i);
		set_i_ins(&s2, i);
	}

	assert(set_i_is_subset(&s1, &s2) && "subset invalid");

	for(i = 0; i < 9; i++)
	{
		int tmp;
		set_i_del(&s1, i, &tmp);

		assert(set_i_is_subset(&s1, &s2) && "subset invalid");
	}
}
