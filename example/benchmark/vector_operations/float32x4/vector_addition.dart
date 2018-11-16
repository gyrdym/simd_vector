// Performance test of vector (10 000 000 elements in vector) addition operation
// It takes approximately 1.3 second (MacBook Air mid 2017)

import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:linalg/src/simd/simd_vector.dart';

const amountOfElements = 10000000;

SIMDVector vector1;
SIMDVector vector2;

class VectorAdditionBenchmark extends BenchmarkBase {
  const VectorAdditionBenchmark() : super('Vectors addition, $amountOfElements elements');

  static void main() {
    const VectorAdditionBenchmark().report();
  }

  @override
  void run() {
    // ignore: unnecessary_statements
    vector1 + vector2;
  }

  @override
  void setup() {
    vector1 = SIMDVector.randomFilled(amountOfElements);
    vector2 = SIMDVector.randomFilled(amountOfElements);
  }

  void tearDown() {
    vector1 = null;
    vector2 = null;
  }
}

void main() {
  VectorAdditionBenchmark.main();
}