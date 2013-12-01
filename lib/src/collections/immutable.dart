part of restlib.common.collections;

abstract class Immutable {
  int get hashCode;
  bool operator==(other);
}