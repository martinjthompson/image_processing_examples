sobelx=[1 2 1; 0 0 0; -1 -2 -1];
 
ix=conv2(i,sobelx,'same');
                          !--error 4 
Undefined variable: conv2

 
 
help conv
 
ix=imconv(i,sobelx,'same');
                           !--error 4 
Undefined variable: imconv

 
 
ix=filter2(sobelx,i,);
                      !--error 77 
filter2: Wrong number of input argument(s): 2 expected.
 
 
ix=filter2(sobelx,i);
 
iy=filter2(sobelx',i);
 
ix2=ix.*ix;
 
ixy=ix.*iy;
 
iy2=iy.*iy;
 
c=(ix2+iy2)-sqrt(4*ixy.*ixy + (ix2-iy2).^2);
 