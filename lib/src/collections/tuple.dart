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

  static Tuple7 create7(final e0, final e1, final e2, final e3, final e4, final e5, final e6) =>
      new Tuple7(e0, e1, e2, e3, e4, e5, e6);

  static Tuple8 create8(final e0, final e1, final e2, final e3, final e4, final e5, final e6, final e7) =>
      new Tuple8(e0, e1, e2, e3, e4, e5, e6, e7);

  static Tuple9 create9(final e0, final e1, final e2, final e3, final e4, final e5, final e6, final e7, final e8) =>
      new Tuple9(e0, e1, e2, e3, e4, e5, e6, e7, e8);

  static Tuple10 create10(final e0, final e1, final e2, final e3, final e4, final e5, final e6, final e7, final e8, final e9) =>
      new Tuple10(e0, e1, e2, e3, e4, e5, e6, e7, e8,e9);

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
      case 7:
        return create7(ele.elementAt(0), ele.elementAt(1), ele.elementAt(2), ele.elementAt(3), ele.elementAt(4), ele.elementAt(5), ele.elementAt(6));
      case 8:
        return create8(ele.elementAt(0), ele.elementAt(1), ele.elementAt(2), ele.elementAt(3), ele.elementAt(4), ele.elementAt(5), ele.elementAt(6), ele.elementAt(7));
      case 9:
        return create9(ele.elementAt(0), ele.elementAt(1), ele.elementAt(2), ele.elementAt(3), ele.elementAt(4), ele.elementAt(5), ele.elementAt(6), ele.elementAt(7), ele.elementAt(8));
      case 10:
        return create10(ele.elementAt(0), ele.elementAt(1), ele.elementAt(2), ele.elementAt(3), ele.elementAt(4), ele.elementAt(5), ele.elementAt(6), ele.elementAt(7), ele.elementAt(8), ele.elementAt(9));
      default:
        return new TupleN(ele.elementAt(0), ele.elementAt(1), ele.elementAt(2), ele.elementAt(3), ele.elementAt(4), ele.elementAt(5), ele.elementAt(6), ele.elementAt(7), ele.elementAt(8), ele.elementAt(9), create(ele.skip(6)));
    }
  }
}

abstract class None implements Option{}

abstract class Some<T> implements Option<T> {
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

abstract class Tuple7<T0, T1, T2, T3, T4, T5, T6> implements Tuple {
  factory Tuple7(final T0 e0, final T1 e1, final T2 e2, final T3 e3, T4 e4, T5 e5, T6 e6) =>
        new _Tuple7(checkNotNull(e0), checkNotNull(e1), checkNotNull(e2), checkNotNull(e3), checkNotNull(e4), checkNotNull(e5), checkNotNull(e6));

  T0 get e0;
  T1 get e1;
  T2 get e2;
  T3 get e3;
  T4 get e4;
  T5 get e5;
  T6 get e6;
}

abstract class Tuple8<T0, T1, T2, T3, T4, T5, T6, T7> implements Tuple {
  factory Tuple8(final T0 e0, final T1 e1, final T2 e2, final T3 e3, final T4 e4, final T5 e5, final T6 e6, final T7 e7) =>
        new _Tuple8(checkNotNull(e0), checkNotNull(e1), checkNotNull(e2), checkNotNull(e3), checkNotNull(e4), checkNotNull(e5), checkNotNull(e6), checkNotNull(e7));

  T0 get e0;
  T1 get e1;
  T2 get e2;
  T3 get e3;
  T4 get e4;
  T5 get e5;
  T6 get e6;
  T7 get e7;
}

abstract class Tuple9<T0, T1, T2, T3, T4, T5, T6, T7, T8> implements Tuple {
  factory Tuple9(final T0 e0, final T1 e1, final T2 e2, final T3 e3, final T4 e4, final T5 e5, final T6 e6, final T7 e7, final T8 e8) =>
        new _Tuple9(checkNotNull(e0), checkNotNull(e1), checkNotNull(e2), checkNotNull(e3), checkNotNull(e4), checkNotNull(e5), checkNotNull(e6), checkNotNull(e7), checkNotNull(e8));

  T0 get e0;
  T1 get e1;
  T2 get e2;
  T3 get e3;
  T4 get e4;
  T5 get e5;
  T6 get e6;
  T7 get e7;
  T8 get e8;
}

abstract class Tuple10<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9> implements Tuple {
  factory Tuple10(final T0 e0, final T1 e1, final T2 e2, final T3 e3, final T4 e4, final T5 e5, final T6 e6, final T7 e7, final T8 e8, final T9 e9) =>
        new _Tuple10(checkNotNull(e0), checkNotNull(e1), checkNotNull(e2), checkNotNull(e3), checkNotNull(e4), checkNotNull(e5), checkNotNull(e6), checkNotNull(e7), checkNotNull(e8), checkNotNull(e9));

  T0 get e0;
  T1 get e1;
  T2 get e2;
  T3 get e3;
  T4 get e4;
  T5 get e5;
  T6 get e6;
  T7 get e7;
  T8 get e8;
  T9 get e9;
}

abstract class TupleN<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, TN> implements Tuple {
  factory TupleN(final T0 e0, final T1 e1, final T2 e2, final T3 e3, final T4 e4, final T5 e5, final T6 e6, final T7 e7, final T8 e8, final T9 e9, final TN eN) {
    checkArgument(checkNotNull(eN).isNotEmpty);
    return new _TupleN(checkNotNull(e0), checkNotNull(e1), checkNotNull(e2), checkNotNull(e3), checkNotNull(e4), checkNotNull(e5), checkNotNull(e6), checkNotNull(e7), checkNotNull(e8), checkNotNull(e9), eN);
  }

  T0 get e0;
  T1 get e1;
  T2 get e2;
  T3 get e3;
  T4 get e4;
  T5 get e5;
  T6 get e6;
  T7 get e7;
  T8 get e8;
  T9 get e9;
  TN get eN;
}