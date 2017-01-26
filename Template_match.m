
function [score,  y, x ]=Template_match(Is,Itm,Itm_dilation)
%{
Find  templae Itm (binary) image Is (GreyScale).
Return y,x coordinates of the best match and its score

Itm_dilation: The amount of dilation for of the template. How much the template line will be thickened  (in pixels) for each side before crosscorelated with the image. 
 The thicker the template the better its chance to overlap with edge of object in the image and more rigid the recognition process, however thick template can also reduce recognition accuracy. 
The default value for this parameter is 1/40 of the average dimension size of the template Itm.
%}
%==========================================intialize optional paramters=================================================================================================================

if (nargin<1)
    Sitm=size(Itm);
Itm_dilation=floor(sqrt(Sitm(1)*Sitm(2))/80);% in order to avoid the edge from missing correct point by dilation the size of dilation is proportinal to the size of the item template dimension.
%tm_dilation=2
end;
%===================================================Prepare template=======================================================================================================================
%---------------------DILATE Template-------------------------------------------------------------------------------------------------------------------------------------------------
%%it might be that the border will be  tin to be idenified by single  edge
%dilution of the template will prevent it from being miss
It=double(Itm);
for f=1:1:Itm_dilation 
    It=dilate(It);%DILATE Template
end

    Im=double(It);

%==================================================Prepare image======================================================================================== 
%----------------------------------------Transform image to canny edge--------------------------------------------------------------------------------------------------------

    Iedg=edge(Is,'canny');%,[highthresh/3,highthresh],1.1);
    Iedg=double(Iedg);


%==============================================Search for template in the image===============================================================================================
%------------------------------------------------------------------------------filter-----------------------------------------------------------------------------------------------------

Itr=imfilter(Iedg,Im,'same');%use filter/kernal to scan the cross correlation of the image Iedg to the template and give match of the cross corelation scoe for each pixel in the image
%---------------------------------------------------------------------------normalized according to template size (fraction of the template points that was found)------------------------------------------------------------------------------------------------
Itr=Itr./sqrt(sum(sum(Itm)));% normalize score match by the number of pixels in the template to avoid biase toward large template
%---------------------------------------------------------------------------find the location best match
mx=max(max(Itr));
[y,x]=find(Itr==mx,  1, 'first'); % find the location first 10 best matches which their score is at least thresh percents of the maximal score and put them in the x,y array
score=zeros(size(y));
ss=size(Itm);
 

   score=Itr(y(1),x(1));
   y(1)=round(y(1)-ss(1)/2);% normalize the location of the cordinate to so it will point on the edge of the image and not its center
   x(1)=round(x(1)-ss(2)/2);
%====================================For display only mark the ves result on the image=======================================================================
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%DILATE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% dilate binary image bw
function bw2=dilate(bw)
bw2=imdilate(bw,strel('square',3));%dilate image
end