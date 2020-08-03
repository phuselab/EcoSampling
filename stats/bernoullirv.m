function x=bernoullirv(p,m)
%return m samples of bernoulli (p) rv
r=rand(m,1);
x=(r>=(1-p));