clc;close all;clear all
model={'Linear','Nonlinear'};
emodel={'linear','nonlinear'};
cli={'tas','tmax','tmin'};
years={'所有年','前7年','后7年'};
quality={"hardness","protein","sedimentation","gluten","water","stability","stretch","resistance"};
aa=[-5 5;
    -5 5;
    -9 9;
    -7 7;
    -3 3;
    -30 30;
    -20 20;
    -20 20;];
gap=[-5:2.5:5;-5:2.5:5;-9:4.5:9;-7:3.5:7;-3:1.5:3;-30:15:30;-20:10:20;-20:10:20];
labels={'Change in hardness index (%)','Change in crude protein content (%)','Change in sedimentation index (%)','Change in wet gluten content (%)','Change in water absorption (%)',...
    'Change in stability time (%)','Change in stretch area (%)','Change in maximum resistance (%)'};
toplabel={'a','b','c','d','e','f','g','h'};
set(gcf,'position',[497 522.3 1964 815.7]); 
pos=[0.02 0.6 0.3 0.3;0.35 0.6 0.3 0.3;0.68 0.6 0.3 0.3;0.02 0.1 0.3 0.3;0.35 0.1 0.3 0.3;0.68 0.1 0.3 0.3];
for mm=2 %model
    for qq=1:8 %indicators
        alldata=[];
        for tt=1:3 %tem
            for yy=1:3 %period
                for pp=1:3 %stages
                    path=strcat(['D:\Home\Data\Fig5\Robust Checkness\',model{mm},'\',cli{tt},'\',years{yy},'\P585_',emodel{mm},'_phe',num2str(pp),'_d.xlsx']);
                    name=quality{qq};
                    data=xlsread(path,name);
                    data=data.*100;
                    data=data';
                    alldata=cat(2,alldata,data);
                end
            end
        end
        subplot(2,4,qq); 
        meand=mean(mean(alldata));
        stdd=std(mean(alldata));
        m1(qq)=meand;
        boxplot(alldata,'notch','off','symbol','','colors',[160/255 160/255 160/255]);
        hold on
        plot([0,135],[meand meand],'--','Color',[55, 118, 52]/255,'LineWidth',1.5);
        hold on
        boxplot(alldata(:,1),'notch','off','symbol','','colors',[244,79,57]/255);   
        hold on
        color_low=[55, 118, 52]/255;
        color_mid=[121 177 122]/255;
        color_up=[255 255 255]/255;
        uplim=1000;lowlim=0;
        col=interp1([lowlim (lowlim+uplim)/2 uplim],[color_low;color_mid;color_up],[lowlim:1:uplim]);
        colormap(col)
        a1=meand-stdd;
        a2=meand+stdd; 
        x=[0;0;0;136;136;136];
        y=[a1;meand;a2;a2;meand;a1];
        C=[1000 50 1000 1000 50 1000];
        patch(x,y,C,'FaceAlpha',.5,'EdgeColor',[255 255 255]/255);
        set(gca,'xlim',[0,136],'xtick',[1:5:135],'XTickLabel','');
        set(gca,'ylim',aa(qq,:),'ytick',gap(qq,:),'FontSize',10,'xcolor','k','ycolor','k','LineWidth',1);
        ylabel([labels{qq}],'FontSize',10);
        text(-20,aa(qq,2),toplabel{qq},'FontSize',12,'FontWeight','bold');
    end

end

% print -dpdf -r600 -painters Figure

