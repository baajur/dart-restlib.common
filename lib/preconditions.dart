library preconditions;

import "objects.dart";

void checkArgument(final bool test) =>
    (!test) ?  throw new ArgumentError() : null;

void checkRangeInclusive(final int value, final int low, final int high) {
  checkArgument(high > low);
  (value >= low && value <= high) ? null : throw new RangeError("Value out of Range: [$low, $high]");
}

/*<T>*/ checkNotNull(final /*<T>*/ value) => 
    isNotNull(value) ? value : throw new ArgumentError("Argument is null");

void checkState(final bool value) =>
    value ? null : throw new StateError("");
