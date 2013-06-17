part of restlib.common.collections;

abstract class ImmutableBiMap<K,V> extends ImmutableMap<K,V> {
  ImmutableBiMap<V,K> inverse();
}