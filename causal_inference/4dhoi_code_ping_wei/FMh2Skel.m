function skelPts = FMh2Skel(MhPts,Q,center)

tt = [MhPts(:,1)-center(1) MhPts(:,2)-center(2) MhPts(:,3)-center(3)]*inv(Q);
skelPts = [tt(:,1)+center(1) tt(:,2)+center(2) tt(:,3)+center(3)];