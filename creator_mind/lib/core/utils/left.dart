
import 'package:creator_mind/core/utils/either.dart';

class Left<L, R> extends Either<L, R>{
  final L value;
  Left(this.value);


@override
  T fold<T>(T Function(L l) leftFn, T Function(R r) rightFn) {
    return leftFn(value);
  }
}