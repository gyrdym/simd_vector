import 'norm.dart';

/// An algebraic vector (ordered set of elements).
abstract class Vector<E> implements Iterable<double> {
  /// Vector's dimension
  int get length;

  /// Indexed access to a vector's element
  double operator [](int index);

  /// Indexed assignment of a value to a vector's element
  void operator []=(int index, double value);

  /// Vector addition (element-wise operation)
  Vector<E> operator +(Vector<E> vector);

  /// Vector subtraction (element-wise operation)
  Vector<E> operator -(Vector<E> vector);

  /// Vector multiplication (element-wise operation)
  Vector<E> operator *(Vector<E> vector);

  /// Element-wise division
  Vector<E> operator /(Vector<E> vector);

  /// Creates a new [Vector] containing elements of this [Vector] raised to the integer [power]
  Vector<E> toIntegerPower(int power);

  /// Performs a vector and a scalar multiplication (each component of a vector is multiplied by [value])
  Vector<E> scalarMul(double value);

  /// Performs a division of a vector by a scalar (each component of a vector is divided by [value])
  Vector<E> scalarDiv(double value);

  /// Performs a vector and a scalar addition ([value] is added to each component of a vector)
  Vector<E> scalarAdd(double value);

  /// Performs subtraction of a vector and a scalar ([value] is subtracted from an each component of a vector )
  Vector<E> scalarSub(double value);

  /// Returns a vector with absolute value of each vector element
  Vector<E> abs();

  /// Returns a copy of a vector
  Vector<E> copy();

  /// Returns a dot (inner) product of [this] and [vector]
  double dot(Vector<E> vector);

  /// Returns a distance between [this] and [vector] with vector norm type considering
  double distanceTo(Vector<E> vector, [Norm norm = Norm.euclidean]);

  /// Returns a mean value of [this] vector
  double mean();

  /// Calculates vector norm (magnitude)
  double norm([Norm norm = Norm.euclidean]);

  /// Returns sum of all elements
  double sum();

  /// Returns maximum element
  double max();

  /// Returns maximum element
  double min();

  /// Returns a vector composed of elements which are located on the passed indexes
  Vector<E> query(Iterable<int> indexes);

  /// Returns a vector composed of unique vector's elements
  Vector<E> unique();

  /// Applies mapper function throughout simd list
  Vector<E> vectorizedMap(E mapper(E element));

  /// cuts out a part of the vector
  Vector<E> subVector(int start, [int end]);
}