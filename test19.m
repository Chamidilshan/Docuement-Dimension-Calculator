% Read input image
I = imread('document images/doc.jpg');

% Convert image to grayscale
Igray = rgb2gray(I);

% Threshold the image
level = graythresh(Igray);
Ithresh = im2bw(Igray, level);
    
% Edge detection
Iedge = edge(Ithresh, 'canny');

% Dilate the edges
se = strel('rectangle',[5 5]);
Idilate = imdilate(Iedge,se);

% Find the boundaries of the document
boundaries = bwboundaries(Idilate);
b = boundaries{1};
x = b(:,2);
y = b(:,1);

% Calculate width and height of the document
width = max(x) - min(x);
height = max(y) - min(y);

% Convert to cm
conversion_factor = 2.54 / 96;
width_cm = width * conversion_factor;
height_cm = height * conversion_factor;

% Display the output
imshow(I);
hold on;
plot(x, y, 'LineWidth', 2, 'Color', 'r');
text(min(x), min(y), sprintf('Width: %.2f cm\nHeight: %.2f cm', width, height), ...
    'Color', 'r', 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'FontSize', 14);
hold off;
