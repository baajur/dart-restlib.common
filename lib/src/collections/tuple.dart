part of collections;

abstract class Tuple<T> implements Iterable<T> {
  static const None NONE = const _None();

  static Some create1(final value) =>
      new _Some(checkNotNull(value));

  static Pair create2(final e0, final e1) =>
      new Pair(e0, e1);

  static Tuple3 create3(final e0, final e1, final e2) =>
      new Tuple3(e0, e1, e2);

  static Tuple4 create4(final e0, final e1, final e2, final e3) =>
      new Tuple4(e0, e1, e2, e3);

  static Tuple5 create5(final e0, final e1, final e2, final e3, final e4) =>
      new Tuple5(e0, e1, e2, e3, e4);

  static Tuple6 create6(final e0, final e1, final e2, final e3, final e4, final e5) =>
      new Tuple6(e0, e1, e2, e3, e4, e5);

  static Tuple create(final Iterable ele) {
    checkNotNull(ele);
    switch (ele.length) {
      case 0:
        return NONE;
      case 1:
        return create1(ele.first);
      case 2:
        return create2(ele.elementAt(0), ele.elementAt(1));
      case 3:
        return create3(ele.elementAt(0), ele.elementAt(1), ele.elementAt(2));
      case 4:
        return create4(ele.elementAt(0), ele.elementAt(1), ele.elementAt(2), ele.elementAt(3));
      case 5:
        return create5(ele.elementAt(0), ele.elementAt(1), ele.elementAt(2), ele.elementAt(3), ele.elementAt(4));
      case 6:
        return create6(ele.elementAt(0), ele.elementAt(1), ele.elementAt(2), ele.elementAt(3), ele.elementAt(4), ele.elementAt(5));
      default:
        return new _TupleRest(
            ele.elementAt(0), ele.elementAt(1), ele.elementAt(2), ele.elementAt(3), ele.elementAt(4), ele.elementAt(5), create(ele.skip(6)));
    }
  }
}

abstract class None implements Tuple, Option{}

abstract class Some<T> implements Tuple<T>, Option<T> {
  T get e0;
}

abstract class Pair<T0, T1> implements Tuple {
  factory Pair(final T0 e0, final T1 e1) =>
      new _Pair(checkNotNull(e0), checkNotNull(e1));

  T0 get e0;
  T1 get e1;
}

abstract class Tuple3<T0, T1, T2> implements Tuple {
  factory Tuple3(final T0 e0, final T1 e1, final T2 e2) =>
      new _Tuple3(checkNotNull(e0), checkNotNull(e1), checkNotNull(e2));

  T0 get e0;
  T1 get e1;
  T2 get e2;
}

abstract class Tuple4<T0, T1, T2, T3> implements Tuple {
  factory Tuple4(final T0 e0, final T1 e1, final T2 e2, final T3 e3) =>
      new _Tuple4(checkNotNull(e0), checkNotNull(e1), checkNotNull(e2), checkNotNull(e3));

  T0 get e0;
  T1 get e1;
  T2 get e2;
  T3 get e3;
}

abstract class Tuple5<T0, T1, T2, T3, T4> implements Tuple {
  factory Tuple5(final T0 e0, final T1 e1, final T2 e2, final T3 e3, T4 e4) =>
        new _Tuple5(checkNotNull(e0), checkNotNull(e1), checkNotNull(e2), checkNotNull(e3), checkNotNull(e4));

  T0 get e0;
  T1 get e1;
  T2 get e2;
  T3 get e3;
  T4 get e4;
}

abstract class Tuple6<T0, T1, T2, T3, T4, T5> implements Tuple {
  factory Tuple6(final T0 e0, final T1 e1, final T2 e2, final T3 e3, T4 e4, T5 e5) =>
        new _Tuple6(checkNotNull(e0), checkNotNull(e1), checkNotNull(e2), checkNotNull(e3), checkNotNull(e4), checkNotNull(e5));

  T0 get e0;
  T1 get e1;
  T2 get e2;
  T3 get e3;
  T4 get e4;
  T5 get e5;
}

abstract class TupleRest<T0, T1, T2, T3, T4, T5, TRest extends Tuple> implements Tuple {
  factory TupleRest(final T0 e0, final T1 e1, final T2 e2, final T3 e3, T4 e4, T5 e5, TRest rest) =>
        new _TupleRest(checkNotNull(e0), checkNotNull(e1), checkNotNull(e2), checkNotNull(e3), checkNotNull(e4), checkNotNull(e5), checkNotNull(rest));

  T0 get e0;
  T1 get e1;
  T2 get e2;
  T3 get e3;
  T4 get e4;
  T5 get e5;
  TRest get rest;
}
