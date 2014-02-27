%%%%%% FMultiMedfilter
%%%%%% smooth an image with median filter multi-times.

function Img_smooth = FMultiMedfilter(Img,Tn,sz)

Img_dbl = double(Img);

Img_smooth = medfilt2(Img_dbl, sz);
for i = 1:(Tn-1)
    Img_smooth = medfilt2(Img_smooth, sz);
end

