part of restlib.common.objects;

abstract class Forwarder<T> {
  final InstanceMirror _delegateMirror;
  final T _delegate;

  Forwarder(final T delegate) :
    this._delegate = delegate,
    this._delegateMirror = reflect(delegate);

  noSuchMethod(final Invocation invocation) {
    return _delegateMirror.delegate(invocation);
  }
  
  String toString() {
    return _delegate.toString();
  }
}