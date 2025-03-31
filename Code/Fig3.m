clc;close all;clear all
model={'linear'};
emodel={'linear'};
cli={'tas','tmax','tmin'};
years={'所有年','前7年','后7年'};
quality={"hardness","water","protein","gluten","sedimentation","stability","stretch","resistance"};
set(gcf,'position',[1000 548 1025 790]);
pos=[0.02 0.6 0.3 0.3;0.35 0.6 0.3 0.3;0.68 0.6 0.3 0.3;0.02 0.1 0.3 0.3;0.35 0.1 0.3 0.3;0.68 0.1 0.3 0.3];
titlem={"Hardness index","Water absorption","Crude protein content","Wet gluten content","Sedimentation index","Stability time","Stretch area","Maximum resistance"};
for mm=1 %model
    alltem=[];
    allpre=[];
    allpt=[];
    allpp=[];
    for qq=1:8 %indicators
        eachtem=[];
        eachpre=[];
        eachpt=[];
        eachpp=[];
        for tt=1:3 %tem
            for yy=1:3 %year
                for p=1:3 %phenological stages
                    for dd=1:5
                        path=strcat(['D:\Robustness Check\',model{mm},'\',cli{tt},'\',years{yy},'\E_',emodel{mm},'_random_phe',num2str(p),'_d',num2str(dd),'.xlsx']);
                        name=quality{qq};
                        alldata=xlsread(path,'xishu');
                        data(1,:)=alldata(1,:); 
                        data(2,:)=alldata(5,:);
                        data(3,:)=alldata(2,:);
                        data(4,:)=alldata(4,:);
                        data(5,:)=alldata(3,:);
                        data(6,:)=alldata(6,:);
                        data(7,:)=alldata(7,:);
                        data(8,:)=alldata(8,:);
                        tem=data(qq,1);
                        pre=data(qq,2);
                        tem=tem.*100;
                        pre=pre.*100;
                        eachtem=cat(2,eachtem,tem);
                        eachpre=cat(2,eachpre,pre);
                    end
                end
            end
        end
        alltem=cat(1,alltem,eachtem);
        allpre=cat(1,allpre,eachpre);
        allpt=cat(1,allpt,eachpt);
        allpp=cat(1,allpp,eachpp);
    end
end

meantemall=mean(alltem,2);
stdtemall=std(alltem,0,2);
meanpreall=mean(allpre,2);
stdpreall=std(allpre,0,2);

meantemall=flipud(meantemall);
stdtemall=flipud(stdtemall);
meanpreall=flipud(meanpreall);
stdpreall=flipud(stdpreall);

path1=strcat(['D:\National\Modell_bayes_national.xlsx']);
xs=xlsread(path1,'et');  % tem

xishu1(1,:)=xs(1,:); 
xishu1(2,:)=xs(5,:);
xishu1(3,:)=xs(2,:);
xishu1(4,:)=xs(4,:);
xishu1(5,:)=xs(3,:);
xishu1(6,:)=xs(6,:);
xishu1(7,:)=xs(7,:);
xishu1(8,:)=xs(8,:);
xishu=xishu1;

xishu=xishu.*100;
xishu1=xishu(:,1);
xishud=xishu(:,2);
xishuu=xishu(:,3);
Stem=xishu1;
Stemd=xishud;
Stemu=xishuu;

Stem=flipud(Stem);
Stemd=flipud(Stemd);
Stemu=flipud(Stemu);
titlem=fliplr(titlem);


xs=[];
xishu=[];
xishu1=[];
% boot RMEL
path2=strcat(['D:\National\Model_random_national.xlsx']);
xs=xlsread(path2,'et');   
xishu1(1,:)=xs(1,:);  
xishu1(2,:)=xs(5,:);
xishu1(3,:)=xs(2,:);
xishu1(4,:)=xs(4,:);
xishu1(5,:)=xs(3,:);
xishu1(6,:)=xs(6,:);
xishu1(7,:)=xs(7,:);
xishu1(8,:)=xs(8,:);
xishu=xishu1;
xishu=xishu.*100;
xishu2=xishu(:,1);
xishud=xishu(:,2);
xishuu=xishu(:,3);
Stem2=xishu2;
Stemd2=xishud;
Stemu2=xishuu;

Stem2=flipud(Stem2);
Stemd2=flipud(Stemd2);
Stemu2=flipud(Stemu2);

% plot
clf
titlem={"Hardness index","Water absorption","Crude protein content","Wet gluten content","Sedimentation index","Stability time","Stretch area","Maximum resistance"};
cm=[247/255 221/255 220/255;247/255 221/255 220/255;225/255 156/255 141/255;225/255 156/255 141/255;178/255 62/255 62/255;178/255 62/255 62/255;178/255 62/255 62/255;178/255 62/255 62/255];
cm=flipud(cm);
set(gcf,'position',[123 464 985 531]);
subplot(1,2,1) %tem
titlem=fliplr(titlem);
for ii=1:8
    b=barh(ii,Stem(ii));
    b.FaceColor=cm(ii,:);
    hold on
end
hold on
errorbar(Stem,[1:8],abs(Stemd-Stem),Stemu-Stem,'horizontal','color',[120/255 120/255 120/255],'linewidth',1,"LineStyle","none");
xlabel('Change (%) for 1 °C warming in Tem');
set(gca,'ytick',[1:1:8],'YTickLabel',titlem,'xlim',[-6,6],'xtick',[-6:3:6],'LineWidth',1,'FontSize',12);
text(-6.5,9,'a','FontSize',12,'FontWeight','bold');
hold on
errorbar(meantemall,[1.2:1:8.2],stdtemall,'horizontal','color',[180/255 180/255 180/255],'linewidth',1,"LineStyle","none");
hold on 
scatter(meantemall,[1.2:1:8.2],20,'o','MarkerFaceColor',[180/255 180/255 180/255],'MarkerEdgeColor','k');
hold on 
errorbar(Stem2,[0.8:1:7.8],abs(Stemd2-Stem2),Stemu2-Stem2,'horizontal','color',[180/255 180/255 180/255],'linewidth',1,"LineStyle","none");
hold on
scatter(Stem2,[0.8:1:7.8],20,'o','MarkerFaceColor',[255/255 255/255 255/255],'MarkerEdgeColor','k');

%% 
xs=[];
xishu=[];
xishu1=[];
subplot(1,2,2) % pre
cm=[207/255 215/255 228/255;207/255 215/255 228/255;135/255 160/255 190/255;135/255 160/255 190/255;89/255 121/255 163/255;89/255 121/255 163/255;89/255 121/255 163/255;89/255 121/255 163/255];
cm=flipud(cm);
xs=xlsread(path1,'ep');   
xs=xs.*100;
xishu1(1,:)=xs(1,:);  
xishu1(2,:)=xs(5,:);
xishu1(3,:)=xs(2,:);
xishu1(4,:)=xs(4,:);
xishu1(5,:)=xs(3,:);
xishu1(6,:)=xs(6,:);
xishu1(7,:)=xs(7,:);
xishu1(8,:)=xs(8,:);
xishu=xishu1;
xishu1=xishu(:,1);
xishud=xishu(:,2);
xishuu=xishu(:,3);
Spre=xishu1;
Spred=xishud;
Spreu=xishuu;

Spre=flipud(Spre);
Spred=flipud(Spred);
Spreu=flipud(Spreu);

% boot RMEL
xs=[];
xishu=[];
xishu1=[];
xs=xlsread(path2,'ep');  
xishu1(1,:)=xs(1,:);  
xishu1(2,:)=xs(5,:);
xishu1(3,:)=xs(2,:);
xishu1(4,:)=xs(4,:);
xishu1(5,:)=xs(3,:);
xishu1(6,:)=xs(6,:);
xishu1(7,:)=xs(7,:);
xishu1(8,:)=xs(8,:);
xishu=xishu1;
xishu=xishu.*100;
xishu2=xishu(:,1);
xishud=xishu(:,2);
xishuu=xishu(:,3);
Spre2=xishu2;
Spred2=xishud;
Spreu2=xishuu;

Spre2=flipud(Spre2);
Spred2=flipud(Spred2);
Spreu2=flipud(Spreu2);

for ii=1:8
    b=barh(ii,Spre(ii));
    b.FaceColor=cm(ii,:);
    hold on
end

hold on
errorbar(Spre,[1:8],abs(Spred-Spre),Spreu-Spre,'horizontal','color',[120/255 120/255 120/255],'linewidth',1,"LineStyle","none");
hold on 
errorbar(meanpreall,[1.2:1:8.2],stdpreall,'horizontal','color',[180/255 180/255 180/255],'linewidth',1,"LineStyle","none");
hold on 
scatter(meanpreall,[1.2:1:8.2],20,'o','MarkerFaceColor',[180/255 180/255 180/255],'MarkerEdgeColor','k');
hold on 
errorbar(Spre2,[0.8:1:7.8],abs(Spred2-Spre2),Spreu2-Spre2,'horizontal','color',[180/255 180/255 180/255],'linewidth',1,"LineStyle","none");
hold on
scatter(Spre2,[0.8:1:7.8],20,'o','MarkerFaceColor',[255/255 255/255 255/255],'MarkerEdgeColor','k');

xlabel('Change (%) for 1mm increased in Pre');
set(gca,'ytick',[1:1:8],'YTickLabel',titlem,'xlim',[-15,5],'xtick',[-15:5:5],'LineWidth',1,'FontSize',12);
text(-17,9,'b','FontSize',12,'FontWeight','bold');

% print -dpdf -r600 -painters fig3