function newimg=reweight_dense(bboxes, Ws, origimg)

%% newvals = reweight_sparse(bboxes, Ws, origimg)
%% Reweights a dense signal using weights in Ws
%% bboxes is an array where every row is ofthe form [xmin ymin xmax ymax score detector_id]
%% Ws is a cell array containing the inverse detectors for each detector. Ws{detector_id} is an numori X numrows X numcols array.
%% origimg is a nori X numrows X numcols image


newimg=zeros(size(origimg));

r_ind=1:size(origimg,2);
c_ind=1:size(origimg,3);




%for each hit do
for k=1:size(bboxes,1)

        %pick the W of the poselet
        detector_id=bboxes(k,end);
        W=Ws{detector_id};
		if(ndims(W)<3)
			W=reshape(W, [1 size(W)]);
		end

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
        indi = find(bini>=1 & bini<=size(W,2)); indj=find(binj>=1 & binj<=size(W,3));
        %multiply by appropriate weights and add
        newimg(:, r_ind(indi), c_ind(indj)) = newimg(:, r_ind(indi), c_ind(indj))+origimg(:, r_ind(indi), c_ind(indj)).*W(:, bini(indi), binj(indj)).*bboxes(k, end-1);
end
