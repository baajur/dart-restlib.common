library async_test;

import "package:restlib_common/async.dart";

import "dart:async";

main() {
  Stream a = new Stream.fromIterable(["a","B","c"]);
  Stream err = new Stream.fromFuture(new Future.error("error"));
  Stream b = new Stream.fromIterable(["d","e","f"]);

  Stream res = concatStreams([a, b]);
  StreamSubscription sub;
  sub = res.listen((String str) {
    print(str);
    sub.pause(new Future.delayed(new Duration(seconds: 2)));
  }, cancelOnError: false);
}