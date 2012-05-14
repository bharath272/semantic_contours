%Function to get W for a single svm
function W = get_hog_greedy(w, svm_dims, hog_handle, hog_params)
global config;
if(nargin<4)
    hog_params.nori=9;
    hog_params.cell_sz=8;
    
end

W=zeros([uint16(svm_dims./hog_params.cell_sz) hog_params.nori]);
for i=1:size(W,1)
    for j=1:size(W,2)
        for o=1:size(W,3)
            
            %Create an image with a line in a given orientation in a given cell
           	img=get_grad_image(i, j, o, svm_dims, hog_params);
            
            %compute its hog features
            hog=feval(hog_handle, img);
            feat = hog(:)';
            W(i,j,o)=W(i,j,o)+feat*w;
        end
    end
end
W=permute(W, [3 1 2]);

function img=get_grad_image(blockr, blockc, ori_bin, dims, hog_params)
s=hog_params.cell_sz;
tmp=zeros(s,s);
tmp(1:s-1,ceil(s/2))=1;
tmp1=rotate2(tmp,(pi/(hog_params.nori)*(ori_bin-1)));
tmp=tmp1;
img=zeros(dims+2);
ipos=2+(blockr-1)*hog_params.cell_sz;
jpos=2+(blockc-1)*hog_params.cell_sz;
img(ipos:ipos+hog_params.cell_sz-1, jpos:jpos+hog_params.cell_sz-1) = tmp;


