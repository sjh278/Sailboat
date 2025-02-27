%% Parameters for program
% some cities
NYC = [40.7, -74.0];
London = [51.5, -0.1];
Lisbon = [38.7, -9.1];
Paris = [48.9, 2.3];
Algiers = [36.8, 3.2];
MexicoCity = [19.4, -99.1];
Houston = [31.0, -100];
TelAviv = [32.1, 34.8];
Barcelona = [41.2, 2.2];
Osaka = [34.6, 135.5];

% bounding box for the atlantic ocean
NorthAtlantic = [-83.2,22.0,0.3,58.8];
Mediterranean = [-11.4,28.1,45.8,49.9];
Custom = [-100,10,0.3,58.8];
Custom2 = [-104.1,12.2,45.6,55.2];
Israel2Japan = [-28.3,-39.9,162.0,47.8];

%% Inputs to program
% resolution is the number of degrees between each node
resolution = 10;
% bounding box for nodes. smaller = faster
bounds = Custom2;
% source and destination cities
source = Houston; dest = TelAviv;

%% Calculate shortest path
% get coordinates of each node
[coordinates, numNodes] = genCoord3D(bounds, resolution);

% remove land nodes
[nodeMatrix, numNodes] = removeLandNodes([(1:numNodes)' coordinates], numNodes);

% calculate shortest path after calculating closest nodes to input cities
bestFitNodes = knnsearch(nodeMatrix(:, 2:3), [source; dest]);
[path] = genPath(nodeMatrix, bestFitNodes, resolution);


%% Plot shortest path
drawGlobe()
% show nodes (decreases performance)
% showPoints3D([nodeMatrix(:, 2) nodeMatrix(:, 3)]);

% plot the waypoints in the part
waypoints = nodeMatrix(path, 2:3);
plotWaypoints(waypoints);


%% Plot wind vectors

% 4 times of day available
srcFiles = dir('/Volumes/Macintosh Extension/Documents Extension/GitHub/Sailboat/Navigation/Data/*.nc');
for i = 1:length(srcFiles)
    for timeFactor = 1:4
        fileName = strcat('/Volumes/Macintosh Extension/Documents Extension/GitHub/Sailboat/Navigation/Data/', srcFiles(i).name);
        a = plotWind(fileName, bounds, resolution, timeFactor);
        pause(.1)
        delete(a)
    end
end