function ProPts = FRemoveNoisePts(RawPts)

%avg = median(RawPts(:,3));
avg = median(RawPts(:,3));
ProPts = [];
m= 0;
for i = 1:size(RawPts,1)
    if abs(RawPts(i,3)-avg)<=  0.6
        m = m + 1;
        ProPts(m,:) = RawPts(i,:);
    end
end

%%% make a call
% for i = 1:size(RawPts,1)
%     if (abs(RawPts(i,3)) >=  0.01)
%         m = m + 1;
%         ProPts(m,:) = RawPts(i,:);
%     end
% end
% RawPts = ProPts;
% ProPts = [];
% m = 0;
% avg = mean(RawPts(:,3));
% for i = 1:size(RawPts,1)
%         if abs(RawPts(i,3)-avg)<=  0.04
%             m = m + 1;
%            ProPts(m,:) = RawPts(i,:);
%         end
% end

