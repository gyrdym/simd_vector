import 'dart:typed_data';

import 'package:ml_linalg/dtype.dart';
import 'package:ml_linalg/src/matrix/iterator/float32_matrix_iterator.dart';
import 'package:ml_linalg/src/matrix/iterator/float64_matrix_iterator.dart';

import 'matrix_iterator_test_group_factory.dart';

void main() {
  matrixIteratorTestGroupFactory(DType.float32,
    (data, rowsNum, colsNum) => Float32MatrixIterator(data, rowsNum, colsNum),
    (data) => Float32List.fromList(data),
  );

  matrixIteratorTestGroupFactory(DType.float64,
    (data, rowsNum, colsNum) => Float64MatrixIterator(data, rowsNum, colsNum),
    (data) => Float64List.fromList(data),
  );
}
