library async;

import "dart:async";
import "objects.dart";

Stream valueAsStream(dynamic value) =>
    new Stream.fromFuture(new Future.value(value));

Stream concatStreams(final Iterable<Stream> streams) {
  final Iterator<Stream> streamItr = streams.iterator;
  StreamSubscription subscription = null;
  StreamController controller = null;

  void addNextStream() {
    final Stream stream = streamItr.current;
    subscription = stream.listen(
        controller.add,
        onError: controller.addError,
        onDone: () =>
            streamItr.moveNext() ? addNextStream() : controller.close());
  }

  controller = new StreamController(
      onListen: () =>
          streamItr.moveNext() ? addNextStream() : controller.close(),
      onPause: () =>
          computeIfNotNull(subscription, (_) => subscription.pause()),
      onResume: () =>
          computeIfNotNull(subscription, (_) => subscription.resume()),
      onCancel: () {
        Future result = null;
        computeIfNotNull(subscription, (_) => result = subscription.cancel());
        return result;
      });

  return controller.stream;
}