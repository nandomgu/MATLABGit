function final=trimPosNumbers(posStr)
%% this function keeps the last 3 characters of a string ,which correspond to the position indices,and discards the others, which correspond to position names.
if posStr(end-2)=='0'
final= str2double(posStr((end-2):end));
else
    final = sscanf(posStr, ['pos' '%d'])
end