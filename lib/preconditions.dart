library restlib.common.preconditions;

import "objects.dart";

final ArgumentError _argumentError = new ArgumentError();

void checkArgument(final bool test) =>
    (!test) ?  throw new ArgumentError() : null;

void checkRangeInclusive(final int value, final int low, final int high) =>
    (value >= low && value <= high) ? null : new RangeError("Value out of Range: [$low, $high]");

/*<T>*/ checkNotNull(final /*<T>*/ value) => 
    isNotNull(value) ? value : new ArgumentError("Argument is null");

void checkState(final bool value) =>
    value ? null : throw new StateError("");
