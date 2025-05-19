% This is an example for extracting maturity date for each county in the year of 2006
clc;clear all;close all
for year=2006
    filename=strcat(['/data/Others/CHN_Wheat_MA_',num2str(year),'.tif']); % The download phenology data
    [phe_data,Rp]=geotiffread(filename);
    [cou_data,Rc]=geotiffread('/data/Others/wheatcounty.tif'); % county map
    phe_data=double(phe_data);
    phe_data(phe_data<0)=NaN; 
    [m,n]=size(cou_data);
    cou_num=unique(cou_data);
    cou_num(isnan(cou_num))=[];
    cn=length(cou_num);
    phe_ave=zeros(cn,1);
    count=zeros(cn,1);
    count2=zeros(cn,2);
    latlon=zeros(cn,2);
    for i=1:m
        for j=1:n
            if ~isnan(cou_data(i,j))
                k=find(cou_num==cou_data(i,j));
                count2(k,:)=count2(k,:)+1;
                latlon(k,1)=latlon(k,1)+i;
                latlon(k,2)=latlon(k,2)+j;
                if ~isnan(phe_data(i,j))
                    count(k)=count(k)+1;
                    phe_ave(k)=phe_ave(k)+phe_data(i,j);
                end
            end
        end
    end
    phe_ave=phe_ave./count;
    latlon=latlon./count2;
    cou_dis=zeros(cn,cn)+10e10;
    for i=1:cn-1
        for j=i+1:cn
            cou_dis(i,j)=(latlon(i,1)-latlon(j,1))*(latlon(i,1)-latlon(j,1))+(latlon(i,2)-latlon(j,2))*(latlon(i,2)-latlon(j,2));
            cou_dis(j,i)=(latlon(i,1)-latlon(j,1))*(latlon(i,1)-latlon(j,1))+(latlon(i,2)-latlon(j,2))*(latlon(i,2)-latlon(j,2));
        end
    end

    cou_misdata=find(isnan(phe_ave));
    for i=1:length(cou_misdata)
        dis=cou_dis(cou_misdata(i),:);
        mindis=min(dis);
        k=find(dis==mindis);
        while isnan(phe_ave(k))
            dis(k)=10e10;
            mindis=min(dis);
            k=find(dis==mindis);
        end
        phe_ave(cou_misdata(i))=phe_ave(k);
    end

    final_phe(:,year-2005)=phe_ave;
end

maturity=mean(final_phe,2,'omitnan');
maturity=[cou_num maturity]; % maturity date in 2006
xlswrite('/results/phenology2006.xlsx',maturity,'maturity');







