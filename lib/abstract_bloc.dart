import 'dart:async';

abstract class BlocEvent {}

abstract class Bloc <State, Event> {
  //Needs to be set at some point
  final _stateController = StreamController<State>();
  final _eventController = StreamController<Event>();

  Sink<Event> get eventSink => _eventController.sink;
  Stream<State> get stateStream => _stateController.stream;
  Sink<State> get stateSink => _stateController.sink;

  void onStart(Function f) {
    _eventController.stream.listen(f);
  }

  //Only thing that needs to be implemented
  void _mapEventToState(Event e);

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}