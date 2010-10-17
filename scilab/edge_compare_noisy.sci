filename1='testkb_noisy';
img=imread(sprintf('../%s.pgm', filename1));
img=double(img); // convert to double so we can do non-integer maths
// Sobel
hs=[1 2 1; 0 0 0 ; -1 -2 -1];
edge=try_edge_mask(img, hs, filename1+'_sobel');
// or really simple
hs=[1 -1];vs=hs';
edge=try_edge_mask(img, hs, filename1+'_simple');
