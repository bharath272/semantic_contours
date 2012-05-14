function newvals=reweight_sparse(bboxes, Ws, origvals, r_ind, c_ind)

%% newvals = reweight_sparse(bboxes, Ws, origvals, r_ind, c_ind)
%% Reweights a sparse signal using weights in Ws
%% bboxes is an array where every row is ofthe form [xmin ymin xmax ymax score detector_id]
%% Ws is a cell array containing the inverse detectors for each detector. Ws{detector_id} is an numori X numrows X numcols array.
%% origvals, r_ind and c_ind define the list of pixels to be reweighted. r_ind and c_ind are row and column indices resectively.
%% origvals is a numori X numpixels array containing the original values.


newvals=zeros(size(origvals));


%for each hit do
for k=1:size(bboxes,1)

        %pick the W of the poselet
        detector_id=bboxes(k,end);
        W=Ws{detector_id};

        %Divide the detection window into bins along x and y
        t_i=linspace(bboxes(k,2)-1, bboxes(k,4),size(W,2)+1);
        t_j=linspace(bboxes(k,1)-1, bboxes(k,3),size(W,3)+1);
        
        %bin the pixels
        [ni, bini]=histc(r_ind,t_i);
        [nj, binj]=histc(c_ind,t_j);
		bini(r_ind==bboxes(k,2)-1)=0;
		binj(c_ind==bboxes(k,1)-1)=0;
		bini(bini==size(W,2)+1)=size(W,2);
		binj(binj==size(W,3)+1)=size(W,3);
        
		%find the pixels that lie inside the window
        ind = find(bini>=1 & bini<=size(W,2) & binj>=1 & binj<=size(W,3));
        
		%get the right weights
        wtsind=sub2ind([size(W,2) size(W,3)], bini(ind), binj(ind));
        
		%multiply by appropriate weights and add
        newvals(:, ind) = newvals(:, ind)+origvals(:, ind).*W(:, wtsind).*bboxes(k, end-1);
end
 
