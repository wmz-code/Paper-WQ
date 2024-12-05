clc;close all;clear all
titlem={"Hardness index","Crude protein content","Sedimentation index","Wet gluten content","Water absorption","Stability time","Stretch area","Max resistance"};
model={'Linear'};
emodel={'linear'};
cli={'tas','tmax','tmin'};
years={'所有年','前7年','后7年'};
quality={"hardness","protein","sedimentation","gluten","water","stability","stretch","resistance"};
set(gcf,'position',[1000 548 1025 790]);
pos=[0.02 0.6 0.3 0.3;0.35 0.6 0.3 0.3;0.68 0.6 0.3 0.3;0.02 0.1 0.3 0.3;0.35 0.1 0.3 0.3;0.68 0.1 0.3 0.3];
for mm=1 %model
    alltem=[];
    allpre=[];
    allpt=[];
    allpp=[];
    for qq=1:8 %quality indicators
        eachtem=[];
        eachpre=[];
        eachpt=[];
        eachpp=[];
        for tt=1:3 %tem
            for yy=1:3 %period
                for p=1:3 %phenology
                    for dd=1:5
                        path=strcat(['D:\Home\Data\Fig3\Robust Checkness\',model{mm},'\',cli{tt},'\',years{yy},'\E_',emodel{mm},'_phe',num2str(p),'_d',num2str(dd),'.xlsx']);
                        name=quality{qq};
                        data=xlsread(path,'xishu');
                        pdata=xlsread(path,'sig_xishu');
                        tem=data(qq,1); 
                        pre=data(qq,2);
                        tem=tem.*100;
                        pre=pre.*100;
                        eachtem=cat(2,eachtem,tem);
                        eachpre=cat(2,eachpre,pre);
                        pt=pdata(qq,1); 
                        pp=pdata(qq,2);
                        eachpt=cat(2,eachpt,pt);
                        eachpp=cat(2,eachpp,pp);
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

meantem=mean(alltem,2);
stdtem=std(alltem,0,2);
meanpre=mean(allpre,2);
stdpre=std(allpre,0,2);

allpt(allpt<0.05)=1;
allpt(allpt~=1)=0;
allpp(allpp<0.05)=1;
allpp(allpp~=1)=0;

ptem=alltem.*allpt;
ppre=allpre.*allpp;

meanptem=mean(ptem,2);
stdptem=std(ptem,0,2);
meanppre=mean(ppre,2);
stdppre=std(ppre,0,2);

% boot
path1=strcat(['D:\Home\Data\Fig3\Modell_boot_national.xlsx']);
xishu=xlsread(path1,'et');  % Tem or Pre
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
meantem=flipud(meantem);
stdtem=flipud(stdtem);
meanpre=flipud(meanpre);
stdpre=flipud(stdpre);
meanptem=flipud(meanptem);
stdptem=flipud(stdptem);
meanppre=flipud(meanppre);
stdppre=flipud(stdppre);

%%
clf
titlem={'Hardness index','Crude protein content','Sedimentation index','Wet gluten content','Water absorption',...
    'Stability time','Stretch area','Maximum resistance'};
cm=[247/255 221/255 220/255;225/255 156/255 141/255;178/255 62/255 62/255;225/255 156/255 141/255;247/255 221/255 220/255;178/255 62/255 62/255;178/255 62/255 62/255;178/255 62/255 62/255];
cm=flipud(cm);
set(gcf,'position',[123 464 985 531]);
subplot(1,2,1)  
titlem=fliplr(titlem);
for ii=1:8
    b=barh(ii,Stem(ii));
    b.FaceColor=cm(ii,:);
    hold on
end

hold on
errorbar(Stem,[1:8],abs(Stemd-Stem),Stemu-Stem,'horizontal','color',[120/255 120/255 120/255],'linewidth',1,"LineStyle","none");
xlabel('Change (%) for 1 °C warming in Tem');
set(gca,'ytick',[1:1:8],'YTickLabel',titlem,'xlim',[-3,9],'xtick',[-3:3:9],'LineWidth',1,'FontSize',12);
text(-3.5,9,'a','FontSize',12,'FontWeight','bold');
hold on
scatter(meantem,[1.2:1:8.2],'square','MarkerFaceColor',[180/255 180/255 180/255],'MarkerEdgeColor','k');
hold on 
errorbar(meantem,[1.2:1:8.2],stdtem,'horizontal','color',[180/255 180/255 180/255],'linewidth',1,"LineStyle","none");
subplot(1,2,2) %pre
cm=[207/255 215/255 228/255;135/255 160/255 190/255;89/255 121/255 163/255;135/255 160/255 190/255;207/255 215/255 228/255;89/255 121/255 163/255;89/255 121/255 163/255;89/255 121/255 163/255];
cm=flipud(cm);
xishu=xlsread(path1,'ep');  % Tem or Pre
xishu=xishu.*100;
xishu1=xishu(:,1);
xishud=xishu(:,2);
xishuu=xishu(:,3);
Spre=xishu1;
Spred=xishud;
Spreu=xishuu;

Spre=flipud(Spre);
Spred=flipud(Spred);
Spreu=flipud(Spreu);

for ii=1:8
    b=barh(ii,Spre(ii));
    b.FaceColor=cm(ii,:);
    hold on
end

hold on
errorbar(Spre,[1:8],abs(Spred-Spre),Spreu-Spre,'horizontal','color',[120/255 120/255 120/255],'linewidth',1,"LineStyle","none");
hold on 
scatter(meanpre,[1.2:1:8.2],'square','MarkerFaceColor',[180/255 180/255 180/255],'MarkerEdgeColor','k');
hold on 
errorbar(meanpre,[1.2:1:8.2],stdpre,'horizontal','color',[180/255 180/255 180/255],'linewidth',1,"LineStyle","none");

xlabel('Change (%) for 1 mm increased in Pre');
set(gca,'ytick',[1:1:8],'YTickLabel',titlem,'xlim',[-15,5],'xtick',[-15:5:5],'LineWidth',1,'FontSize',12);
text(-17,9,'b','FontSize',12,'FontWeight','bold');

% print -dpdf -r600 -painters fig_national_boot1
