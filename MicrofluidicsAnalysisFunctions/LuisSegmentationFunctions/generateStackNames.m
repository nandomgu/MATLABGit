function names=generateStackNames(channelName, stackNum, sep)

if nargin<3
    sep='_';
end


if stackNum==1
    names= ['_' 'channelName' '_'];
else
for j=1:stackNum
names{j}= [channelName, sep sprintf('%03d', j)];
end
end
end
