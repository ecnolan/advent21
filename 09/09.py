
"""
Day 9 of advent of code 2021
Author: Eva Nolan
Objective: find lowpoints (local minima) in grid of numbers
"""
def format_grid(lines):
    """ convert ascii lines into numerical grid (nested array)"""
    grid = []
    line_num = 0
    for line in lines:
        row = []
        for char_index in range(len(line)-1):
            row.append(ord(line[char_index]) - 48)
        grid.append(row)
        line_num += 1
    return grid

def get_neighbors(pt_index, grid):
    """ returns list of indices of neighbors of a point """
    neighbors = []
    (r, c) = pt_index
    (n_rows, n_cols) = (len(grid), len(grid[0]))

    # in each direction, if neighbor in range, save its coordinates
    if r > 0:
        neighbors.append((r - 1, c))
    if c > 0:
        neighbors.append((r, c - 1))
    if r < n_rows - 1:
        neighbors.append((r + 1, c))
    if c < n_cols - 1:
        neighbors.append((r, c + 1))

    return neighbors

def check_low(r, c, grid, dimensions):
    """ checks if grid[r,c] is a lowpoint in the grid
    returns grid value and coords if lowpoint. Returns value 10 otherwise """
    for neighbor_index in get_neighbors((r,c), grid):
        # if not low point, return invalid grid number and its coords
        if grid[r][c] >= grid[neighbor_index[0]][neighbor_index[1]]:
            return (10, (r, c))
    # grid[r][c] is a low point, return its value and coordinates
    return (grid[r][c], (r, c))

def sum(list):
    """ sums items in list """
    sum = 0
    for item in list:
        sum += item
    return sum

def expandbasin(pt_index, grid, basin):
    """ checks neighbors of point in grid (given indices of pt).
    If point not 9 and not counted in basin, adds to basin """
    neighbors = get_neighbors(pt_index, grid)
    for neighbor_index in neighbors:
        (nr, nc) = (neighbor_index)
        # if neighbor should be in basin, add to basin and check its neighbors
        if grid[nr][nc] != 9 and neighbor_index not in basin:
            basin.append(neighbor_index)
            expandbasin(neighbor_index, grid, basin)

def update_biggest(list, n):
    """ update list to be 3 largest basin sizes in order"""
    if n > list[0]:
        return [n, list[0], list[1]]
    if n > list[1]:
        return [list[0], n, list[1]]
    return [list[0], list[1], n]

def main():
    # import data and format from text to numerical grid
    with open('09.txt') as f:
        lines = f.readlines()
    grid = format_grid(lines)
    (n_rows, n_cols) = (len(grid), len(grid[0]))
    dimensions = (n_rows, n_cols)

    # get list of lowpoints
    lowpoints = []
    lowindices = []
    for row in range(n_rows):
        for col in range(n_cols):
            low = check_low(row, col, grid, dimensions)
            if low[0] < 10:
                lowpoints.append(low[0])
                lowindices.append(low[1])

    print(lowpoints)
    print(lowindices)
    risk = sum(lowpoints) + len(lowpoints)
    print(risk)
    basin_sizes = [0, 0, 0]

    # find basin for each low point.
    for lowpt in lowindices:
        basin = [lowpt]
        expandbasin(lowpt, grid, basin)
        if len(basin) > basin_sizes[2]:
            basin_sizes = update_biggest(basin_sizes, len(basin))

    print(basin_sizes[0] * basin_sizes[1] * basin_sizes[2])

main()
