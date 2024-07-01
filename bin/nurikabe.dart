import 'package:nurikabe/nurikabe.dart';

void main(List<String> arguments) {
  //print('hello world\n');
  /*
    assert(fxd_cell(5, 2, 1)),
    assert(fxd_cell(5, 5, 2)),

    assert(fxd_cell(6, 3, 2)),

    assert(fxd_cell(7, 1, 1)),
    assert(fxd_cell(7, 5, 1)),
    assert(fxd_cell(7, 7, 6)),
  * */
  List<Cell> fixedCells = [
    Cell(0, 1, 3),
    Cell(0, 5, 1),
    Cell(2, 0, 2),
    Cell(2, 3, 1),
    Cell(4, 1, 1),
    Cell(4, 4, 2),
    Cell(5, 2, 2),
    Cell(6, 0, 1),
    Cell(6, 4, 1),
    Cell(6, 6, 6),
  ];
  List<Cell> fixedCells2 = [
    Cell(0, 0, 2),
    Cell(0, 2, 5),
    Cell(4, 2, 4),
    Cell(4, 4, 3),
  ];
  List<Cell> fixedCells3 = [
    Cell(0, 3, 3),
    Cell(2, 0, 1),
    Cell(2, 4, 2),
    Cell(4, 1, 4),
  ];
  List<Cell> fixedCells4 = [
    Cell(1, 3, 1),
    Cell(2, 0, 5),
    Cell(2, 4, 3),
    Cell(3, 1, 2),
  ];
  List<Cell> fixedCellsFinal = [
    Cell(0, 0, 2),
    Cell(0, 2, 3),
    Cell(1, 4, 1),
    Cell(3, 1, 3),
    Cell(3, 3, 1),
    Cell(4, 0, 2),
  ];
  Grid grid = Grid(5, 5, fixedCellsFinal);
/*assert(grid_dimension(5, 5)),
    assert(fxd_cell(1, 1, 2)),
    assert(fxd_cell(1, 3, 3)),

    assert(fxd_cell(2, 5, 1)),

    assert(fxd_cell(4, 2, 3)),
    assert(fxd_cell(4, 4, 1)),

    assert(fxd_cell(5, 1, 2)),*/
  //grid.print();
  grid.solve();
}
