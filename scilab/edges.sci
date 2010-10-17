filename='testkb';
img=imread(sprintf('../%s.pgm', filename));
img=double(img); // convert to double so we can do non-integer maths
// Smooth the image
F=fspecial('gaussian',7,1);
img=filter2(F,img);

// setup the kernels
// Sobel
hs=[1 2 1; 0 0 0 ; -1 -2 -1];
// or really simple
//hs=[1 -1];
vs=hs';

vedge=filter2(vs,img);
hedge=filter2(hs,img);
// normalise to range [0,1.0]
vedge=vedge./max(vedge(:));
hedge=hedge./max(hedge(:));
imwrite(vedge, sprintf('%s_vertical.png', filename));
imwrite(hedge, sprintf('%s_horizontal.png', filename));

// calculate magntude of edges
edge=vedge.^2+hedge.^2;

edge=edge./ max(edge(:));
imwrite(edge, sprintf('%s_edge.png', filename));

imshow(edge);