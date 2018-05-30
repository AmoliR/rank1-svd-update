function [ML,MR,SL,SR,T1,T2,T3,T4] =EvaluateM_S_T(ML,MR,SL,SR,T1,T2,T3,T4,t,u,p)
for i = 1:p
    for j = 1:p
%         ML(i,j) = polyval(sym2poly(u{j}),(t(i)/(2+t(i))));
%         MR(i,j) = polyval(sym2poly(u{j}),(t(i)/(2-t(i))));
%         SL(i,j) = polyval(sym2poly(u{j}),((t(i)-1)/2));
%         SR(i,j) = polyval(sym2poly(u{j}),((t(i)+1)/2));
        ML(i,j) = polyval(u{j},(t(i)/(2+t(i))));
        MR(i,j) = polyval(u{j},(t(i)/(2-t(i))));
        SL(i,j) = polyval(u{j},((t(i)-1)/2));
        SR(i,j) = polyval(u{j},((t(i)+1)/2));
        T1(i,j) = polyval(u{j},(3/(t(i)-6)));
        T2(i,j) = polyval(u{j},(3/(t(i)-4)));
        T3(i,j) = polyval(u{j},(3/(t(i)+4)));
        T4(i,j) = polyval(u{j},(3/(t(i)+6)));
    end
end
end
