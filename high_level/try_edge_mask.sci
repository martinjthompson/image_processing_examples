// Copyright 2010 Martin Thompson (martin@parallelpoints.com). All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without modification, are
// permitted provided that the following conditions are met:
// 
//    1. Redistributions of source code must retain the above copyright notice, this list of
//       conditions and the following disclaimer.
// 
//    2. Redistributions in binary form must reproduce the above copyright notice, this list
//       of conditions and the following disclaimer in the documentation and/or other materials
//       provided with the distribution.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
// BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN 
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE

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
