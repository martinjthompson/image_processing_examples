function edge = try_edge_mask(img, mask, filename)
hs=mask;
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

endfunction
