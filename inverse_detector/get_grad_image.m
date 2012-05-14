function imgs=get_grad_image

tmp=zeros(8,8);
tmp(1:7,4)=1;
for k=1:9
	imgs{k}=rotate2(tmp,(pi/9*(k-1)));
end

