part of restlib.common.objects;

abstract class Forwarder<T> {
  final InstanceMirror _delegateMirror;
  final T _delegate;

  Forwarder(final T delegate) :
    this._delegate = delegate,
    this._delegateMirror = reflect(delegate);

  noSuchMethod(final Invocation invocation) =>
      _delegateMirror.delegate(invocation);
  
  String toString() => 
      _delegate.toString();
}