%%%%% draw points on the RGB image
function DrawImg = FDrawPointRGB(Pts,Img,Sz,Clr)

if nargin < 3 
    Sz = 1;
    Clr = [255 0 0];
end
if nargin < 4 
    Clr = [255 0 0];
end

[R,C,Ch] = size(Img);
DrawImg = Img;
Pts = floor(Pts);

if Ch == 1
    for i = 1:size(Pts,1)
        minR = max(1,Pts(i,1)-Sz);
        maxR = min(R,Pts(i,1)+Sz);
        minC = max(1,Pts(i,2)-Sz);
        maxC = min(C,Pts(i,2)+Sz);
        DrawImg(minR:maxR,minC:maxC) = Clr(1);
    end
elseif Ch == 3
    for i = 1:size(Pts,1)
        minR = max(1,Pts(i,1)-Sz);
        maxR = min(R,Pts(i,1)+Sz);
        minC = max(1,Pts(i,2)-Sz);
        maxC = min(C,Pts(i,2)+Sz);
        DrawImg(minR:maxR,minC:maxC,1) = Clr(1);
        DrawImg(minR:maxR,minC:maxC,2) = Clr(2);
        DrawImg(minR:maxR,minC:maxC,3) = Clr(3);
    end
end