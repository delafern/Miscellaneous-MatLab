%%FERNANDO DE LA FUENTE
% Nose Cone Tip G Code generator

%user gives dimensions, specifies how much of the nosecone needs to be a
%machined material, 
%Takes a von Karman profile from x(radius) and z points, both in inches and
%outputs a G-Code


    %edits 12/10/18
        %decimal place after integers (X1. vs X1)
        %finish pass G,F,S codes
    %edits 1/6/2019
        %added length of entire nosecone and length for nosecone tip, as
        %entire nosecone is von karman, and this machined tip is just the
        %beginning of it.
    %edits 4/20/19
        %changed to radius of nosecone tip vs length of nosecone tip
    %to do
        %add user instructions
        %diameter of stock material for preliminary OD turn
        %add M01 code prior to finish pass.
        
        
clc
clear

%user prompt cell
promptCell = {'Length Nosecone: ','Nosecone Tip Radius', 'Nosecone End Radius: ', 'K Value: ', 'C Value: ','Filename: ','SFM: '};

%returned data from user
userInput = inputdlg(promptCell, 'Nosecone Tip', [1 1 1 1 1 1 1]);

%combine usergiven character array with a .txt filename extension
filename = strcat(char(userInput(6)),'.txt');

%user given SFM (contingent on material being machined
S = char(userInput(7));

%characters to numbers
userInput = str2num(char(userInput(1:5)));

clf
fprintf('working... \n')

length1 = userInput(1); %Nosecone length [inches]
tip_radius = userInput(2); %Nosecone tip length [inches]*CHANGE TO END DIAMETER
radius = userInput(3); %radius [inches]
Kval = userInput(4); %K value
Cval = userInput(5); %C Value


x_resolution = 0.0005;
xp = (0:x_resolution:length1);

for X = 0:x_resolution:length1
    Kval = Kval + 1 ;
    x = X/length1;
    h = acos(1-((2*X)/length1));
    r(Kval) = sqrt((h-((1/2)*sin(2*h))+(Cval*((sin(h))^3)))/pi);
    r(Kval) = r(Kval)*(radius);
end

hold on;
plot(xp,r,'black')
plot(xp,-r,'black')
xlabel('inches')
ylabel('inches')
axis equal
grid on

%points generated%
%Gcode Generation%

%making sure we just machine the from the tip to the length we want
[A,B] = min(abs(tip_radius - r));

%declare the points we want to machine
zpoints = xp(1:floor(B));
radius = r(1:floor(B));
       
        
%NAME THE FILE AND OPEN IT AND STUFF
name = filename;
fileID = fopen(name,'at');

%CHANGE RADIUS TO DIAMETER
diameter = round(2.*radius,4);

rapidclear = num2str(max(diameter) + .25) ; %create an X rapid point

%FIRST LINE OF G-CODE
txt = ('O01234');
fprintf(fileID,txt);
fprintf(fileID,'\n');

%PRELIMINARY MACHINE CODES
txt = 'G20 G18;'; %XZ PLANE, 
fprintf(fileID,txt);
fprintf(fileID,'\n');

txt = 'G53 X0 Z0;'; %MACHINE ZERO
fprintf(fileID,txt);
fprintf(fileID,'\n');

txt = 'G40 G80;'; %CANCEL COMPS
fprintf(fileID,txt);
fprintf(fileID,'\n');

txt = 'T3;'; %TOOL 3
fprintf(fileID,txt);
fprintf(fileID,'\n');

txt = strcat('G96 M03 S',S,';'); %CONSTANT SURFACE SPEED, SPINDLE CLCKWISE, SFM
fprintf(fileID,txt);
fprintf(fileID,'\n');

txt = 'G50 S3000 F0.005;'; %SPINDLE SPEED LIMIT
fprintf(fileID,txt);
fprintf(fileID,'\n');


%FLIP Z AND ADD TO DIAMETER FOR ROUGHING
roughz = fliplr( zpoints([1:100:end])             );
roughx = fliplr( (diameter([1:100:end])    ) + .010 );

txt = strcat('G00 Z1.0 X',rapidclear,' ;') ;
fprintf(fileID,txt);
fprintf(fileID,'\n');

%GENERATE ROUGHING PASSES
for n = 1:length(roughz)
    if mod(roughz(n),1)== 0 
        rz = strcat(num2str(roughz(n)),'.'); %MAKE SURE ALL INTEGER VALUES HAVE A DECIMAL POINT
    else
        rz = num2str(roughz(n));
    end
       
    if mod(roughx(n),1) == 0 
        rx = strcat(num2str(roughx(n)),'.');
    else
        rx = num2str(roughx(n));
    end
    
txt = strcat('G00 Z0.25 X',rx, ' ;'); %.25" in front of part, at roughX diameter)
fprintf(fileID,txt); 
fprintf(fileID,'\n');

txt = strcat('G01 Z-',rz, ' ;'); %FEED INTO PART UNTIL Z-VALUE
fprintf(fileID,txt);
fprintf(fileID,'\n');

txt = strcat('G00 X',rapidclear,' ;'); %RAPID OUT OF THE PART
fprintf(fileID,txt);
fprintf(fileID,'\n');

txt=strcat('G00 Z0.5 ;'); %RAPID BACK IN FRONT OF PART
fprintf(fileID,txt);
fprintf(fileID,'\n');

txt=strcat('(rough pass number',' ',num2str(n),');'); %NEXT PASS
fprintf(fileID,txt);
fprintf(fileID,'\n');
end



txt = 'T3;'; %TOOL 3
fprintf(fileID,txt);
fprintf(fileID,'\n');

txt = strcat('G96 M03 S',S,';'); %CONSTANT SURFACE SPEED, SPINDLE CLCKWISE, SFM
fprintf(fileID,txt);
fprintf(fileID,'\n');

txt = 'G50 S3000 F0.005;'; %SPINDLE SPEED LIMIT
fprintf(fileID,txt);
fprintf(fileID,'\n');

fprintf(fileID,'\n');
fprintf(fileID,'G00 X0 Z.25 ; ');

fprintf(fileID,'(finish pass);');
fprintf(fileID,'\n');
fprintf(fileID,'G01 ');


%GENERATE FINISH PASS THAT IS MANY LINEAR INTERPOLATIONS OF CURVE PROFILE



for n = 1:length(zpoints) 
    if mod(diameter(n),1)== 0 ;
       x = strcat(num2str(diameter(n)),'.');
    else
       x = num2str(diameter(n));
    end

    if mod(zpoints(n),1)== 0 ;
       z = strcat(num2str(zpoints(n)),'.');
    else
       z = num2str(zpoints(n));
    end

txt = strcat('X',x,' Z-',z,' ;');
fprintf(fileID,txt);
fprintf(fileID,'\n');
end

fprintf(fileID,'G53 G00 Z0. X0. ;'); %GO HOME
fprintf(fileID,'\n');

fprintf(fileID,'M30;'); %DONE
fprintf(fileID,'\n');

fclose(fileID);


fprintf('Done! \n');