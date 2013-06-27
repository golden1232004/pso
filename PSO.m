function f= PSO()
NP=20;              %种群规模
W=1.1;              %惯性权重
c1=2;               %常数
c2=2;               %常数
r1=rand();          %随机数
r2=rand();          %随机数
Eallowed = 0.001;   %允许误差
gBest = 1000;         %全局极值
gBestX = rand(1,2); %全局极值粒子位置
MaxIterator =100;  %最大迭代次数
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

PoPX = rand(NP,2);          %种群的位置
PoPV = rand(NP,2);          %种群的速度
PoPBest = 1000*ones(NP);    %种群个体极值
PoPBestX = rand(NP,2);      %种群个体极值位置
while count <= MaxIterator
    for i=1:NP
        Fit = GetFitness(PoPX(i,:));
        if Fit < PoPBest(i) %个体极值
            PoPBest(i) = Fit;
            PoPBestX(i,:) = PoPX(i,:);
        end
        if Fit < gBest      %全局极值
            gBest = Fit;
            gBestX = PoPX(i,:);
        end
    end
    
    for i=1:NP
        %速度
        PoPV(i,:) = W * PoPV(i,:) + c1 * rand() * (PoPBestX(i,:) - PoPX(i,:)) + c2 * rand() * (gBestX - PoPX(i,:));
        for j=1:2
            if PoPV(i,j) > Vmax
                PoPV(i,j) = Vmax;
            end
            if PoPV(i,j) < -Vmax
                PoPV(i,j) = -Vmax;
            end
        end
        %位置
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
%求适应度值
function [fit] = GetFitness(X)
    fit = 100 * (X(2) - X(1)^2)^2 + (1 - X(1))^2;
%--------------------------------------------------------