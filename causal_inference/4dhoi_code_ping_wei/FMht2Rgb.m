function RgbPt = FMht2Rgb(MhtPt,MhtPara,mrgbd)

pt_skel = FMh2Skel(MhtPt,MhtPara.Q,MhtPara.Ct); %%% box center in skeleton sapce
pt_skel = FFlipPts(pt_skel);
ijd = Fskls2deps(pt_skel);          %%% window center on depth
RgbPt = FdepthINrgb(ijd, mrgbd);    %%% window center on rgb