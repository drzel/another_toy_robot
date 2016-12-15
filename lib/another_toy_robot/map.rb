class Map
  GRIDLINES = {
    top:     "┌─┬┐",
    cell:    "│ ││",
    between: "├─┼┤",
    bottom:  "└─┴┘",
  }.freeze

  def initialize(object: nil, arena:)
    @object  = object
    @columns = arena.columns
    @rows    = arena.rows
  end

  def to_s
    grid_top + cell_rows.join(grid_between) + grid_bottom
  end

  private

  def grid_top
    row GRIDLINES[:top]
  end

  def grid_between
    row GRIDLINES[:between]
  end

  def grid_bottom
    row GRIDLINES[:bottom]
  end

  def cell_row(y_coord)
    row GRIDLINES[:cell], y_coord
  end

  def cell_rows
    @rows.reverse_each.map { |y_coord| cell_row y_coord }
  end

  def row(gridlines, y_coord = nil)
    left    = gridlines[0]
    space   = gridlines[1]
    divider = gridlines[2]
    right   = gridlines[3]

    left + cells(space, divider, y_coord) + right + "\n"
  end

  def cells(space, divider, y_coord)
    @columns.map { |x_coord| cell space, x_coord, y_coord }.join divider
  end

  def cell(space, x_coord, y_coord)
    indicator = if x_coord && y_coord && @object.at_coords?(x_coord, y_coord)
                  @object.to_char
                else
                  space
                end
    space + indicator + space
  end
end
