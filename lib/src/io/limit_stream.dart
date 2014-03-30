part of io;

abstract class LimitStream implements Stream<List<int>> {
  factory LimitStream(final Stream<List<int>> source, final int limit) =>
      new _LimitStream(checkNotNull(source), checkNotNull(limit));

  Stream get remainder;
}

class _LimitStream extends Stream<List<int>> implements LimitStream {
  final Stream<List<int>> source;
  final int limit;

  Option<StreamSubscription> _sourceSubscription = Option.NONE;
  Option<StreamController> _subscriptionController = Option.NONE;
  Option<StreamController> _remainderController = Option.NONE;
  bool _subscriptionCancelled = false;
  int read = 0;
  bool _sourceDone = false;

  _LimitStream(this.source, this.limit);

  Stream<List<int>> get remainder =>
      _getRemainderController().stream;

  StreamController<List<int>> _getRemainderController() =>
      _remainderController.orCompute(() {
        final StreamController<List<int>> controller = new StreamController(
            onListen: () => _subscribe(),
            onPause: () => _subscribe().pause(),
            onResume: () => _subscribe().resume(),
            onCancel: () => _subscribe().cancel(),
            sync: false);
        this._remainderController = new Option(controller);
        return controller;
      });

  void _addData(final List<int> data) {
    if(_subscriptionCancelled || read == limit) {
      _getRemainderController().add(data);
    } else if ((read + data.length) <= limit) {
      read = read + data.length;
      _subscriptionController.value.add(data);
    } else {
      final int bytesToRead = limit - read;
      read = limit;
      _subscriptionController.value.add(sublist(data, 0, bytesToRead));
      _getRemainderController().add(sublist(data, bytesToRead));
    }
  }

  StreamSubscription _subscribe() =>
      _sourceSubscription.orCompute(() {
        final StreamSubscription subscription = source.listen(
            _addData,
            onError: (final error, [final StackTrace stackTrace]) {
              _subscriptionController.map((final StreamController controller) => controller.addError(error, stackTrace));
              _remainderController.map((final StreamController controller) => controller.addError(error, stackTrace));
            }, onDone: () {
              _sourceDone = true;
              _subscriptionController.map((final StreamController controller) => controller.close());
              _remainderController.map((final StreamController controller) => controller.close());
            });

        this._sourceSubscription = new Option(subscription);
        return subscription;
      });

  StreamSubscription<List<int>> listen(void onData(List<int> event), {Function onError, void onDone(), bool cancelOnError}) {
    checkState(_sourceSubscription.isEmpty);

    final StreamController controller = new StreamController(
        onListen: () {
          _subscribe();
        }, onPause: () => _subscribe().pause(),
        onResume: () => _subscribe().resume(),
        onCancel: () {_subscriptionCancelled = true;},
        sync: false);

    this._subscriptionController = new Option(controller);

    return controller.stream.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}