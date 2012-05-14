%% Initialize: add all paths, load all data
fprintf('Adding paths..\n');
addpath(genpath(pwd));
fprintf('Loading data\n');
load ucm.mat
load detections.mat
load model.mat
img=imread('img.jpg');

%% Compute inverse detector
fprintf('Computing inverse detector: method 1..\n');
W_grad=get_inverse_detector_grad(w, dims, @compute_hog_grad);
fprintf('Computing inverse detector: method 2..\n');
W_img=get_inverse_detector_img(w, dims, @compute_hog);

%% Reweight
fprintf('Reweighting..\n');
Ws{1}=W_grad;
newucm_grad=reweight_ucm(ucm_or, bboxes, Ws);
Ws{1}=W_img;
newucm_img=reweight_ucm(ucm_or, bboxes, Ws);

%% Display
figure;
imshow(img); pause;
imshow(squeeze(max(ucm_or,[],1))); pause;
imshow(newucm_grad); pause;
imshow(newucm_img);
