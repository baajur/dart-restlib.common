part of objects;

Try try_(dynamic compute()) {
  try {
    var result = compute();
    return (result is Try) ? result : new _Success(result);
  } catch(e, st) {
    return new _Failure(e, st);
  }
}

abstract class Try<T> {
  T get value;

  Try then(f(T element), {Function onError});

  Try catchError(Function onError, {bool test(error)});
}

class _Success<T> implements Try<T> {
  final T value;

  _Success(this.value);

  Try then(f(T element), {Function onError}) =>
      try_(f(value));

  Try catchError(Function onError,{bool test(error)}) =>
      this;

  Option<T> toOption() =>
      new Option(value);
}

typedef dynamic _Failure2(var e, StackTrace st);

class _Failure<T> implements Try<T> {
  final e;
  final StackTrace st;

  _Failure(this.e, this.st);

  T get value =>
      throw new UnhandledError._(e, st);

  Try then(f(T element), {Function onError}) =>
      isNotNull(onError) ? catchError(onError) : this;

  Try catchError(Function onError, {bool test(error)}) {
    if (isNotNull(test)) {
      return test(e) ? try_(() => (onError is _Failure2) ? onError(e, st) : onError(e)) : this;
    }

    return try_(() => (onError is _Failure2) ? onError(e, st) : onError(e));
  }


  Option<T> toOption() =>
      Option.NONE;
}

class UnhandledError extends Error {
  final e;
  final StackTrace stackTrace;

  UnhandledError._(this.e, this.stackTrace);
}