import 'dart:io';
import 'constants.dart';

class Cell {
  late final int i;
  late final int j;
  late int v;

  Cell(this.i, this.j, this.v);

  @override
  String toString() {
    return 'Cell{i: $i, j: $j, v: $v}';
  }
}

class Grid {
  late List<List<Cell>> _grid;

  late final int _rows;
  late final int _columns;

  late List<Cell> fixedCells;

  Grid(this._rows, this._columns, this.fixedCells) {
    _grid = List.generate(
        _rows,
        (index) =>
            List.generate(_columns, (index2) => Cell(index, index2, -1)));
    for (int e = 0; e < fixedCells.length; e++) {
      var t = fixedCells[e];
      _grid[t.i][t.j] = Cell(t.i, t.j, t.v);
    }
  }

  bool _validPosition(int r, int c) {
    return r >= 0 && r < _rows && c >= 0 && c < _columns;
  }

  List<dynamic> _adjacentCells(Cell c) {
    return [
      c.i - 1 >= 0 ? Cell(c.i - 1, c.j, c.v) : -1,
      c.i + 1 < _rows ? Cell(c.i + 1, c.j, c.v) : -1,
      c.j - 1 >= 0 ? Cell(c.i, c.j - 1, c.v) : -1,
      c.j + 1 < _columns ? Cell(c.i, c.j + 1, c.v) : -1,
    ];
  }

  List<dynamic> _rightAndDownAdjacentCells2(Cell c) {
    return [
      c.j + 2 < _columns ? Cell(c.i, c.j + 2, _grid[c.i][c.j + 2].v) : -1,
      c.i + 2 < _rows ? Cell(c.i + 2, c.j, _grid[c.i + 2][c.j].v) : -1,
    ];
  }

  List<dynamic> _rightAndDownAdjacentCells(Cell c) {
    return [
      c.j + 1 < _columns ? Cell(c.i, c.j + 1, _grid[c.i][c.j + 1].v) : -1,
      c.i + 1 < _rows ? Cell(c.i + 1, c.j, _grid[c.i + 1][c.j].v) : -1,
    ];
  }

  _fillWithSea(List<dynamic> m) {
    for (var e in m) {
      if (e != -1) {
        _grid[e.i][e.j].v = -2;
      }
    }
  }

  _surroundCell1WithSea() {
    for (var e in fixedCells) {
      if (e.v == 1) {
        _fillWithSea(_adjacentCells(e));
      }
    }
  }

  _fillEmptyCellBetweenTwoFixedCells() {
    for (var e in fixedCells) {
      var adj = _rightAndDownAdjacentCells2(e);
      var right = adj[0];
      var down = adj[1];
      //stdout.write('$e: $right, $down\n');
      if (right != -1 && right.v > -1) {
        _grid[right.i][right.j - 1].v = -2;
      }
      if (down != -1 && down.v > -1) {
        _grid[down.i - 1][down.j].v = -2;
      }
    }
  }

  _fillRightAndDownOfTwoDiagonallyAdjacentFixedCells() {
    for (var e in fixedCells) {
      var adj = _rightAndDownAdjacentCells(e);
      if (_validPosition(e.i + 1, e.j + 1) && _grid[e.i + 1][e.j + 1].v > -1) {
        _fillWithSea(adj);
      }
    }
  }

  _printCell(Cell c) {
    if (c.v == -1) {
      printRed('n');
      stdout.write('   |  ');
    } else if (c.v == -2) {
      printBlue('B');
      stdout.write('   |  ');
    } else if (c.v > -1) {
      printGreen('${c.v}');
      stdout.write('   |  ');
    }
  }

  _printDashes() {
    stdout.write('    ');
    for (int i = 0; i < _rows * 2.15; i++) {
      stdout.write('___');
    }
  }

  _printRows() {
    stdout.write('     ');
    for (int i = 0; i < _rows; i++) {
      //stdout.write('0${i.toString()}  |  ');
      printYellow('0${i.toString()}  |  ');
    }
    //stdout.write('\n');
  }

  _printForComparison(List<List<Cell>> before, List<List<Cell>> after) {
    _printRows();
    stdout.write('\t');
    _printRows();
    stdout.write('\n');

    for (int i = 0; i < _rows; i++) {
      _printDashes();
      stdout.write('\t\t');
      _printDashes();
      stdout.write('\n');
      printYellow('0${i.toString()}   ');
      for (int j = 0; j < _columns; j++) {
        _printCell(before[i][j]);
      }
      stdout.write('\t');
      printYellow('0${i.toString()}   ');
      for (int j = 0; j < _columns; j++) {
        _printCell(after[i][j]);
      }
      stdout.write('\n');
    }
  }

  void print() {
    _printRows();
    stdout.write('\n');
    for (int i = 0; i < _rows; i++) {
      _printDashes();
      stdout.write('\n');
      printYellow('0${i.toString()}   ');
      for (int j = 0; j < _columns; j++) {
        //stdout.write('${_grid[i][j]}  |  ');
        _printCell(_grid[i][j]);
      }
      stdout.write('\n');
    }
    _printDashes();
  }

  List<List<Cell>> _copyGrid() {
    List<List<Cell>> copied = List.generate(
        _rows,
        (index) => List.generate(
            _columns,
            (index2) => Cell(_grid[index][index2].i, _grid[index][index2].j,
                _grid[index][index2].v)));
    return copied;
  }

  void solve() {
    List<List<Cell>> before = _copyGrid();

    _surroundCell1WithSea();

    _printForComparison(before, _grid);
    stdout.write('\n\n');
    before = _copyGrid();

    _fillEmptyCellBetweenTwoFixedCells();

    _printForComparison(before, _grid);
    stdout.write('\n\n');
    before = _copyGrid();

    _fillRightAndDownOfTwoDiagonallyAdjacentFixedCells();
    _printForComparison(before, _grid);
    stdout.write('\n\n');

    //print();
  }
}
