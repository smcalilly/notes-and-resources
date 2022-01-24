a linear combination of a collection of vectors is a sum of scalar multiples of them

for instance, one linear combination of two vectors u and v would be 3u - 2v

given three vectors u, v, and w, the expression 0.5u - v + 6w is a linear combination of u, v, and w.

algebraically, if you have a collection of n vectors v1, v2, v3 .... vn, as well as any choice of n scalars, s1, s2, s3 ... sn, a linear transformation T preserves the linear combination:

T(s1v1 + s2v2 + s3v3 + ... + snvn) = s1T(v1) + s2T(v2) + s3T(v3) + ... + snT(vn)

you can use this to find the midpoint between the tips of two vectors:
0.5v + 0.5v = 0.5(u + v)

because the midpoint between two vectors is a linear combination of the vectors, the linear transformation T sets the midpoint between u and v to the midpoint between T(u) and T(v)

TODO: learn about this from another source