function [ ] = compareSpectrograms( spec1, spec2, title1,title2,customAxes,T,F)
%COMPARESPECTROGRAMS Plot and compare two spectrograms
% spec1,spec2 - The two spectrograms to be compared
% title1,title2 - The titles for the spectrograms
% customAxes - Specify bounds for axes if required. 
% [T_min, T_max, F_min, F_max]
% T - Labels for time on X axis
% F - Labels for frequency on Y axis
%
% Aneesh Vartakavi

figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1);
imagesc(T,F,spec1);
if(isempty(customAxes))
    axis([T(1) T(end) F(1) F(end)]);
else
    ind1 = find(T>=customAxes(1),1,'first');
    ind2 = find(T>=customAxes(2),1,'first');
    axis([T(ind1) T(ind2) F(1) F(end)]);
end
axis('xy');
set(gca,'FontSize',16);
title(title1);
xlabel('Time in seconds');
ylabel('Frequency in Hz');
colormap(hot);

subplot(1,2,2);
imagesc(T,F,spec2);
if(isempty(customAxes))
    axis([T(1) T(end) F(1) F(end)]);
else
    ind1 = find(T>=customAxes(1),1,'first');
    ind2 = find(T>=customAxes(2),1,'first');
    axis([T(ind1) T(ind2) F(1) F(end)]);
end
axis('xy');
set(gca,'FontSize',16);
title(title2);
xlabel('Time in seconds');
ylabel('Frequency in Hz');
colormap(hot);
end

