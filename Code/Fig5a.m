clc;close all;clear all
quality={"hardness","protein","sedimentation","gluten","water","stability","stretch","resistance"};

clf
set(gcf,'position',[1454 455 833 564]);
for jj=1:8 
    name=char(quality{jj});
    for mm=1:5 

        path1=strcat(['D:\Home\Data\Fig5a\pred_ssp126cn_nonlinear_gcm',num2str(mm),'.xlsx']);
        path3=strcat(['D:\Home\Data\Fig5a\pred_ssp370cn_nonlinear_gcm',num2str(mm),'.xlsx']);
        path5=strcat(['D:\Home\Data\Fig5a\pred_ssp585cn_nonlinear_gcm',num2str(mm),'.xlsx']);

        ssp126=xlsread(path1,name);
        ssp126=ssp126(:,4:end);
        ssp370=xlsread(path3,name);
        ssp370=ssp370(:,4:end);
        ssp585=xlsread(path5,name);
        ssp585=ssp585(:,4:end);

        ssp126(isnan(ssp126))=0;
        ssp370(isnan(ssp370))=0;
        ssp585(isnan(ssp585))=0;

        ssp126mm(:,:,mm)=ssp126.*100; 
        ssp370mm(:,:,mm)=ssp370.*100;
        ssp585mm(:,:,mm)=ssp585.*100;
       
    end

    allmean126=mean(ssp126mm,3);
    allmean370=mean(ssp370mm,3);
    allmean585=mean(ssp585mm,3);

    ally1=mean(allmean126(:,1:30));
    ally2=mean(allmean370(:,1:30));
    ally3=mean(allmean585(:,1:30));

    m1(jj)=mean(ally1);
    m2(jj)=mean(ally2);
    m3(jj)=mean(ally3);

    edgecolor1=[0,0,0];
    edgecolor2=[0,0,0]; 
    edgecolor3=[0,0,0];

    fillcolor1=[44, 161, 194]/255;
    fillcolor2=[178, 225, 183]/255;
    fillcolor3=[244,79,57]/255;
    fillcolors=[fillcolor3;fillcolor2;fillcolor1];

    position_1 = [0.8:1:7.8]; 
    position_2 = [1:1:8];      
    position_3 = [1.2:1:9.2];  

    cmap=[159/255 24/255 30/255;242/255 108/255 70/255; ...
        5/255 100/255 96/255;44/255 141/255 133/255;165/255 218/255 100/255;68/255 0/255 122/255; ...
        115/255 98/255 179/255;135/255 132/255 186/255];
 
    sz=10;
    tm=1;
    tm2=1;

    box_1 = boxplot(ally1,'positions',position_1(jj),'colors',edgecolor1,'width',0.2,'notch','off','symbol','');
    hold on;
    box_2 = boxplot(ally2,'positions',position_2(jj),'colors',edgecolor2,'width',0.2,'notch','off','symbol','');
    hold on;
    box_3 = boxplot(ally3,'positions',position_3(jj),'colors',edgecolor3,'width',0.2,'notch','off','symbol','');

    boxobj = findobj(gca,'Tag','Box');

    for j=1:3
        patch(get(boxobj(j),'XData'),get(boxobj(j),'YData'),fillcolors(j,:),'FaceAlpha',0.7);
    end

    set(gca,'xlim',[0.5,8.5],'xcolor','k','ycolor','k','LineWidth',1);
    set(gca,'xtick',[1:8]);

    tlabels={'Hardness index','Crude protein content','Sedimentation index','Wet gluten content','Water absorption',...
    'Stability time','Stretch area','Maximum resistance'};
    set(gca,'xticklabels','');
    set(gca,'xticklabels',{tlabels{1:8}},'fontname','Arial','Fontsize',12);
    set(gca,'ylim',[-2,8],'ytick',[-2:1:8],'FontSize',12);
    ylabel('Projected Change (%)','FontSize',12);
    b=legend('SPP1-2.6','SSP3-7.0','SSP5-8.5','Location','northwest');
    b.FontSize=12;
    hold on

end

% print -dpdf -r600 -painters Figure











