function [m2] = set2( m,k,v,y ,x )
% set value of  v in coordinates k of image m  with initial position x and y,
if nargin<4
    y=0;
    x=0;
end;
if x<0
    x=0;
end;
if y<0
    y=0;
end;
[a,b]=size(k);
m2=m;
for f=1:1:a
    m2(k(f,1)+y,k(f,2)+x)=v;
%m(6,6)=7;
end
end