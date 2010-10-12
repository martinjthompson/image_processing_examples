sobelx=[1 2 1; 0 0 0; -1 -2 -1];
ix=filter2(sobelx ,i);
iy=filter2(sobelx',i);
ix2=ix.*ix;
ixy=ix.*iy;
iy2=iy.*iy;
c=(ix2+iy2)-sqrt(4*ixy.*ixy + (ix2-iy2).^2);
 