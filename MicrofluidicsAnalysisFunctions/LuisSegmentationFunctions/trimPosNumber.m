function final=trimPosNumber(posStr)
%% this function keeps the last 3 characters of a string ,which correspond to the position indices,and discards the others, which correspond to position names.
final= posStr(end-2:end);
end