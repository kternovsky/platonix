ifdef(`SEQ_RAND',``#include' <stddef.h>')
ifdef(`SEQ_READ',`int SEQ_NAME`'_read(struct SEQ_NAME *, SEQ_VAL_TYPE *);')
ifdef(`SEQ_WRITE',`int SEQ_NAME`'_write(struct SEQ_NAME *, SEQ_VAL_TYPE);')
int SEQ_NAME`'_next(struct SEQ_NAME *);
ifdef(`SEQ_BI',`int SEQ_NAME`'_prev(struct SEQ_NAME *);')
ifdef(`SEQ_RAND',`int SEQ_NAME`'_to(struct SEQ_NAME *, const size_t);')
