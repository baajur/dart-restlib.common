part of collections;

abstract class Tuple<T> implements Iterable<T> {
}

abstract class None implements Tuple, Option {

}

abstract class Some<T> implements Tuple<T>, Option {
  T get e0;
}

abstract class Pair<T0, T1> implements Tuple {
  factory Pair(final T0 e0, final T1 e1) =>
      new _Pair(checkNotNull(e0), checkNotNull(e1));

  T0 get e0;
  T1 get e1;
}

abstract class Tuple3<T0, T1, T2> implements Tuple {
  T0 get e0;
  T1 get e1;
  T2 get e2;
}

abstract class Tuple4<T0, T1, T2, T3> implements Tuple {
  T0 get e0;
  T1 get e1;
  T2 get e2;
  T3 get e3;
}

abstract class Tuple5<T0, T1, T2, T3, T4> implements Tuple {
  T0 get e0;
  T1 get e1;
  T2 get e2;
  T3 get e3;
  T4 get e4;
}

abstract class Tuple6<T0, T1, T2, T3, T4, T5> implements Tuple {
  T0 get e0;
  T1 get e1;
  T2 get e2;
  T3 get e3;
  T4 get e4;
  T5 get e5;
}

abstract class TupleRest<T0, T1, T2, T3, T4, T5, TRest extends Tuple> implements Tuple {
  T0 get e0;
  T1 get e1;
  T2 get e2;
  T3 get e3;
  T4 get e4;
  T5 get e5;
}


