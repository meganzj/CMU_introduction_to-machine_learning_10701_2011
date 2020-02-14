%50 values of alpha, logarithmically spaced
alphas=10.^(0:-.05:-5);
perfsav=[]
for(m=1:numel(alphas))
  %note that 'alpha' is a matlab builtin...
  alph=alphas(m);
  naivebayes
  perfsav(m)=perf;
end
semilogx(alphas,perfsav);
