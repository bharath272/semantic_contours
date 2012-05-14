function newucm=reweight_ucm(ucm_or, bboxes, Ws)

ucmstren=squeeze(max(ucm_or,[],1));
thresh=0.02;
[r_ind,c_ind]=find(ucmstren>=thresh);
linind=sub2ind([size(ucm_or,2) size(ucm_or,3)], r_ind, c_ind);
origvals=ucm_or(:,linind);

newvals=reweight_sparse(bboxes, Ws, origvals, r_ind, c_ind);
newucm=ucm_or;
newucm(:,linind)=newvals;
newucm=squeeze(max(newucm,[],1));


