function [y_goal,A,index,p_max,index_max,p_min,index_min] = select(X)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
y_goal=4.*X(:,1)-X(:,2).^2-12;%声明目标函数
[p_max,index_max]=max(y_goal);%筛选坏点
[p_min,index_min]=min(y_goal);%筛选优点
[A,index]=sort(y_goal);%按顺序排列优点 次坏点 坏点
end

