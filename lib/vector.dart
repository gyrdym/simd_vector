import 'dart:typed_data';

import 'package:ml_linalg/distance.dart';
import 'package:ml_linalg/dtype.dart';
import 'package:ml_linalg/norm.dart';
import 'package:ml_linalg/src/common/cache_manager/cache_manager_factory.dart';
import 'package:ml_linalg/src/di/dependencies.dart';
import 'package:ml_linalg/src/vector/float32x4_vector.dart';
import 'package:ml_linalg/src/vector/float64x2_vector.gen.dart';

final _cacheManagerFactory = dependencies.getDependency<CacheManagerFactory>();

/// An algebraic vector with SIMD (single instruction, multiple data)
/// architecture support
///
/// The vector's components are contained in a special typed data structure,
/// that allows to perform vector operations extremely fast due to hardware
/// assisted computations.
abstract class Vector implements Iterable<double> {
  /// Creates a vector from a collection [source].
  ///
  /// It converts the collection of [double]-type elements into a collection of
  /// [Float32x4] elements.
  factory Vector.fromList(List<num> source, {
    DType dtype = DType.float32,
  }) {
    switch (dtype) {
      case DType.float32:
        return Float32x4Vector.fromList(source, _cacheManagerFactory.create());

      case DType.float64:
        return Float64x2Vector.fromList(source, _cacheManagerFactory.create());

      default:
        throw UnimplementedError('Vector of $dtype type is not implemented yet');
    }
  }

  factory Vector.fromSimdList(List source, int actualLength, {
    DType dtype = DType.float32,
  }) {
    switch (dtype) {
      case DType.float32:
        return Float32x4Vector.fromSimdList(
          source as Float32x4List,
          actualLength,
          _cacheManagerFactory.create(),
        );

      case DType.float64:
        return Float64x2Vector.fromSimdList(
          source as Float64x2List,
          actualLength,
          _cacheManagerFactory.create(),
        );

      default:
        throw UnimplementedError('Vector of $dtype type is not implemented yet');
    }
  }

  /// Creates a vector of length equal to [length], filled with [value].
  factory Vector.filled(int length, num value, {
    DType dtype = DType.float32,
  }) {
    switch (dtype) {
      case DType.float32:
        return Float32x4Vector.filled(
          length,
          value,
          _cacheManagerFactory.create(),
        );

      case DType.float64:
        return Float64x2Vector.filled(
          length,
          value,
          _cacheManagerFactory.create(),
        );

      default:
        throw UnimplementedError('Vector of $dtype type is not implemented yet');
    }
  }

  /// Creates a vector of length equal to [length], filled with zeroes.
  factory Vector.zero(int length, {
    DType dtype = DType.float32,
  }) {
    switch (dtype) {
      case DType.float32:
        return Float32x4Vector.zero(
          length,
          _cacheManagerFactory.create(),
        );

      case DType.float64:
        return Float64x2Vector.zero(
          length,
          _cacheManagerFactory.create(),
        );

      default:
        throw UnimplementedError('Vector of $dtype type is not implemented yet');
    }
  }

  /// Creates a vector of length, equal to [length], filled with random values,
  /// which are bound by interval from [min] (inclusive) tp [max] (exclusive).
  /// If [min] greater than [max] when [min] becomes [max]
  /// generated from randomizer with seed, equal to [seed].
  factory Vector.randomFilled(int length, {
    int seed = 1,
    num min = 0,
    num max = 1,
    DType dtype = DType.float32,
  }) {
    switch (dtype) {
      case DType.float32:
        return Float32x4Vector.randomFilled(
          length,
          seed,
          _cacheManagerFactory.create(),
          max: max,
          min: min,
        );

      case DType.float64:
        return Float64x2Vector.randomFilled(
          length,
          seed,
          _cacheManagerFactory.create(),
          max: max,
          min: min,
        );

      default:
        throw UnimplementedError('Vector of $dtype type is not implemented yet');
    }
  }

  /// Creates a vector of zero length
  factory Vector.empty({DType dtype = DType.float32}) {
    switch (dtype) {
      case DType.float32:
        return Float32x4Vector.empty(_cacheManagerFactory.create());

      case DType.float64:
        return Float64x2Vector.empty(_cacheManagerFactory.create());

      default:
        throw UnimplementedError('Vector of $dtype type is not implemented yet');
    }
  }

  DType get dtype;

  /// Returns an element by its position in the vector
  double operator [](int index);

  /// Vector addition (element-wise operation)
  Vector operator +(Object value);

  /// Vector subtraction (element-wise operation)
  Vector operator -(Object value);

  /// Vector multiplication (element-wise operation)
  Vector operator *(Object value);

  /// Element-wise division
  Vector operator /(Object value);

  /// Returns a new [Vector] consisting of square roots of elements of this
  /// [Vector]
  Vector sqrt({bool skipCaching = false});

  /// Returns a new [Vector] where elements are the elements from this [Vector]
  /// divided by [scalar]
  Vector scalarDiv(num scalar);

  /// Creates a new [Vector] containing elements of this [Vector] raised to
  /// the integer [exponent]
  Vector toIntegerPower(int exponent);

  /// Returns a new vector with absolute value of each vector element
  Vector abs({bool skipCaching = false});

  /// Returns a dot (inner) product of [this] and [vector]
  double dot(Vector vector);

  /// Returns a distance between [this] and [vector]
  double distanceTo(Vector vector, {
    Distance distance = Distance.euclidean,
  });

  /// Returns cosine of the angle between [this] and [other] vector
  double getCosine(Vector other);

  /// Returns a mean value of [this] vector
  double mean({bool skipCaching = false});

  /// Calculates vector norm (magnitude)
  double norm([Norm norm = Norm.euclidean, bool skipCaching = false]);

  /// Returns sum of all elements
  double sum({bool skipCaching = false});

  /// Returns maximum element
  double max({bool skipCaching = false});

  /// Returns maximum element
  double min({bool skipCaching = false});

  /// Returns a new vector composed of elements which are located on the passed
  /// indexes
  Vector sample(Iterable<int> indices);

  /// Returns a new vector composed of the vector's unique elements
  Vector unique({bool skipCaching = false});

  /// Returns a new vector with normalized values of [this] vector
  Vector normalize([Norm norm = Norm.euclidean, bool skipCaching = false]);

  /// Returns rescaled (min-max normed) version of this vector
  Vector rescale({bool skipCaching = false});

  Vector fastMap<T>(T mapper(T element));

  /// Returns a new vector formed by a specific part of [this] vector
  Vector subvector(int start, [int end]);
}
