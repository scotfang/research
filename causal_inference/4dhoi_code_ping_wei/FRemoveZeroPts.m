%%%%% FRemoveZeroPts

function RawPts = FRemoveZeroPts(RawPts)

absPts = abs(RawPts);
absSum = sum(absPts');
ind = find(absSum<0.1);
RawPts(ind,:) = [];
