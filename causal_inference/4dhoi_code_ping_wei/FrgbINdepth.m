%%%%% find the correspoding coordinates in depth image of points in rbg
%%%%% image. the first column is the coordinates of the vertical direction
%%%%% pts_in_rgb: N*2 vector, points location in rgb image
%%%%% maprgbd: map from depth image to rgb image
%%%%% pts_in_depth: N*2 vector, points location in depth image. the first
%%%%% column is the coordinates of the vertical direction

function pts_in_depth = FrgbINdepth(pts_in_rgb, maprgbd)

N = size(pts_in_rgb,1);
%pts_in_depth = zeros(N,2);
search_range_x = 25;
search_range_y = 20;

m = 0;
for n = 1:5:N
    
   x =  floor(pts_in_rgb(n,2)/2);
   y =  floor(pts_in_rgb(n,1)/2);
   Xmin = max(1,(x-search_range_x ));
   Xmax = min(320,(x+search_range_x ));
   Ymin = max(1,(y-search_range_y));
   Ymax = min(240,(y+search_range_y));
   err = 10000;
   
   if Ymin <= Ymax & Xmin <= Xmax
       m = m + 1;
       for i = Ymin:Ymax
           for j = Xmin:Xmax
               mapx = double(maprgbd(i,j,3))+1;
               mapy = double(maprgbd(i,j,2))+1;
               ex = abs(pts_in_rgb(n,2)-mapx);
               ey = abs(pts_in_rgb(n,1)-mapy);
               sqe = sqrt(ex^2 + ey^2);
               if sqe< err
                   err = sqe;
                   pts_in_depth(m,2) = min((j+4),320);
                   pts_in_depth(m,1) = max((i-3),1);
               end
           end
       end
   end
    
end

% for n = 1:N
%     
%    x =  floor(pts_in_rgb(n,1)/2);
%    y =  floor(pts_in_rgb(n,2)/2);
%    Xmin = max(1,(x-search_range_x ));
%    Xmax = min(320,(x+search_range_x ));
%    Ymin = max(1,(y-search_range_y));
%    Ymax = min(240,(y+search_range_y));
%    err = 10000;
%    
%    for i = Ymin:Ymax
%        for j = Xmin:Xmax
%           mapx = double(maprgbd(i,j,2))+1;
%           mapy = double(maprgbd(i,j,3))+1;         
%           ex = abs(pts_in_rgb(n,1)-mapx);
%           ey = abs(pts_in_rgb(n,2)-mapy);
%           sqe = sqrt(ex^2 + ey^2);
%           if sqe< err
%              err = sqe;
%              pts_in_depth(n,1) = min((i+4),320);
%              pts_in_depth(n,2) = max((j-3),1);
%           end
%        end
%    end
%     
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Note: maprgbd(:,:,2): the coordinates of the vertical direction, i.e.
%%%%% row number; maprgbd(:,:,3): the coordinates of the horizontal direction, i.e.
%%%%% the column number