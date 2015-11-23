divert(-1)
define(`PAIR_NAME', `ACTIVE_PAIR')
define(`PAIR_FIRST', `_get(`PAIR_NAMES_T1', ACTIVE_PAIR)')
define(`PAIR_SECOND', `_get(`PAIR_NAMES_T2', ACTIVE_PAIR)')
divert dnl
struct PAIR_NAME
{
	PAIR_FIRST first;
	PAIR_SECOND second;
};
