function y = make_grid(size_of_grid, frequency_of_lines)
%size_of_grid = the height of the line measured starting at 0
%frequency_of_lines = %distance between grid lines

figure; hold on;
%for loop will graph x and y lines, limited by size of grid, which 
%is the distance from 0 to the end in horiz. or vert. direction
for grid_line = -size_of_grid : frequency_of_lines : size_of_grid
    plot([grid_line grid_line], [-size_of_grid size_of_grid], 'k');  %plots vertical lines
    plot([-size_of_grid size_of_grid], [grid_line grid_line], 'k');  %plots horizontal lines
end
end

