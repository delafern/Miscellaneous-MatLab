%Create a thermal model and plot it
clear;clc;clf;close all

model = createpde('thermal');
%create a thermal pde

%import our mini motor geometry
%NEED to make sure all bodies are united, no holes in model, etc.
stl_file = importGeometry(model,'0002-501-1.stl');
model.Geometry = stl_file;

%plot and label the model with the cells labeled
figure
pdegplot(model,'CellLabels','on','FaceAlpha',.25);
grid on
%need to look at the model to determine what cells are what
%is there a better way to differentiate these guys

%now get the faces, as this is where we will apply boundary condition
%temperatures
figure
pdegplot(model,'FaceLabels','on','FaceAlpha',.5)

%generate that mesh
figure
generateMesh(model)
pdemesh(model)

%declare thermal conductivity for each part in the model
for n = 1:stl_file.NumCells
    tc = input(['Thermal Conductivity Cell ', num2str(n), ':']);
    thermalProperties(model,'Cell',n,'ThermalConductivity',tc);
end

%make a menu to ask for faces where we will apply temperatures

thermalBC(model,'Face',7,'Temperature',4);
thermalBC(model,'Face',3,'Temperature',85);
%boundary conditions holds the temperature of a face, so the inside temp of
%the model is 4 and the outside is 85

result = solve(model);
figure
pdeplot3D(model,'ColorMapData',result.Temperature,'FaceAlpha',.5)