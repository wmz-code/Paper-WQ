clc;close all;clear all
for mm=1:5
    tpath=strcat(['D:\Home\Data\Fig2\GCMs\gcm',num2str(mm),'_tas.xlsx']);
    ppath=strcat(['D:\Home\Data\Fig2\GCMs\gcm',num2str(mm),'_pr.xlsx']);
    Thist=xlsread(tpath,'hist');
    T126=xlsread(tpath,'ssp126');
    T370=xlsread(tpath,'ssp370');
    T585=xlsread(tpath,'ssp585');
    Thist=Thist(2:end,:);
    T126=T126(2:end,:);
    T370=T370(2:end,:);
    T585=T585(2:end,:);
    Tbase=mean(Thist,2);
    T126change=(T126-Tbase)./Tbase.*100;
    T370change=(T370-Tbase)./Tbase.*100;
    T585change=(T585-Tbase)./Tbase.*100;
    Tfinal126(mm,:)=mean(T126change);
    Tfinal370(mm,:)=mean(T370change);
    Tfinal585(mm,:)=mean(T585change);
    Phist=xlsread(ppath,'hist');
    P126=xlsread(ppath,'ssp126');
    P370=xlsread(ppath,'ssp370');
    P585=xlsread(ppath,'ssp585');
    Phist=Phist(2:end,:);
    P126=P126(2:end,:);
    P370=P370(2:end,:);
    P585=P585(2:end,:);
    Pbase=mean(Phist,2);
    P126change=(P126-Pbase)./Pbase.*100;
    P370change=(P370-Pbase)./Pbase.*100;
    P585change=(P585-Pbase)./Pbase.*100;
    Pfinal126(mm,:)=mean(P126change);
    Pfinal370(mm,:)=mean(P370change);
    Pfinal585(mm,:)=mean(P585change);
end

clf
subplot(1,2,1)
meanT126=mean(Tfinal126);
meanT370=mean(Tfinal370);
meanT585=mean(Tfinal585);
stdT126=std(Tfinal126);
stdT370=std(Tfinal370);
stdT585=std(Tfinal585);

meanT126=meanT126(1:30);
meanT370=meanT370(1:30);
meanT585=meanT585(1:30);
stdT126=stdT126(1:30);
stdT370=stdT370(1:30);
stdT585=stdT585(1:30);

x=[2021:2050];
y1=meanT126;
yu1=meanT126+stdT126;
yl1=meanT126-stdT126;
fill([x fliplr(x)], [yu1 fliplr(yl1)], [185/255 185/255 202/255], 'linestyle', 'none', 'FaceAlpha',0.5); hold on
hold all
plot(x,y1,'color',[27/255 59/255 110/255],'LineWidth',1.5);
hold on
y2=meanT370;
yu2=meanT370+stdT370;
yl2=meanT370-stdT370;
fill([x fliplr(x)], [yu2 fliplr(yl2)],[152/255,215/255,185/255], 'linestyle', 'none', 'FaceAlpha',0.5); hold on
hold all
plot(x,y2,'color',[91/255,178/255,169/255],'LineWidth',1.5);
hold on
y3=meanT585;
yu3=meanT585+stdT585;
yl3=meanT585-stdT585;
fill([x fliplr(x)], [yu3 fliplr(yl3)], [242/255 109/255 68/255], 'linestyle', 'none', 'FaceAlpha',0.2); hold on
hold all
plot(x,y3,'color',[242/255 109/255 68/255],'LineWidth',1.5);
set(gca,'ylim',[-14,28],'FontSize',10,'ytick',[-14:7:28],'FontSize',10);
ylabel('% Change in mean temperature');

subplot(1,2,2)
meanP126=mean(Pfinal126);
meanP370=mean(Pfinal370);
meanP585=mean(Pfinal585);
stdP126=std(Pfinal126);
stdP370=std(Pfinal370);
stdP585=std(Pfinal585);

meanP126=meanP126(1:30);
meanP370=meanP370(1:30);
meanP585=meanP585(1:30);
stdP126=stdP126(1:30);
stdP370=stdP370(1:30);
stdP585=stdP585(1:30);

x=[2021:2050];
y1=meanP126;
yu1=meanP126+stdP126;
yl1=meanP126-stdP126;
fill([x fliplr(x)], [yu1 fliplr(yl1)], [185/255 185/255 202/255], 'linestyle', 'none', 'FaceAlpha',0.5); hold on
hold all
plot(x,y1,'color',[27/255 59/255 110/255],'LineWidth',1.5);
hold on
y2=meanP370;
yu2=meanP370+stdP370;
yl2=meanP370-stdP370;
fill([x fliplr(x)], [yu2 fliplr(yl2)],[152/255,215/255,185/255], 'linestyle', 'none', 'FaceAlpha',0.5); hold on
hold all
plot(x,y2,'color',[91/255,178/255,169/255],'LineWidth',1.5);
hold on
y3=meanP585;
yu3=meanP585+stdP585;
yl3=meanP585-stdP585;
fill([x fliplr(x)], [yu3 fliplr(yl3)], [242/255 109/255 68/255], 'linestyle', 'none', 'FaceAlpha',0.2); hold on
hold all
plot(x,y3,'color',[242/255 109/255 68/255],'LineWidth',1.5);
ylabel('% Change in daily precipitation');
set(gca,'ylim',[-40,80],'ytick',[-40:20:80],'FontSize',10);
% legend('SSP1-2.6','SSP3-7.0','SSP5-8.5','SSP1-2.6','SSP3-7.0','SSP5-8.5','Location','northwest')
% print -dpdf -r600 -painters fig2


