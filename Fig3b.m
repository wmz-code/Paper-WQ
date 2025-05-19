clc;close all;clear all
% plot for fig3b-g
model={'Linear','Nonlinear'};
emodel={'linear','nonlinear'};
cli={'tas','tmax','tmin'};
years={'allyears','former7years','later7years'};
quality={"hardness","water","protein","gluten","sedimentation","stability","stretch","resistance"};
aa=[-8 4;
    -4 2;
    -8 4;
    -16 8;
    -16 8;
    -40 20;
    -40 20;
    -28 14];
gap=[-8:2:4;-4:1:2;-8:2:4;-16:4:8;-16:4:8;-40:10:20;-40:10:20;-28:7:14];
labels={'Change in hardness index (%)','Change in water absorption (%)','Change in crude protein content (%)','Change in wet gluten content (%)','Change in sedimentation index (%)',...
    'Change in stability time (%)','Change in stretch area (%)','Change in maximum resistance (%)'};
toplabel={'a','b','c','d','e','f','g','h'};
pos=[0.02 0.6 0.3 0.3;0.35 0.6 0.3 0.3;0.68 0.6 0.3 0.3;0.02 0.1 0.3 0.3;0.35 0.1 0.3 0.3;0.68 0.1 0.3 0.3];
t = tiledlayout(2, 4, 'TileSpacing', 'Compact', 'Padding', 'Compact');
set(gcf,'position',[518 267 1739 979]);
        color_up=[255 255 255]/255;
%         color_low=[55/255 118/255 52/255;89/255 120/255 164/255;246/255 175/255 105/255];
%         color_mid=[121/255 177/255 122/255;135/255 160/255 190/255;254/255 207/255 157/255];
        color_low=[55/255 118/255 52/255;89/255 120/255 164/255;253/255 217/255 118/255];
        color_mid=[121/255 177/255 122/255;135/255 160/255 190/255;255/255 253/255 174/255];
uplim=1000;lowlim=0;
load('/data/Projection/all585.mat'); 
condition_names = {'BWk', 'BSk', 'Cwa', 'Cwb','Cfa','Dwa','Dwb','Dwc'};
% plot for projection of 135 models under ssp585
for mm=2 % nonlinear model
    for qq=1:8 % quality indicators
        alldata=[];
        for tt=1:3 %tem
            for yy=1:3 % period
                for pp=1:3 % phenological stages
                    path=strcat(['/data/RobustnessCheck/',model{mm},'/',cli{tt},'/',years{yy},'/P585_',emodel{mm},'_random_phe',num2str(pp),'_d.xlsx']);
                    name=quality{qq};
                    data=xlsread(path,name);
                    data=data.*100;
                    data=data';
                    alldata=cat(2,alldata,data);
                end
            end
        end
        nexttile;
        meand=mean(mean(alldata));
        stdd=std(mean(alldata));
        m1(qq)=meand;
        boxplot(alldata,'notch','off','symbol','','colors',[160/255 160/255 160/255]);
        hold on
        plot([0,135],[meand meand],'--','Color',color_low(2,:),'LineWidth',1.5);
        hold on
        boxplot(alldata(:,1),'notch','off','symbol','','colors','r');
        hold on
        col=interp1([lowlim (lowlim+uplim)/2 uplim],[color_low(2,:);color_mid(2,:);color_up],[lowlim:1:uplim]);
        colormap(col)
        a1=meand-stdd;
        a2=meand+stdd;
        x=[0;0;0;136;136;136];
        y=[a1;meand;a2;a2;meand;a1];
        C=[1000 50 1000 1000 50 1000];
        patch(x,y,C,'FaceAlpha',.5,'EdgeColor',[255 255 255]/255);
        set(gca,'xlim',[0,136],'xtick',[1:5:135],'XTickLabel','');
        set(gca,'ylim',aa(qq,:),'ytick',gap(qq,:),'FontSize',12,'xcolor','k','ycolor','k','LineWidth',1);
        ylabel([labels{qq}],'FontSize',12);
        text(-20,aa(qq,2),toplabel{qq},'FontSize',12,'FontWeight','bold');
    end
end

print(gcf, '/results/fig5b.png', '-dpng', '-r300');

clf
% violin plot for each climate zone
aa=[-4 20;
    -2 10;
    -5 25;
    -10 50;
    -20 100;
    -30 150;
    -30 150;
    -30 150];
gap=[-4:4:20;-2:2:10;-5:5:25;-10:10:50;-20:20:100;-30:30:150;-30:30:150;-30:30:150];
set(gcf,'position',[518 267 1739 979]); 
t = tiledlayout(2, 4, 'TileSpacing', 'Compact', 'Padding', 'Compact');

% c =  [188/255 216/255 189/255;188/255 216/255 189/255;
%     202/255 213/255 226/255;202/255 213/255 226/255;
%     254/255 207/255 157/255;254/255 207/255 157/255;254/255 207/255 157/255;254/255 207/255 157/255]; 

% c =  [196/255 223/255 180/255;196/255 223/255 180/255;
%     135/255 160/255 190/255;135/255 160/255 190/255;
%     246/255 175/255 105/255;246/255 175/255 105/255;246/255 175/255 105/255;246/255 175/255 105/255]; 

c =  [196/255 223/255 180/255;196/255 223/255 180/255;
    135/255 160/255 190/255;135/255 160/255 190/255;
    255/255 253/255 174/255;255/255 253/255 174/255;255/255 253/255 174/255;255/255 253/255 174/255]; 

xxx=[1 5 2 4 3 6 7 8];

for jj=1:8
    qq=xxx(jj);  
    nexttile;
    vio=all585(:,:,qq);
    vio=vio';
    meanv(jj,:)=mean(vio);
    h = daviolinplot(vio,...
        'xtlabels', condition_names,'violin','full','colors',c(jj,:),...
        'boxcolors','w','outliers',0,'boxalpha',0.9);
    set(gca,'ylim',aa(jj,:),'ytick',gap(jj,:),'FontSize',12,'xcolor','k','ycolor','k','LineWidth',1);
    ylabel([labels{jj}],'FontSize',12);
    set(gca,'xlim',[0.5,8.5])
end

print(gcf, '/results/fig3b_violin.png', '-dpng', '-r300');


