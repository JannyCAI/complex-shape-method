clc;
clear all;
close all;
%%初始化
a1=[2,1];
a2=[4,1];
a3=[3,3];
X=[a1;a2;a3];%起始顶点
alpha=1.3;%映射系数
erro_rate=1e-8;%迭代精度 计算平方根占用资源多 避免计算平方根 
n_end1=1e6;%每个映射系数减半的次数上限
n_end2=2e6;
n_end3=3e6;
E=100;%初始化迭代终止判决条件
S=size(X,1);%计算维数或可供选择的坏点数
n=0;%计算主程序总共迭代了几次
while(E>erro_rate)
    alpha=1.3;
    [y_goal,A,index] = select_1(X);%计算目标函数并筛选优点与坏点
    a_cen=(X(1,:)+X(2,:)+X(3,:)-X(index(S),:))./2;%计算其余各点的形心
    d=0;%判断映射点可行性的指示量
    c=0;%判断映射点值是否小于坏点的指示量
    e=0;%判断迭代次数是否超限的指示量
    n2=0;%由于映射点不可行导致映射系数减半的次数
    n3=0;%由于映射点值不小于坏点而导致映射系数减半的次数
    n4=0;
    %%
    while(d==0||c ==0)
        %% 判断迭代减半次数是否超限
        if (n2>=n_end1||n3>=n_end1)
            e=1;
        end
        if (n2>=n_end2||n3>=n_end2)
            e=2 ;           
        end
        if (n2>=n_end3||n3>=n_end3)
            e=3 ;           
        end
        
        switch e
            case 0
                a_map=a_cen+alpha.*(a_cen-X(index(S),:));%求映射点              
            case 1
                a_map=a_cen+alpha.*(a_cen-X(index(S-1),:));%求映射点       
            case 2             
                a_map=a_cen+alpha.*(a_cen-X(index(S-2),:));%求映射点  
            case 3
                fprintf('game over 无最优解');
                break
        end
        %%  通过循环将映射点调整至可行域内
        d=verlity(a_map(1),a_map(2));%检查映射点可行性
        
        switch d
            case 0
                alpha=alpha/2;
                n2=n2+1;               
                continue;
            case 1
                alpha=alpha;
                n2=0;
        end
        
        
        %%  通过循环将映射点值调整至小于坏点
        y=4.*a_map(1)-a_map(2).^2-12;
        if y<=y_goal(index(S))
            c=1;
        else
            c=0;
        end
        switch c
            case 1
            X(index(S),:)=a_map;
            y_goal=4.*X(:,1)-X(:,2).^2-12;
            E=((y_goal(1)-y_goal(index(1))).^2+(y_goal(2)-y_goal(index(1))).^2+(y_goal(3)-y_goal(index(1)))^.2)./3;
            n3=0;
            case 0
            alpha=alpha/2;
            n3=n3+1;
            continue
        end 
        n4=n4+1;
    end
    n=n+1;
    switch e
        case 3
            break
        otherwise
            continue
    end
end
if(E<=erro_rate)
[y_goal,A,index,p_max,index_max,p_min,index_min] = select(X);
point_optimize=[X(index_min,:)];
value_optimize=y_goal(index_min);
fprintf('hooray!!find the optimzed point \n 点的位置：(%.5f ,%.5f)\n 对应的极小值: %.5f\n',point_optimize(1),point_optimize(2),value_optimize);
end
       %% 调试日记 10.21 
       %小循环死循坏惹
       %%%解决 发现或运算符用错了
       %%& 没找到最优点
       %%%%解决 坏点坐标写错了
       
               