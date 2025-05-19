clc;close all;clear all % projection of end-use in fig4
head=xlsread('/data/Others/head.xlsx','Sheet1');
load('/data/Others/basedata.mat');    
clizone=[5,7,11,12,14,21,22,23];
quality={"hardness","protein","gluten","sedimentation","water","stability","resistance","stretch"};  %sequence in the national standard

for ii=1:length(basedata)
    bb(ii,:)=qualityclass(basedata(ii,[4:11]));  
end

ha=xlsread('/data/Others/harvest_county.xlsx');
type=[1 2 3 4 0];

hachina=sum(ha(:,5));
for ii=1:5
    index=find(bb==type(ii));
    typechina(ii)=sum(ha(index,5))./hachina;
    index=[];
end

for jj=1:8 % climate zone
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

typep=typep.*100; % end-use type in baseline

load('/data/Others/final126.mat');
load('/data/Others/final126c.mat');
load('/data/Others/final370.mat');
load('/data/Others/final370c.mat');
load('/data/Others/final585.mat');
load('/data/Others/final585c.mat');

xx=[126 370 585];

for jj=1:8 % climate zone
    
    index1=find(basedata(:,3)==clizone(jj));
    eacharea=basedata(index1,1);  
    eachvalue=basedata(index1,[4:end]);  
    
    for ss=1:3 % ssp
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

        eachha=ha(index1,5);  %harvest area
        allha=sum(eachha);

        for kk=1:5 % 5 types of end-use
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

toplabel={'a','b','c','d','e','f','g','h'};
set(gcf,'position',[684 246 1339 795])
for kk=1:8  
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
    for ss=1:3  
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
% legend('High-gluten','Medium-high-gluten','Medium-gluten','Low-gluten')
print(gcf, '/results/fig4.png', '-dpng', '-r300');




