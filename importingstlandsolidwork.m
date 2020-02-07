%Fernando de la Fuente
%3/27/2018
%experimenting with meshes and 3D models
clear
clf
clc


%import an stl file and plot it
plane = createpde(3)
%create a pde (what is this though)

%here i import the solidwork file saved as an stl file

importGeometry(plane,'plane.stl')

%here i plot it
sub1 = subplot(1,2,1)
hold on
grid(sub1,'on')
pdegplot(plane)

%here i can make a mesh out of it
generateMesh(plane)

%here i can plot a mesh of it
sub2 = subplot(1,2,2)
pdeplot3D(plane.Mesh)
hold on
grid(sub2,'on')
%why wont gridlines turn on?