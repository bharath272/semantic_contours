
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% detection_config: Initializes various constants
%%%
%%% Copyright (C) 2009, Lubomir Bourdev and Jitendra Malik.
%%% This code is distributed with a non-commercial research license.
%%% Please see the license file license.txt included in the source directory.
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global config;

config.OBJECT_TYPE='person';

% Feature parameters (set according to the paper N.Dalal and B.Triggs, "Histograms of Oriented Gradients
% for Human Detection" CVPR 2005)
config.HOG_CELL_DIMS = [16 16 180];
config.NUM_HOG_BINS = [2 2 9];
config.SKIN_CELL_DIMS = [2 2];
config.HOG_WTSCALE = 2;
config.HOG_NORM_EPS = 1;
config.HOG_NORM_EPS2 = 0.01;
config.HOG_NORM_MAXVAL = 0.2;
config.GRAYSCALE_HOG = false;
config.USE_BOOST=false;
config.HOG_NO_GAUSSIAN_WEIGHT=true;
config.COMPRESS_HOG=false;
% Scanning parameters
config.PYRAMID_SCALE_RATIO = 1.1;
config.DETECTION_IMG_MIN_NUM_PIX = 1000^2;  % if the number of pixels in a detection image is < DETECTION_IMG_SIDE^2, scales up the image to meet that threshold
config.DETECTION_IMG_MAX_NUM_PIX = 1500^2;  
config.PATCH_DIMS = [96 64];
config.DENSE_DETECTION = false;
config.DETECT_SVM_THRESH = 0; % higher = more more precision, less recall
config.DETECTION_ANGLES = 0;%-45:15:45;   % What angles to scan over
config.MAX_AGGLOMERATIVE_CLUSTER_ELEMS = 500;
config.DETECT_MAX_HITS_PER_SCALE_PER_POSELET = inf; 
config.HYP_CLUSTER_THRESH = 5; %400;    % KL-distance between poselet hits to be considered in the same cluster. Used for personalized clustering of big Qs
if ~isfield(config,'GREEDY_CLUSTER_THRESH')
    config.GREEDY_CLUSTER_THRESH = 1; %400;    % KL-distance between poselet hits to be considered in the same cluster. Used in greedy clustering
end
config.HYP_CLUSTER_MAXNUM = 100;     % Max number of clusters in an image


config.TORSO_ASPECT_RATIO = 1.5;    % height/width of torsos
config.CLUSTER_HITS_CUTOFF=0.6; % clustering threshold for bounds hypotheses

config.HYPOTHESIS_PRIOR_VAR = 1;                % value of prior on the variance of keypoint distribution
config.HYPOTHESIS_PRIOR_VARIANCE_WEIGHT = 1;    % weight of prior on the variance of keypoint distribution

config.DEBUG=0;  % debug and verbosity level
config.USE_PHOG=false;
config.USE_MEX_HOG=true;
config.USE_MEX_MEANSHIFT=true;
config.USE_MEX_RESIZE=true;
config.KL_USE_WEIGHTED_DISTANCE = false;
config.CLUSTER_BOUNDS_DIST_TYPE=0;

global K;
K.L_Shoulder = 1;
K.R_Shoulder = 4;
K.L_Hip      = 7;
K.R_Hip      = 10;



K.AreaNames = { 'Occluder', 'Face', 'Hair', 'UpperClothes', 'LeftArm', 'RightArm', ...
    'LowerClothes','LeftLeg','RightLeg','LeftShoe','RightShoe','Neck','Bag','Hat',...
    'LeftGlove','RightGlove','LeftSock','RightSock','Sunglasses','Dress','BadSegment' };
K.A_Occluder     = 1;
K.A_Face         = 2;
K.A_Hair         = 3;
K.A_UpperClothes = 4;
K.A_LeftArm      = 5;
K.A_RightArm     = 6;
K.A_LowerClothes = 7;
K.A_LeftLeg      = 8;
K.A_RightLeg     = 9;
K.A_LeftShoe     = 10;
K.A_RightShoe    = 11;
K.A_Neck         = 12;
K.A_Bag          = 13;
K.A_Hat          = 14;
K.A_LeftGlove    = 15;
K.A_RightGlove   = 16;
K.A_LeftSock     = 17;
K.A_RightSock    = 18;
K.A_Sunglasses   = 19;
K.A_Dress        = 20;
K.A_BadSegment   = 21;
