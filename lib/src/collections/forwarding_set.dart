part of restlib.common.collections;

abstract class ForwardingSet<E> implements Forwarder, FiniteSet<E> {
  FiniteSet<E> difference(FiniteSet<E> other) =>
      delegate.difference(other);
  
  FiniteSet<E> intersection(FiniteSet<E> other) =>
      delegate.intersection(other);
  
  FiniteSet<E> union(FiniteSet<E> other) =>
      delegate.union(other);
}