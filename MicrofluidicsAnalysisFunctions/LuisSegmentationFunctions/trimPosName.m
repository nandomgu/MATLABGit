function final=trimPosName(posStr)
%% this function removes the last 3 characters of a string, which correspond to the position indices.
final= posStr(1:end-3);
end