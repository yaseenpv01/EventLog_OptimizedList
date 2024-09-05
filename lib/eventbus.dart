import 'dart:async';

class EventBus {
  static final EventBus _instance = EventBus._internal();
  final _streamController = StreamController<dynamic>.broadcast();

  EventBus._internal();

  factory EventBus() {
    return _instance;
  }

  void publish(dynamic event) {
    _streamController.sink.add(event);
  }

  Stream<dynamic> subscribe() {
    return _streamController.stream;
  }

  void dispose() {
    _streamController.close();
  }
}