clc;clear all;close all
% Example for the projection of protein content change in eight climate
% zones based on one output of GCM
head=xlsread('/data/Others/head.xlsx','Sheet1');
quality={"hardness","protein","sedimentation","gluten","water","stability","stretch","resistance"};
clizone=[5,7,11,12,14,21,22,23];

for mm=1 % mm=1:5 Example for the GCM1
    tpath=strcat(['/data/Others/gcm',num2str(mm),'_tas.xlsx']);
    ppath=strcat(['/data/Others/gcm',num2str(mm),'_pr.xlsx']);
    % TEM
    Thist=xlsread(tpath,'hist');
    T126=xlsread(tpath,'ssp126');
    T370=xlsread(tpath,'ssp370');
    T585=xlsread(tpath,'ssp585');
    Thist=Thist(2:end,:);
    T126=T126(2:end,:);
    T370=T370(2:end,:);
    T585=T585(2:end,:);
    % PRE
    Phist=xlsread(ppath,'hist');
    P126=xlsread(ppath,'ssp126');
    P370=xlsread(ppath,'ssp370');
    P585=xlsread(ppath,'ssp585');
    Phist=Phist(2:end,:);
    P126=P126(2:end,:);
    P370=P370(2:end,:);
    P585=P585(2:end,:);

    for jj=2 % protein content

        model1_ssp126=[]; 
        model2_ssp126=[];
        model1_ssp370=[];
        model2_ssp370=[];
        model1_ssp585=[];
        model2_ssp585=[];
        head_id=[];

        for ii=1:8 %climate zone
            cc=clizone(ii);
            CliFile=strcat(['/data/Estimation/Model_bayes_nonlinear_clizone',num2str(cc),'.xlsx']);
 
            tem1=xlsread(CliFile,'et'); 
            tem2=xlsread(CliFile,'et2');
            pre1=xlsread(CliFile,'ep');
            pre2=xlsread(CliFile,'ep2');

            bt1=tem1(jj,1);
            bt2=tem2(jj,1);
            bp1=pre1(jj,1);
            bp2=pre2(jj,1);

            index=find(head(:,3)==clizone(ii));
            id=head(index,[1 3]);
            sthist=Thist(index,:);
            st126=T126(index,:);
            st370=T370(index,:);
            st585=T585(index,:);
            sphist=Phist(index,:);
            sp126=P126(index,:);
            sp370=P370(index,:);
            sp585=P585(index,:);

            model1_hist=bt1.*sthist+bt2.*sthist.*sthist+bp1.*sphist+bp2.*sphist.*sphist;      
            model1_base=mean(model1_hist,2);

            model1_126=bt1.*st126+bt2.*st126.*st126+bp1.*sp126+bp2.*sp126.*sp126-model1_base;
            model1_370=bt1.*st370+bt2.*st370.*st370+bp1.*sp370+bp2.*sp370.*sp370-model1_base;
            model1_585=bt1.*st585+bt2.*st585.*st585+bp1.*sp585+bp2.*sp585.*sp585-model1_base;

            model1_ssp126=cat(1,model1_ssp126,model1_126);
            model1_ssp370=cat(1,model1_ssp370,model1_370);
            model1_ssp585=cat(1,model1_ssp585,model1_585);

            head_id=cat(1,head_id,id);

        end

        model1_ssp126=[head_id model1_ssp126]; 
        model1_ssp370=[head_id model1_ssp370];
        model1_ssp585=[head_id model1_ssp585];

        name=char(quality{jj});

        path1=strcat(['/results/pre_ssp126clizone_nonlinear_bayes_tas_gcm1.xlsx']); %the projection of protein content in each climate zone based on GCM1
        path2=strcat(['/results/pre_ssp370clizone_nonlinear_bayes_tas_gcm1.xlsx']);
        path3=strcat(['/results/pre_ssp585clizone_nonlinear_bayes_tas_gcm1.xlsx']);

        xlswrite(path1,model1_ssp126,name);
        xlswrite(path2,model1_ssp370,name);
        xlswrite(path3,model1_ssp585,name);

    end

end





