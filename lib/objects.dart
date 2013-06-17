library restlib.common.objects;

import "dart:mirrors";

import "preconditions.dart";

part "src/objects/forwarder.dart";

const int _HASH_INITIAL_VALUE = 17;
const int _HASH_MULTIPLIER_VALUE = 31;

int computeHashCode(final Iterable items) {
  checkNotNull(items);

  return items.fold(_HASH_INITIAL_VALUE, (int prev, var ele) => 
      _HASH_MULTIPLIER_VALUE * prev + ele.hashCode);
}

/*<T>*/ computeIfNull(final /*<T>*/first, /*<T>*/second()) {
  return isNotNull(first) ? first : second();
}

/*<T>*/ firstNotNull(final /*<T>*/first, final /*<T>*/second) {
  if (isNotNull(first)) {
    return first;
  } else if (isNotNull(second)) {
    return second;
  }
  throw new ArgumentError("both arguments are null");
}

bool isFalse(final bool value) => value == false;
bool isNotNull(final value) => !identical(value, null);
bool isNull(final value) => identical(value, null);
bool isTrue(final bool value) => value == true;