function PtsFlip = FFlipPts(Pts)

    ijd = Fskls2deps(Pts);
    ijd(:,2) = 321-ijd(:,2);
    ijd(:,1) =ijd(:,1)/240;
    ijd(:,2) =ijd(:,2)/320;
    PtsFlip = Fdeps2skls(ijd);