%%%%% pts_in_rgb: N*2 vector, points location in rgb image
%%%%% maprgbd: map from depth image to rgb image
%%%%% pts_in_depth: N*2 vector, points location in depth image

function pts_in_rgb = FdepthINrgb(pts_in_depth, maprgbd)

N = size(pts_in_depth,1);
pts_in_rgb = zeros(N,2);

for n = 1:N
    if (pts_in_depth(n,1)>=1)&&(pts_in_depth(n,1)<=240)&&(pts_in_depth(n,2)>=1)&&(pts_in_depth(n,2)<=320)
        pts_in_rgb(n,1) = maprgbd(pts_in_depth(n,1),pts_in_depth(n,2),2)+1;
        pts_in_rgb(n,2) = maprgbd(pts_in_depth(n,1),pts_in_depth(n,2),3)+1;
        if pts_in_rgb(n,1) > 480
            pts_in_rgb(n,1) = 480;
        end
        if pts_in_rgb(n,2) > 640
            pts_in_rgb(n,2) = 640;
        end
    end    
end