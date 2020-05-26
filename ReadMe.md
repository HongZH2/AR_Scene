# Project 2 
# Course: Computer Vision, Spring 2020, CSE.

# Coder: Hong Zhang (Part 1)
# email: hmz5180@psu.edu
## Part 1 Descripsion:
1. run Colmap, get the data file and point cloud (sparse and dense).
2. fit a dominant plane in the point cloud and compute the parameters of plane in the world coordinate.
3. read/display 3D object .
4. design a coordinate in the dominant that we 'd like to place the object 
5. build the object local coordinate
6. place the 3D object on the designed position in the dominant plane by computing transformation matrix between object coordinate and world coordinate.

## How To Run：
## Run the Script (main.m) in Matlab 2019b directly.
## Lower Matlab version with pcread() and pcshow() will be okay and Computer Vision Package is essential.

## File:
### matlab scripts : 
1. -- dominant_plane_finding.m (running script)
2. -- RANSAC_PlaneFitting.m (function to find a dominant plane)
3. -- compute_plane_parameter.m (function to compute the plane parameters after RANSAC)
4. -- build_object_coordinate.m (function to build a object local object and origin in the dominant plane)
5. -- transform_3Dobject.m (function to compute the transformation matrix between object local coordinate and  the designed coordinate in the dominant plane)

## Data (get from COLMAP):
1. --- Data/fused.ply (Dense Point Cloud)
2. --- Data/camera.txt
3. --- Data/images.txt
4. --- Data/points3D.txt (Sparse Point Cloud)

## Supplemantal Functions and Files:

### Directory: './3Dmodel' (download from https://www.turbosquid.com/Search/3D-Models/free?page_num=7)
1. --- chicken_01.obj : 3d model
2. --- chicken_01.jpg: texturemap
### Directory './OBJRead/' 
### cite from https://www.mathworks.com/matlabcentral/fileexchange/18957-readobj
### https://www.mathworks.com/matlabcentral/fileexchange/20307-display_obj

1. --- readObj.m : Read 3D model .obj file
2. --- display_obj.m : to display the object




# Coder: Shimian Zhang 
# email: svz5303@psu.edu
## Part 2 Descripsion:
1. read camera internal and external parameters from Colmap running result.
2. compute camera pose (orientation + location) from the external parameter.
3. display poses of each camera on a 3D figure.
4. project the 3D object vertices from world coordinate to camera coordinate. 
5. use Z-buffer concept to fill each face of the 3D object, together with the corresponding image taken by each camera.

## File:
### matlab scripts : 
1. -- camera_projecting.m (running script)
2. -- loadCameraParas.m (function to read camera internal and external parameters)
3. -- Projection.m (function to do projection of a 3D object by a specific camera parameter)
4. -- WorldToImage.m (function to do projection of a single point from world coordinate to a 2D camera coordinate)

## Data (get from COLMAP):
1. --- Data/camera.txt
2. --- Data/images.txt
3. --- Data/dataset/xxx.jpeg (Original images taken by the same camera in different poses)
