function W = get_inverse_detector_grad(w, svm_dims, hog_grad_handle, hog_params)
%% function W = get_inverse_detector_grad(w, svm_dims, hog_grad_handle, hog_params)
%% computes the inverse detector by feeding in gradients in one orientation in one cell at a time
%% w is the svm weight vector without the bias terms
%% svm_dims is the size of the window (in pixels) used to compute the HOG feature vector.
%% hog_grad_handle is a function handle for a function that takes gradient magnitudes and orientations and
%% spitsoutahog feature vector.
%% hog_params is an optional parameter. It contains two fields: nori is the number of orientations and
%% cell_sz is the size of a hog cell.

if(nargin<4)
    hog_params.nori=9;
    hog_params.cell_sz=8;
    
end

W=zeros([uint16(svm_dims./hog_params.cell_sz) hog_params.nori]);
for i=1:size(W,1)
    for j=1:size(W,2)
        for o=1:size(W,3)
            
            %Create a gradient image with all 1s in a given cell and a
            %given orientation
            [grad_mag, grad_ori]=get_grad_image(i, j, o, svm_dims, hog_params);
            
            %compute its hog features
            hog=feval(hog_grad_handle, grad_mag, grad_ori);
			
            feat = hog(:)';
            W(i,j,o)=W(i,j,o)+feat*w;
        end
    end
end
W=permute(W, [3 1 2]);

function [grad_mag, grad_ori]=get_grad_image(blockr, blockc, ori_bin, dims, hog_params)
grad_mag=zeros(dims+2);
grad_ori=zeros(dims+2);
ipos=2+(blockr-1)*hog_params.cell_sz;
jpos=2+(blockc-1)*hog_params.cell_sz;
grad_mag(ipos:ipos+hog_params.cell_sz-1, jpos:jpos+hog_params.cell_sz-1) = 1;
grad_ori(ipos:ipos+hog_params.cell_sz-1,jpos:jpos+hog_params.cell_sz-1) = pi/(2*hog_params.nori) + pi/(hog_params.nori)*(ori_bin-1);
