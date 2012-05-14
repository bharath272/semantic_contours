function hog=compute_hog(grad_mag, grad_ori)
detection_config;
hog=compute_hog_internal_grad(grad_mag, grad_ori);
hog=single(permute(hog, [3 1 2]));

