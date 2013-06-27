function f= PSO()
NP=20;              %��Ⱥ��ģ
W=1.1;              %����Ȩ��
c1=2;               %����
c2=2;               %����
r1=rand();          %�����
r2=rand();          %�����
Eallowed = 0.001;   %�������
gBest = 1000;         %ȫ�ּ�ֵ
gBestX = rand(1,2); %ȫ�ּ�ֵ����λ��
MaxIterator =100;  %����������
count = 0;
goal = 0.25;
Vmax = 0.5;
g = zeros(1,MaxIterator);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% f(X) = 100*(x2-x1^2)^2 + (1-x1)^2;
% g1(X) = -x1 - x2^2 <= 0;
% g2(X) = -x1^2 - x2 <= 0;
% -0.5<= x1 <= 0.5, x2 <= 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PoPX = rand(NP,2);          %��Ⱥ��λ��
PoPV = rand(NP,2);          %��Ⱥ���ٶ�
PoPBest = 1000*ones(NP);    %��Ⱥ���弫ֵ
PoPBestX = rand(NP,2);      %��Ⱥ���弫ֵλ��
while count <= MaxIterator
    for i=1:NP
        Fit = GetFitness(PoPX(i,:));
        if Fit < PoPBest(i) %���弫ֵ
            PoPBest(i) = Fit;
            PoPBestX(i,:) = PoPX(i,:);
        end
        if Fit < gBest      %ȫ�ּ�ֵ
            gBest = Fit;
            gBestX = PoPX(i,:);
        end
    end
    
    for i=1:NP
        %�ٶ�
        PoPV(i,:) = W * PoPV(i,:) + c1 * rand() * (PoPBestX(i,:) - PoPX(i,:)) + c2 * rand() * (gBestX - PoPX(i,:));
        for j=1:2
            if PoPV(i,j) > Vmax
                PoPV(i,j) = Vmax;
            end
            if PoPV(i,j) < -Vmax
                PoPV(i,j) = -Vmax;
            end
        end
        %λ��
        PoPX(i,:) = PoPX(i,:) + PoPV(i,:); 
    end
    count = count + 1;
    g(count) = gBest;
    count
    gBest
end
gBestX
plot(g);
%--------------------------------------------------------
%����Ӧ��ֵ
function [fit] = GetFitness(X)
    fit = 100 * (X(2) - X(1)^2)^2 + (1 - X(1))^2;
%--------------------------------------------------------