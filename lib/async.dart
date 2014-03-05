library async;

import "dart:async";

Stream valueAsStream(dynamic value) =>
    new Stream.fromFuture(new Future.value(value));

Stream concatStreams(final Iterable<Stream> streams) {
  final StreamController controller = new StreamController();
  final Iterator<Stream> streamItr = streams.iterator;
  
  void addNextStream() {
    final Stream stream = streamItr.current;
    stream.listen(controller.add)
      ..onError(controller.addError)
      ..onDone(() {
        if(streamItr.moveNext()) {
          addNextStream();
        } else {
          controller.close();
        }
      });
  }
  
  if (streamItr.moveNext()) {
    addNextStream();
  } else {
    controller.close();
  }
  
  return controller.stream;
}    