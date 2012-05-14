function hog=compute_hog(img)
detection_config;
hog=compute_hog_internal(img);
hog=single(permute(hog, [3 1 2]));

