%%%%% FPtLabelRgb
%%%%% Get the points labeled in the RGB image plane.

function Pts_Rgb = FPtLabelRgb(labelmap)

[H,W,~] = size(labelmap);
[r,c] = find(labelmap);
Pts_Rgb = [r c];

ind_r = find(r>=1&r<=H);
ind_c = find(c>=1&c<=W);

ind = intersect(ind_r,ind_c);
Pts_Rgb = Pts_Rgb(ind,:);
