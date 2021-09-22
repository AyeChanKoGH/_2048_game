class Tile {
  final int value;
  bool merge = false;
  bool isnew = false;
  Tile(this.value, {this.merge = false, this.isnew = false});
}

class Pos {
  final int x, y;
  Pos(this.x, this.y);
}

enum Direction { left, right, up, down }

class Vector {
  final int x, y;
  Vector(this.x, this.y);
  factory Vector.fromDirection(String direction) {
    switch (direction) {
      case 'Up':
        return Vector(1, 0);
      case 'Down':
        return Vector(-1, 0);
      case 'Left':
        return Vector(0, 1);
      case 'Right':
        return Vector(0, -1);
      default:
        return Vector(1, 0);
    }
  }
}

class Order {
  final frow;
  final fcol;
  final lrow;
  final lcol;
  Order(this.frow, this.fcol, this.lrow, this.lcol);
  factory Order.formDirection(String direction, w, h) {
    switch (direction) {
      case 'Up':
        return Order(0, 0, h - 1, w);
      case 'Down':
        return Order(h - 1, w - 1, -1, -1);
      case 'Left':
        return Order(0, 0, h, w - 1);
      case 'Right':
        return Order(h - 1, w - 1, -1, -1);
      default:
        return Order(0, 0, 0, 0);
    }
  }
}
