
function newshape =morph(unmorph,d2)
% fname='foil.dat';
%name='Airfoil';

%AF = Airfoil;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Camber Morphing of an Airfoil
%This is a simple morphing function which changes the camber by deflecting
%the leading edge and trailing edge. A part of the airfoil is kept fixed in
%the morphing where the servos will be housed. The input commaneds are:
%   airfoil = which is the airfoil data to be morphed (got from 
%               airfoiltools.com or any other similar data set), (please 
%               note the data which is imported in workspace needs to be 
%               similar as the format of airfoiltools.com to work)
%   leR = 1st control point in terms of camber ratio(x/c). This is the 
%               point before which the the airfoil starts morphing to the
%               leading edge
%   teR = 2nd control point similar to leR but deflects the trailing edge
%   d1 = leading edge deflection
%   d2 = trailing edge deflection
%Example:
%   import naca2012 airfoil data(only shape, not the camber) as Nx2 matrix
%   %note: all the dimensions are in mm
%Input
%   a = morph(naca0012,0.2,0.4,2,10)
%Output
%   a(1:N,1:2) morphed airfoil data with deflection of 2mm of LE and 10mm
%   of TE
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%%
% function save(this,filename)
%             fid=fopen(filename,'w+');
%             fprintf(fid,'%s\n',this.Name);
%             fprintf(fid,' %f %f \n',[flipud(this.UpperX) flipud(this.UpperY)].');
%             fprintf(fid,' %f %f \n',[this.LowerX(2:end) this.LowerY(2:end)].');
%             fclose(fid);
%  end
newshape=unmorph;%assigning airfoil data to newshape
 N = size(unmorph,1);
 d1 = 0;
 leR = 0.2;
 teR = 0.4;
% if leR>teR
%     disp('error')
% else
%%
%plot(airfoil(:,1),airfoil(:,2),'-') %plots initial airfoil for comparision
%hold on

    n1=round((1-leR)*(N+1)/2);
    n2=round((1-teR)*(N+1)/2);
    n=round((N+1)/2);
    
    L=unmorph(n2,1)-unmorph(n1,1);%length of fixed portion
    L1=unmorph(n1,1)-unmorph(n,1);%length of leading edge protion
    L2=unmorph(1,1)-unmorph(n2,1);%length of trailing edge portion
    
%%
    for k=n1:n %morphing for leading edge
        x=(unmorph(n1,1)-unmorph(k,1));
        newshape(k,2)=unmorph(k,2)-d1/L1^3*(x*L1^2+x*L1-x^2);
        newshape(N-k+1,2)=unmorph(N-k+1,2)-d1/L1^3*(x*L1^2+x*L1-x^2);
    end
    
    for k=1:n2 %morphing for trailing edge
        x=(unmorph(k,1)-unmorph(n2,1));
        newshape(k,2)=unmorph(k,2)-d2/L2^3*(x*L2^2+x*L2-x^2);
        newshape(N-k+1,2)=unmorph(N-k+1,2)-d2/L2^3*(x*L2^2+x*L2-x^2);
    end
    newshape = newshape/unmorph(1,1);
%transformation relation V=VL/L^3*(Z*L^2+Z*L-Z^2); VL= deflection
%% %plots of morphed airfoil   
%  x1=newshape(1:n,1); y1=newshape(1:n,2);
%  x2=newshape(n:N,1); y2=newshape(n:N,2);
%  cs = csapi(x1,y1);
%  fnplt(cs,1,'b')
%  hold on
%  cs1 = csapi(x2,y2);
%  fnplt(cs1,1,'b')
%  hold on
%  for k=[n1 n2 N+1-n1 N+1-n2] %plots control points
%  plot(newshape(k,1),newshape(k,2),'o')
%  hold on
%  end
%  axis([-airfoil(1,1) airfoil(1,1) -airfoil(1,1) airfoil(1,1)])
%  pbaspect([1 1 1])
%% Some other representations

% af.X=newshape(:,1)/unmorph(1,1);
% af.Y=newshape(:,2)/unmorph(1,1);
% for k = 1:((N+1)/2)
% modshape.UpperX(k) = newshape(((N+1)/2)-k+1,1)/unmorph(1,1);
% modshape.UpperY(k) = newshape(((N+1)/2)-k+1,2)/unmorph(1,1);
% end
% for l = ((N+1)/2):N
% modshape.LowerX(l+1-(N+1)/2) = newshape(l,1)/unmorph(1,1);
% modshape.LowerY(l+1-(N+1)/2) = newshape(l,2)/unmorph(1,1);
% end
% modshape.Name='morphed';
% modshape;
%% For Xfoil

% plot(modshape.x,modshape.y)
% axis([-1 1 -1 1])
% pbaspect([1 1 1])
% AF = modshape;
%     AF.UpperX = transpose(modshape.UpperX);
%     AF.UpperY = transpose(modshape.UpperY);
%     AF.LowerX = transpose(modshape.LowerX);
%     AF.LowerY = transpose(modshape.LowerY);
%     AF.Name   = 'morph';
%    
%    f.datfilepath = './';
%    f.designation = '0015';
%  AF; 
%  
%     F1=AF.Name;
%     F2=num2str([af.X af.Y]);
%     F=strvcat(F1,F2);
%     Name=[f.datfilepath 'morph' f.designation '.dat'];
%         dlmwrite(Name,F,'delimiter','')
%         
%         af;
%         f;
   %Airfoil(filename)
%    save(AF,Name)
%% 
% fileID = fopen(fname,'w');
% %fprintf(fileID,'%12s\r\n',name);
% for i=1:N
% fprintf(fileID,'%1.5f %1.5f \r\n',newshape(i,1),newshape(i,2));
% end
% fclose(fileID);

end
