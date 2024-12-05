close all;clear all;clc
load('D:\Home\Data\Fig6\head.mat');
load('D:\Home\Data\Fig6\basedata.mat');
load('D:\Home\Data\Fig6\countyselected.mat');
load('D:\Home\Data\Fig6\id.mat');
quality={"hardness","protein","gluten","sedimentation","water","stability","resistance","stretch"};   

for ii=1:length(basedata)
    bb(ii,:)=qualityclass(basedata(ii,[4:11]));  
end
clizone=[5,7,11,12,14,21,22,23];

for ii=1:length(countyselected)
    index=find(countyselected(ii)==head(:,1));
    cliselected(ii)=head(index,3);
    plantselected(ii)=head(index,2);
end

for cc=1:8 
    index=find(cliselected==clizone(cc));
    eachzone=bb(index);
    b_1(cc)=length(find(eachzone==1))./length(index).*100;
    b_2(cc)=length(find(eachzone==2))./length(index).*100;
    b_3(cc)=length(find(eachzone==3))./length(index).*100;
    b_4(cc)=length(find(eachzone==4))./length(index).*100;
    b_0(cc)=length(find(eachzone==0))./length(index).*100;
end
bbb=[b_1;b_2;b_3;b_4;b_0];
basedata=basedata(:,4:end);

for jj=1:8 
    name=char(quality{jj});
    for mm=1:5
        path1=strcat(['D:\Home\Data\Fig6\GCM',num2str(mm),'\ClimateZone\','pred_ssp126cli_nonlinear.xlsx']);
        path3=strcat(['D:\Home\Data\Fig6\GCM',num2str(mm),'\ClimateZone\','pred_ssp370cli_nonlinear.xlsx']);
        path5=strcat(['D:\Home\Data\Fig6\GCM',num2str(mm),'\ClimateZone\','pred_ssp585cli_nonlinear.xlsx']);
        ssp126=xlsread(path1,name); 
        data126(:,:,mm)=ssp126(id,3:end);
        ssp370=xlsread(path3,name);
        data370(:,:,mm)=ssp370(id,3:end);
        ssp585=xlsread(path5,name);
        data585(:,:,mm)=ssp585(id,3:end);
    end
    allmean126=mean(data126,3); 
    allmean370=mean(data370,3);
    allmean585=mean(data585,3);

    for kk=1:30
        final126(:,kk,jj)=basedata(:,jj)+basedata(:,jj).*allmean126(:,kk);
        final370(:,kk,jj)=basedata(:,jj)+basedata(:,jj).*allmean370(:,kk);
        final585(:,kk,jj)=basedata(:,jj)+basedata(:,jj).*allmean585(:,kk);
    end

end

for ii=1:length(countyselected)
    for jj=1:30
        index=reshape(final126(ii,jj,:),[1,8]); %ssp126
        cc1(ii,jj)=qualityclass(index);
    end
end

for ii=1:length(countyselected)
    for jj=1:30
        index=reshape(final370(ii,jj,:),[1,8]); %ssp370
        cc2(ii,jj)=qualityclass(index);
    end
end

for ii=1:length(countyselected)
    for jj=1:30
        index=reshape(final585(ii,jj,:),[1,8]); %ssp585
        cc3(ii,jj)=qualityclass(index);
    end
end

xx=[126 370 585];
finalcc=[];
for ss=1:3
    aa=xx(ss);
    eval(['final=',['final',num2str(aa)]]);

    data1=final(:,1:10,:);  %2021-2030
    data11=mean(data1,2);
    data11=reshape(data11,[length(countyselected),8]);
    for ii=1:length(countyselected)
        scc(ii)=qualityclass(data11(ii,:));
    end
    scc1(ss,:)=scc;

    data2=final(:,11:20,:); %2031-2040
    data22=mean(data2,2);
    data22=reshape(data22,[length(countyselected),8]);
    for ii=1:length(countyselected)
        mcc(ii)=qualityclass(data22(ii,:));
    end
    mcc1(ss,:)=mcc;

    data3=final(:,21:30,:); %2041-2050
    data33=mean(data3,2);
    data33=reshape(data33,[length(countyselected),8]);
    for ii=1:length(countyselected)
        lcc(ii)=qualityclass(data33(ii,:));
    end
    lcc1(ss,:)=lcc;
end

scc1=scc1';
mcc1=mcc1';
mcc1=mcc1';
scc1=scc1';

for ii=1:length(countyselected)
    index=find(countyselected(ii)==head(:,1));
    cliselected(ii)=head(index,3);
    plantselected(ii)=head(index,2);
end

shortdata=scc1;
middata=mcc1;
longdata=lcc1;
shortdata=shortdata';
middata=middata';
longdata=longdata';
for cc=1:8  
    index=find(cliselected==clizone(cc));
    eachzones=shortdata(index,:);
    eachzonem=middata(index,:);
    eachzonel=longdata(index,:);
    for ss=1:3 
        s_1(cc,ss)=length(find(eachzones(:,ss)==1))./length(index).*100;
        s_2(cc,ss)=length(find(eachzones(:,ss)==2))./length(index).*100;
        s_3(cc,ss)=length(find(eachzones(:,ss)==3))./length(index).*100;
        s_4(cc,ss)=length(find(eachzones(:,ss)==4))./length(index).*100;
        s_0(cc,ss)=length(find(eachzones(:,ss)==0))./length(index).*100;
        m_1(cc,ss)=length(find(eachzonem(:,ss)==1))./length(index).*100;
        m_2(cc,ss)=length(find(eachzonem(:,ss)==2))./length(index).*100;
        m_3(cc,ss)=length(find(eachzonem(:,ss)==3))./length(index).*100;
        m_4(cc,ss)=length(find(eachzonem(:,ss)==4))./length(index).*100;
        m_0(cc,ss)=length(find(eachzonem(:,ss)==0))./length(index).*100;
        l_1(cc,ss)=length(find(eachzonel(:,ss)==1))./length(index).*100;
        l_2(cc,ss)=length(find(eachzonel(:,ss)==2))./length(index).*100;
        l_3(cc,ss)=length(find(eachzonel(:,ss)==3))./length(index).*100;
        l_4(cc,ss)=length(find(eachzonel(:,ss)==4))./length(index).*100;
        l_0(cc,ss)=length(find(eachzonel(:,ss)==0))./length(index).*100;
    end
end

clf
toplabel={'a','b','c','d','e','f','g','h'};
set(gcf,'position',[684 246 1339 795])
for kk=1:8
    subplot(2,4,kk)
    h=bar(0.6,bbb(:,kk),0.9,'stacked');
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
        sss=[s_1(kk,ss),s_2(kk,ss),s_3(kk,ss),s_4(kk,ss),s_0(kk,ss)];
        h=bar(ss+1,sss,0.9,'stacked');
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
        mmm=[m_1(kk,ss),m_2(kk,ss),m_3(kk,ss),m_4(kk,ss),m_0(kk,ss)];
        h=bar(ss+4.4,mmm,0.9,'stacked');
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
        lll=[l_1(kk,ss),l_2(kk,ss),l_3(kk,ss),l_4(kk,ss),l_0(kk,ss)];
        h=bar(ss+7.8,lll,0.9,'stacked');
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
        table=[sss;mmm;lll];
    end
    set(gca,'ylim',[0,100],'xlim',[-0.5,12],'xtick',[],'LineWidth',1);
    text(-3,100,toplabel{kk},'FontSize',14,'FontWeight','bold');
    ylabel('Proportion (%)');
end
% legend('High-gluten','Medium-high-gluten','Medium-gluten','Low-gluten')
% print -dpdf -r600 -painters Figure6