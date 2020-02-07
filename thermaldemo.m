%Create a thermal model and plot it

model = createpde('thermal')
%create a thermal pde
geo = multicylinder([20,25,35],20,'void',[1,0,0]);
model.Geometry = geo;
pdegplot(model,'CellLabels','on','FaceLabels','on','FaceAlpha',.5)
grid on
%create a 3d object and view its faces

generateMesh(model);
pdemesh(model)
%create a mesh of that info

thermalProperties(model,'Cell',1,'ThermalConductivity',40);
thermalProperties(model,'Cell',2,'ThermalConductivity',.15);
%what are these units?

%now we assign the conductivity of particular cells
thermalBC(model,'Face',7,'Temperature',4);
thermalBC(model,'Face',3,'Temperature',85);
%boundary conditions holds the temperature of a face, so the inside temp of
%the model is 4 and the outside is 85

result = solve(model);
pdeplot3D(model,'ColorMapData',result.Temperature)
