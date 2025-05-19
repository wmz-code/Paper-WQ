% Example code for exacting precipitation data during the entire growth period for each county during
% baseline from GCM1 (GFDL-ESM4)
clc;clear all;close all
[county,R]=geotiffread('/data/Others/wheatcounty.tif'); 
load('/data/Others/idarea.mat');
gcm={'gfdl-esm4','ipsl-cm6a-lr','mpi-esm1-2-hr','mri-esm2-0','ukesm1-0-ll'};
m=1; % GCM1 (GFDL-ESM4)
hyear=[2001 2011;2010 2014]; 
histcountyyear=[]; 
for hh=1:2
    fy=num2str(hyear(1,hh));
    ey=num2str(hyear(2,hh));
    filename=strcat(['/data/Others/',gcm{m},'_r1i1p1f1_w5e5_historical_pr_lat20.0to55.0lon70.0to130.0_daily_',fy,'_',ey,'.nc']); % CMIP6 data
    data=ncread(filename,'pr');
    data=imrotate(data,90);
    data=flipud(data);
    data=imresize(data,[350,600],'bilinear');  
    startrow=floor((55-53.362)./0.1+1);
    endrow=startrow+309-1;
    startcol=floor((75.296-(70))./0.1+1);
    endcol=startcol+542-1;
    clichina=data(startrow:endrow,startcol:endcol,:);  
    [x,y,days]=size(clichina);
    allyear=reshape(clichina,[x*y,days]);   
    allcounty=[];
    for jj=1:length(idarea(:,1));
        maskcounty=county;  
        maskcounty(maskcounty~=idarea(jj,1))=nan;
        maskcounty(maskcounty==idarea(jj,1))=1; 
        index=find(maskcounty==1);
        eachcounty=allyear(index,:); 
        [grid,~,~]=size(eachcounty);
        if grid>1
            eachcounty=mean(eachcounty,'omitnan');  
        end
        allcounty=cat(1,allcounty,eachcounty);
    end
    histcountyyear=cat(2,histcountyyear,allcounty);
    clearvars data maskcounty eachcounty allyear clichina
end

histpr1=histcountyyear; 

green=xlsread('/data/Others/phenology.xlsx','green');
green=round(green); 
maturity=xlsread('/data/Others/phenology.xlsx','maturity');
maturity=round(maturity); 

load('/data/Others/histhead.mat');
years=[2001:2014];
alldays=[];
for ii=1:14
    index=find(histhead==years(ii));
    aa=length(index);
    days=1:aa;
    days=days';
    alldays=cat(1,alldays,days);
    days=[];
end
alldays=alldays';

for year=2001:2014
    for jj=1:length(idarea(:,1))
        gindex=find(histhead==year&alldays==green(jj,2));
        mindex=find(histhead==year&alldays==maturity(jj,2));
        eachcounty=histpr1(jj,[gindex:mindex]);
        meancounty(jj,year-2000)=mean(eachcounty,'omitnan');
    end
end
wholeperiod=meancounty;
wholeperiod=wholeperiod.*86400; % transfer precipitation unit
head=[2001:2014];
wholeperiod=[head;wholeperiod];
xlswrite('/results/gcm1_pr.xlsx',wholeperiod,'hist'); % the extracted precpitation during whole growing period in baseline











