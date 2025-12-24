abstract class Either<L, R>{
  T fold<T>(
    T Function (L l) leftFn,
    T Function (R r) rightFn,
  );
}