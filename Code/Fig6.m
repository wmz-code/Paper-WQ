close all;clear all;clc
head=xlsread('D:\gcm1_pr.xlsx','Sheet1');
data=xlsread('D:\wheat.xlsx');
data=data(:,[1 5 6 12 15 20 18 22 24 27 25]);       
clizone=[5,7,11,12,14,21,22,23];
quality={"hardness","protein","gluten","sedimentation","water","stability","resistance","stretch"};   %sequence for national standard

co126=load('D:\co2_ssp126_annual.txt');
co370=load('D:\co2_ssp370_annual.txt');
co585=load('D:\co2_ssp585_annual.txt');

for ii=1:30
    co_1(ii)=co126(6+ii,2)-410; % CO2 for the year 2019
    co_2(ii)=co370(6+ii,2)-410;
    co_3(ii)=co585(6+ii,2)-410;
end

for ii=1:length(head)
    index=find(data(:,2)==head(ii,1));
    each=data(index,4:11);
    if length(index)>1
        table(ii,:)=mean(each,'omitnan');
    else
        table(ii,:)=each;
    end
    aaa(ii)=sum(isnan(table(ii,:))); 
end

id=find(aaa==0); 
basedata=[head(id,:),table(id,:)]; 

for ii=1:520
    bb(ii,:)=qualityclass(basedata(ii,[4:11]));  %baseline
end

ha=xlsread('D:\PKU Work\NF第二次修改\harvest_county.xlsx');
type=[1 2 3 4 0];

hachina=sum(ha(:,5));
for ii=1:5
    index=find(bb==type(ii));
    typechina(ii)=sum(ha(index,5))./hachina;
    index=[];
end

for jj=1:8  % climate zone
    index1=find(basedata(:,3)==clizone(jj));
    eacharea=basedata(index1,1); 
    eachtype=bb(index1,:);
    for ii=1:length(eacharea)
        index2=find(ha(:,1)==eacharea(ii));
        eachha(ii)=ha(index2,5);
    end
    eachtable=[eacharea eachtype eachha'];
    allha=sum(eachha);
    for kk=1:5
        index3=find(eachtable(:,2)==type(kk));
        subdata=eachtable(index3,[2 3]);
        if length(subdata)>0
            typep(jj,kk)=sum(subdata(:,2))./allha;  
        else
            typep(jj,kk)=0;
        end
    end
    eachha=[];
    index1=[];
    index2=[];
    eacharea=[];
end

typep=typep.*100; %baseline

load('D:\CO2\final126.mat');
load('D:\CO2\final126c.mat');
load('D:\CO2\final370.mat');
load('D:\CO2\final370c.mat');
load('D:\CO2\final585.mat');
load('D:\CO2\final585c.mat');
xx=[126 370 585];

for jj=1:8 %climate zone
    
    index1=find(basedata(:,3)==clizone(jj));
    eacharea=basedata(index1,1);  
    eachvalue=basedata(index1,[4:end]);  
    
    for ss=1:3  
        eval(['final=',['final',num2str(xx(ss)),';']]);
        datas=mean(final(index1,21:30,:),2); % without CO2 constraint
        datas=reshape(datas,[length(index1),8]);

        eval(['finalc=',['final',num2str(xx(ss)),'c;']]);
        datac=mean(finalc(index1,21:30,:),2); % with CO2 constraint
        datac=reshape(datac,[length(index1),8]);

        values=eachvalue+datas.*eachvalue;
        valuec=eachvalue+datac.*eachvalue;

        for ii=1:length(index1) 
            bs(ii,:)=qualityclass(values(ii,:)); 
            bc(ii,:)=qualityclass(valuec(ii,:)); 
        end

        eachha=ha(index1,5); %harvest area
        allha=sum(eachha);

        for kk=1:5  
            indexs=find(bs==type(kk));
            indexc=find(bc==type(kk));

            subdatas=eachha(indexs,:);
            subdatac=eachha(indexc,:);

            if length(subdatas)>0
                types(jj,kk,ss)=sum(subdatas)./allha;  
            else
                types(jj,kk,ss)=0;
            end

            if length(subdatac)>0
                typec(jj,kk,ss)=sum(subdatac)./allha;  
            else
                typec(jj,kk,ss)=0;
            end

        end

        eachha=[];
        bs=[];
        bc=[];
    end

end
types=types.*100; 
typec=typec.*100; 

clf
toplabel={'a','b','c','d','e','f','g','h'};
set(gcf,'position',[684 246 1339 795])
for kk=1:8 % indicators
    subplot(2,4,kk)
    h=bar(0.6,typep(kk,:),0.9,'stacked');
    h(1).EdgeColor=[173/255 47/255 71/255];
    h(1).FaceColor=[173/255 47/255 71/255];
    h(2).EdgeColor=[219/255 183/255 133/255];
    h(2).FaceColor=[219/255 183/255 133/255];
    h(3).EdgeColor=[88/255 179/255 166/255];
    h(3).FaceColor=[88/255 179/255 166/255];
    h(4).EdgeColor=[201/255 236/255 230/255];
    h(4).FaceColor=[201/255 236/255 230/255];
    h(5).EdgeColor=[255/255 255/255 255/255];
    h(5).FaceColor=[255/255 255/255 255/255];
    hold on
    for ss=1:3 % ssp
        h=bar(ss+1,types(kk,:,ss),0.9,'stacked');
        h(1).EdgeColor=[173/255 47/255 71/255];
        h(1).FaceColor=[173/255 47/255 71/255];
        h(2).EdgeColor=[219/255 183/255 133/255];
        h(2).FaceColor=[219/255 183/255 133/255];
        h(3).EdgeColor=[88/255 179/255 166/255];
        h(3).FaceColor=[88/255 179/255 166/255];
        h(4).EdgeColor=[201/255 236/255 230/255];
        h(4).FaceColor=[201/255 236/255 230/255];
        h(5).EdgeColor=[255/255 255/255 255/255];
        h(5).FaceColor=[255/255 255/255 255/255];
        hold on
        h=bar(ss+4.4,typec(kk,:,ss),0.9,'stacked');
        hold on
        h(1).EdgeColor=[173/255 47/255 71/255];
        h(1).FaceColor=[173/255 47/255 71/255];
        h(2).EdgeColor=[219/255 183/255 133/255];
        h(2).FaceColor=[219/255 183/255 133/255];
        h(3).EdgeColor=[88/255 179/255 166/255];
        h(3).FaceColor=[88/255 179/255 166/255];
        h(4).EdgeColor=[201/255 236/255 230/255];
        h(4).FaceColor=[201/255 236/255 230/255];
        h(5).EdgeColor=[255/255 255/255 255/255];
        h(5).FaceColor=[255/255 255/255 255/255];
        hold on
    end
    set(gca,'ylim',[0,100],'xlim',[-0.5,8.5],'xtick',[],'LineWidth',1);
    text(-3,100,toplabel{kk},'FontSize',14,'FontWeight','bold');
    ylabel('Proportion (%)');
end

% print -dpdf -r600 -painters Fig6




