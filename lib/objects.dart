library restlib.common.objects;

import "dart:mirrors";
import "collections.dart";
import "collections.immutable.dart";

part "src/objects/forwarder.dart";
part "src/objects/pattern_matching.dart";

const int _HASH_INITIAL_VALUE = 17;
const int _HASH_MULTIPLIER_VALUE = 31;
const Object visibleForTesting = const _VisibleForTesting();

int computeHashCode(final Iterable items) =>
    items.fold(_HASH_INITIAL_VALUE, (int prev, var ele) => 
      _HASH_MULTIPLIER_VALUE * prev + ele.hashCode);

/*<T>*/ computeIfNull(final /*<T>*/first, /*<T>*/second()) => 
    isNotNull(first) ? first : second();

void computeIfNotNull(final value, compute(value))  {
  if(value != null) {
    compute(value);
  }
}

dynamic computeIfNotNullOtherwise(first, second, compute(dyanmic)) =>
    isNull(first) ? second : compute(first);

Predicate equals(final obj) =>
    (final other) =>
        obj == other;

/*<T>*/ firstNotNull(final /*<T>*/first, final /*<T>*/second) {
  if (isNotNull(first)) {
    return first;
  } else if (isNotNull(second)) {
    return second;
  }
  throw new ArgumentError("both arguments are null");
}

bool isFalse(final bool value) => 
    value == false;

bool isNotNull(final value) => 
    !identical(value, null);

bool isNull(final value) =>
    identical(value, null);

bool isTrue(final bool value) => 
    value == true;

String nullToEmpty(final String string) =>
    firstNotNull(string, "");

String objectToString(final dynamic obj) => 
    obj.toString();

class _VisibleForTesting {
  const _VisibleForTesting();
}

class IsInstanceOf<T> implements Function {
  const IsInstanceOf();
  
  bool call(obj) =>
      obj is T;
}