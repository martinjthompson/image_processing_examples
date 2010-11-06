function cornerness=shi_tomasi(img)
sobelx=[1 2 1; 0 0 0; -1 -2 -1];
Ix=filter2(sobelx ,img);
Iy=filter2(sobelx',img);
Ix2=Ix.*Ix;
Ixy=Ix.*Iy;
Iy2=Iy.*Iy;

window_size=1; % increase this for a bugger smoothing window
window_range=-window_size:window_size;
mask=ones(length(window_range));
a=filter2(mask, Ix2);
b=filter2(mask, Iy2);
c=filter2(mask, Ixy);

c1=(a+b);
c2=(4*(c.*c) + ((a-b).^2)).^0.5;
cornerness=c1-c2;
