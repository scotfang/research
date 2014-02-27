function MhtPt = FRgb2Mht(RgbPt,mrgbd,depth,MhtPara)

pts_depth = FrgbINdepth(RgbPt,mrgbd);
ijd = [pts_depth(:,1)./240,pts_depth(:,2)./320,double(diag(depth(pts_depth(:,1),pts_depth(:,2))))];
xyz = Fdeps2skls(ijd);
MhtPt = FManhattanPts(xyz,MhtPara.Q,MhtPara.Ct);