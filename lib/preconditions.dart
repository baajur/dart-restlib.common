library restlib.common.preconditions;

import "objects.dart";

final ArgumentError _argumentError = new ArgumentError();
final ArgumentError _nullPointerError = new ArgumentError("Argument is null");

/*<T>*/ checkArgument(final /*<T>*/ value, [bool predicate(/*<T>*/ value) = isTrue, exception()]) {
  if (!predicate(value)) {
    if (isNotNull(exception)) {
      throw exception();
    } else {
      throw _argumentError;
    }
  }
  return value;
}

/*<T>*/ checkRangeInclusive(final int value, final int low, final int high) =>
    checkArgument(
        value, 
        (value) => (value >= low && value <= high), 
        () => new RangeError("Value out of Range: [$low, $high]"));

/*<T>*/ checkNotNull(final /*<T>*/ value, [exception()]) => 
    checkArgument(
        value, 
        (value) => isNotNull(value), 
        firstNotNull(exception, () => _nullPointerError));
