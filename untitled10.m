%%
fitparamsh4mgh1mt=fitparams;
for j=1:numel(genes)
    g=genes{j};
fitparamsh4mgh1mt.(g).(mod).fminsearch([2,8,15,16])=fitparams.hxt4.(mod).fminsearch([2,8,15,16]);
numpars=[4,5,6,7, 9,10];
fitparamsh4mgh1mt.(g).(mod).fminsearch(numpars)=fitparams.hxt1.(mod).fminsearch(numpars);
fitparamsh4mgh1mt.hxt1.(mod).fminsearch(11)=3;
fitparamsh4mgh1mt.hxt3.(mod).fminsearch(11)=1;
fitparamsh4mgh1mt.hxt2.(mod).fminsearch(11)=-.5;
fitparamsh4mgh1mt.hxt6.(mod).fminsearch(11)=-3;
fitparamsh4mgh1mt.hxt7.(mod).fminsearch(11)=-3;
%mig1
%fitparamsh4mgh1mt.hxt4.(mod).fminsearch(11)=4;
fitparamsh4mgh1mt.hxt2.(mod).fminsearch(13)=-.2;
fitparamsh4mgh1mt.hxt6.(mod).fminsearch(13)=1;
fitparamsh4mgh1mt.hxt7.(mod).fminsearch(13)=1;


end