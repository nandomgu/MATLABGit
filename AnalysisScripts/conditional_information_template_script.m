% Conditional Information
confM = eye(4)/4;
confM = [0.25,0,0,0;repmat([0,0.25,0,0],3,1)];
%confM = reshape(1:16,4,4);

p_X = sum(confM,2);
p_Y = sum(confM,1);
p_Y_x = confM./p_X(:,ones(size(confM,2),1));
if any(p_Y_x(:)==0)
    small_num = min(p_Y_x(p_Y_x(:)~=0))*10^-8;
    p_Y_x = p_Y_x + small_num;
    p_Y = p_Y + small_num;
end
cond_info = sum(p_Y_x.*log2(p_Y_x) - ...
    p_Y_x.*log2(p_Y(ones(size(confM,1),1),:)),2);