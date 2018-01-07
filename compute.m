function perf = compute(x, aoa)

    load 'wing.csv' %remove all text and keep only coordinates in csv file
    shape = wing;

    newshape = morph(shape, x);


   [pol, foil] = xfoil(newshape,aoa,281551,0,'oper/iter 1000');

   pol.alpha;
   perf = pol.CD/pol.CL;

end