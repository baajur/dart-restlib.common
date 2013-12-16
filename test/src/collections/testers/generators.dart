part of restlib.common.collections_test;

abstract class PairGenerator {
  void reset();
  Pair next();
}

abstract class ElementGenerator {
  void reset();
  dynamic next();
}