function mch=multiChamberFromPath(pth)

l1=load(pth)
cexp=l1.cExperiment;
mch=makeMultiChamber(cexp)

end
