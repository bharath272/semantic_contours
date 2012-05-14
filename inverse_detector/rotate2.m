function newimg=rotate(img, theta)
sz=size(img);
center=sz/2;
tplus=maketform('affine', [1 0 0; 0 1 0; -center(1) -center(2) 1]);
rot=maketform('affine', [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1]);
tminus=maketform('affine', [1 0 0; 0 1 0; center(1) center(2) 1]);
T=maketform('composite',tminus, rot, tplus);
newimg=imtransform(img, T, 'XData', [1 sz(2)], 'YData', [1 sz(1)]);


