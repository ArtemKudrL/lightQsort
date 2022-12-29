# lightQsort

x86-64 assembly int32 qsort

lightweight and fast

max memory consumption ~24*N bytes (3*8 bytes per recursive call)

average memory consumption ~24*log2(N)

on int limits range

for almost any N ~2 times faster than std::qsort
