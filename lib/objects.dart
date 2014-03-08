library objects;

import "dart:mirrors";
import "collections.dart";
import "collections.immutable.dart";
import "preconditions.dart";

part "src/objects/curry.dart";
part "src/objects/forwarder.dart";
part "src/objects/pattern_matching.dart";

typedef bool Predicate(dynamic object);

const int _HASH_INITIAL_VALUE = 17;
const int _HASH_MULTIPLIER_VALUE = 31;

const Object visibleForTesting = const _VisibleForTesting();
const Object internal = const _Internal();

int computeHashCode(final Iterable items) =>
    items.fold(_HASH_INITIAL_VALUE, (int prev, var ele) =>
      _HASH_MULTIPLIER_VALUE * prev + ele.hashCode);

/*<T>*/ computeIfNull(final /*<T>*/first, /*<T>*/second()) =>
    isNotNull(first) ? first : second();

Option computeIfNotNull(final value, compute(value)) =>
    isNotNull(value) ?  new Option(compute(value)) : Option.NONE;

Function curry(final Function function, [Iterable positionalParameters = EMPTY_LIST, Map<Symbol, dynamic> namedArguments = const{}]) =>
    new _Curry(checkNotNull(function), checkNotNull(positionalParameters), checkNotNull(namedArguments));

Function curry0(final Function function, [Iterable positionalParameters = EMPTY_LIST, Map<Symbol, dynamic> namedArguments = const{}]) {
  dynamic func = curry(function, positionalParameters, namedArguments);
  return () => func();
}

Function curry1(final Function function, [Iterable positionalParameters = EMPTY_LIST, Map<Symbol, dynamic> namedArguments = const{}]) {
  dynamic func = curry(function, positionalParameters, namedArguments);
  return (arg) => func(arg);
}

Function curry2(final Function function, [Iterable positionalParameters = EMPTY_LIST, Map<Symbol, dynamic> namedArguments = const{}]) {
  dynamic func = curry(function, positionalParameters, namedArguments);
  return (arg1, arg2) => func(arg1, arg2);
}

Function curry3(final Function function, [Iterable positionalParameters = EMPTY_LIST, Map<Symbol, dynamic> namedArguments = const{}]) {
  dynamic func = curry(function, positionalParameters, namedArguments);
  return (arg1, arg2, arg3) => func(arg1, arg2, arg3);
}

Function curry4(final Function function, [Iterable positionalParameters = EMPTY_LIST, Map<Symbol, dynamic> namedArguments = const{}]) {
  dynamic func = curry(function, positionalParameters, namedArguments);
  return (arg1, arg2, arg3, arg4) => func(arg1, arg2, arg3, arg4);
}

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

dynamic identity(final obj) =>
    obj;

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

class _Internal {
  const _Internal();
}

class IsInstanceOf<T> {
  const IsInstanceOf();

  bool call(obj) =>
      obj is T;
}