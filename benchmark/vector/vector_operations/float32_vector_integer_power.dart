// Approx. 2 seconds (MacBook Air mid 2017)

import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:ml_linalg/vector.dart';

const amountOfElements = 10000000;

class VectorIntegerPowerBenchmark extends BenchmarkBase {
  VectorIntegerPowerBenchmark()
      : super('Vector integer power, $amountOfElements elements');

  Vector vector;

  static void main() {
    VectorIntegerPowerBenchmark().report();
  }

  @override
  void run() {
    vector.toIntegerPower(1234);
  }

  @override
  void setup() {
    vector = Vector.randomFilled(amountOfElements,
      seed: 1,
      min: -1000,
      max: 1000,
    );
  }
}

void main() {
  VectorIntegerPowerBenchmark.main();
}