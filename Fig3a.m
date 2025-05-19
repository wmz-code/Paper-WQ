clc;close all;clear all
quality={"hardness","water","protein","gluten","sedimentation","stability","stretch","resistance"};
co126=load('/data/Others/co2_ssp126_annual.txt');
co370=load('/data/Others/co2_ssp370_annual.txt');
co585=load('/data/Others/co2_ssp585_annual.txt');

for ii=1:30
    co_1(ii)=co126(6+ii,2)-410; %CO2 for 2019 year
    co_2(ii)=co370(6+ii,2)-410;
    co_3(ii)=co585(6+ii,2)-410;
end

clf
set(gcf,'position',[1454 455 833 564]);
set(gcf,'position',[966.3 133 919 580.67]);
for jj=1:8 
    name=char(quality{jj});
    for mm=1:5 

        path1=strcat(['/data/Projection/pre_ssp126cn_bayesrandom_nonlinear_gcm',num2str(mm),'.xlsx']);
        path3=strcat(['/data/Projection/pre_ssp370cn_bayesrandom_nonlinear_gcm',num2str(mm),'.xlsx']);
        path5=strcat(['/data/Projection/pre_ssp585cn_bayesrandom_nonlinear_gcm',num2str(mm),'.xlsx']);

        ssp126=xlsread(path1,name);
        ssp126=ssp126(:,4:33);
        ssp370=xlsread(path3,name);
        ssp370=ssp370(:,4:33);
        ssp585=xlsread(path5,name);
        ssp585=ssp585(:,4:33);

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

    if jj==3 % CO2 constraint
        s126=allmean126-0.0375.*co_1;  
        s370=allmean370-0.0375.*co_2;
        s585=allmean585-0.0375.*co_3;
    end
  
    edgecolor1=[0,0,0];
    edgecolor2=[0,0,0]; 
    edgecolor3=[0,0,0];

    fillcolor1=[44, 161, 194]/255;
    fillcolor2=[178, 225, 183]/255;
    fillcolor3=[255, 250, 239]/255;
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

    hold on
    scatter(position_1(jj),m1(jj),15,'o','MarkerEdgeColor','k');
    hold on
    scatter(position_2(jj),m2(jj),15,'o','MarkerEdgeColor','k');
    hold on
    scatter(position_3(jj),m3(jj),15,'o','MarkerEdgeColor','k');

    set(gca,'xlim',[0.5,8.5],'xcolor','k','ycolor','k','LineWidth',1);
    set(gca,'xtick',[1:8]);

    tlabels={'Hardness index','Water absorption','Crude protein content','Wet gluten content','Sedimentation index',...
    'Stability time','Stretch area','Maximum resistance'};
    set(gca,'xticklabels','');
    set(gca,'xticklabels',{tlabels{1:8}},'fontname','Arial','Fontsize',12);
    set(gca,'ylim',[-4,6],'ytick',[-4:2:6],'FontSize',12);
    ylabel('Projected Change (%)','FontSize',12);
    b=legend('SSP5-8.5','SSP3-7.0','SPP1-2.6','Location','northwest');
    b.FontSize=12;
    hold on
end

mm1=mean(mean(s126));
mm2=mean(mean(s370));
mm3=mean(mean(s585));
hold on
scatter([2.8 3 3.2],[mm1 mm2 mm3],50,"pentagram",'filled','MarkerFaceColor',[180/255 180/255 180/255],'MarkerEdgeColor','k');

print(gcf, '/results/fig3.png', '-dpng', '-r300');










