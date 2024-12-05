% example for plotting fig4a
clc;close all;clear all
clizone=[5,7,11,12,14,21,22,23];

for ii=1:8  
    cc=clizone(ii);
    path=strcat(['D:\Home\Data\Fig4\Modell_boot_linear_clizone',num2str(cc),'.xlsx']);
    Tdata=xlsread(path,'et');
    Tdata=Tdata.*100;
%     Pdata=xlsread(path,'sheet2');
%     Tdata=Pdata.*100;
    for kk=1:8 
        q1(ii,:)=Tdata(1,:);
        q2(ii,:)=Tdata(2,:);
        q3(ii,:)=Tdata(3,:);
        q4(ii,:)=Tdata(4,:);
        q5(ii,:)=Tdata(5,:);
        q6(ii,:)=Tdata(6,:);
        q7(ii,:)=Tdata(7,:);
        q8(ii,:)=Tdata(8,:);
    end
end

q1=flipud(q1);
q2=flipud(q2);
q3=flipud(q3);
q4=flipud(q4);
q5=flipud(q5);
q6=flipud(q6);
q7=flipud(q7);
q8=flipud(q8);

clf
aa=[-6 6;-6 6;-12 12;-6 6;-3 3;-15 15;-27 27;-15 15];
gap=[-6:2:6;-6:2:6;-12:4:12;-6:2:6;-3:1:3;-15:5:15;-27:9:27;-15:5:15];

% aa=[-9 9;-9 9;-21 21;-12 12;-6 6;-99 99;-90 90;-84 84];
% gap=[-9:3:9;-9:3:9;-21:7:21;-12:4:12;-6:2:6;-99:33:99;-90:30:90;-84:28:84];
set(gcf,'Position',[1488 50 795 1311]);
titlem={"Hardness index","Crude protein content","Sedimentation index","Wet gluten content","Water absorption","Stability time","Stretch area","Max resistance"};
for jj=1:8
    eval(['qq=',['q',num2str(jj)]]);
    subplot(4,2,jj);
    xx=[1:8];
    h=barh(1,qq(1,1));
    h.FaceColor=[135/255 132/255 186/255];
    h.EdgeColor=[135/255 132/255 186/255];
    hold on
    errorbar(qq(1,1),1,abs(qq(1,2)-qq(1,1)),qq(1,3)-qq(1,1),'horizontal','color',[80/255 80/255 80/255],'linewidth',1);
    xlabel('Change (%) for 1 °C warming in Tem');
%     xlabel('Change (%) for 1mm increased in Pre');
    h=barh(2,qq(2,1));
    h.FaceColor=[115/255 99/255 172/255];
    h.EdgeColor=[115/255 99/255 172/255];
    hold on
    errorbar(qq(2,1),2,abs(qq(2,2)-qq(2,1)),qq(2,3)-qq(2,1),'horizontal','color',[80/255 80/255 80/255],'linewidth',1);
    xlabel('Change (%) for 1 °C warming in Tem');
%     xlabel('Change (%) for 1mm increased in Pre');
    hold on
    h=barh(3,qq(3,1));
    h.FaceColor=[65/255 0/255 121/255];
    h.EdgeColor=[65/255 0/255 121/255];
    hold on
    errorbar(qq(3,1),3,abs(qq(3,2)-qq(3,1)),qq(3,3)-qq(3,1),'horizontal','color',[80/255 80/255 80/255],'linewidth',1);
    xlabel('Change (%) for 1 °C warming in Tem');
%     xlabel('Change (%) for 1mm increased in Pre');
    hold on
    h=barh(4,qq(4,1));
    h.FaceColor=[165/255 218/255 100/255];
    h.EdgeColor=[165/255 218/255 100/255];
    hold on
    errorbar(qq(4,1),4,abs(qq(4,2)-qq(4,1)),qq(4,3)-qq(4,1),'horizontal','color',[80/255 80/255 80/255],'linewidth',1);
    xlabel('Change (%) for 1 °C warming in Tem');
%     xlabel('Change (%) for 1mm increased in Pre');
    hold on
    h=barh(5,qq(5,1));
    h.FaceColor=[44/255 141/255 132/255];
    h.EdgeColor=[44/255 141/255 132/255];
    hold on
    errorbar(qq(5,1),5,abs(qq(5,2)-qq(5,1)),qq(5,3)-qq(5,1),'horizontal','color',[80/255 80/255 80/255],'linewidth',1);
    xlabel('Change (%) for 1 °C warming in Tem');
%     xlabel('Change (%) for 1mm increased in Pre');
    hold on
    h=barh(6,qq(6,1));
    h.FaceColor=[4/255 100/255 95/255];
    h.EdgeColor=[4/255 100/255 95/255];
    hold on
    errorbar(qq(6,1),6,abs(qq(6,2)-qq(6,1)),qq(6,3)-qq(6,1),'horizontal','color',[80/255 80/255 80/255],'linewidth',1);
    xlabel('Change (%) for 1 °C warming in Tem');
%     xlabel('Change (%) for 1mm increased in Pre');
    hold on
    h=barh(7,qq(7,1));
    h.FaceColor=[242/255 109/255 68/255];
    h.EdgeColor=[242/255 109/255 68/255];
    hold on
    errorbar(qq(7,1),7,abs(qq(7,2)-qq(7,1)),qq(7,3)-qq(7,1),'horizontal','color',[80/255 80/255 80/255],'linewidth',1);
    xlabel('Change (%) for 1 °C warming in Tem');
%     xlabel('Change (%) for 1mm increased in Pre');
    hold on
    h=barh(8,qq(8,1));
    h.FaceColor=[158/255 25/255 29/255];
    h.EdgeColor=[158/255 25/255 29/255];
    hold on
    errorbar(qq(8,1),8,abs(qq(8,2)-qq(8,1)),qq(8,3)-qq(8,1),'horizontal','color',[80/255 80/255 80/255],'linewidth',1);
    xlabel('Change (%) for 1 °C warming in Tem');
%     xlabel('Change (%) for 1mm increased in Pre');
    set(gca,'xlim',aa(jj,:),'xtick',gap(jj,:),'FontSize',10);
    title(titlem{jj});
%     legend('Dwc','Dwb','Dwa','Cfa','Cwb','Cwa','BSk','BWk','Location','southwest')
end

% print -dpdf -r600 -painters fig_4

