class MoveShape {
  moveLeft(shape, shapeData) {
    if (!(shapeData.containsKey(shape[0] - 1) ||
        shapeData.containsKey(shape[1] - 1) ||
        shapeData.containsKey(shape[2] - 1) ||
        shapeData.containsKey(shape[3] - 1))) {
      if (shape[0] % 10 != 0 &&
          shape[1] % 10 != 0 &&
          shape[2] % 10 != 0 &&
          shape[3] % 10 != 0) {
        shape = [
          shape[0] - 1,
          shape[1] - 1,
          shape[2] - 1,
          shape[3] - 1,
        ];
      }
    }
    return shape;
  }

  moveRight(shape, shapeData) {
    if (!(shapeData.containsKey(shape[0] + 1) ||
        shapeData.containsKey(shape[1] + 1) ||
        shapeData.containsKey(shape[2] + 1) ||
        shapeData.containsKey(shape[3] + 1))) {
      if (shape[0] % 10 != 9 &&
          shape[1] % 10 != 9 &&
          shape[2] % 10 != 9 &&
          shape[3] % 10 != 9) {
        shape = [
          shape[0] + 1,
          shape[1] + 1,
          shape[2] + 1,
          shape[3] + 1,
        ];
      }
    }
    return shape;
  }
}
