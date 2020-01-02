import 'dart:async';

abstract class Bloc <State, Event> {
  //Needs to be set at some point
  State item;

  final _stateStream = StreamController<State>();
  final _eventStream = StreamController<Event>();

  Sink<Event> get eventSink => _eventStream.sink;
  Stream<State> get stateStream => _stateStream.stream;

  Bloc() {
    _eventStream.stream.listen(_mapEventToState);
  }

  //Only thing that needs to be implemented
  void _mapEventToState(Event e);

  void dispose() {
    _stateStream.close();
    _eventStream.close();
  }
}
abstract class BlocEvent {}

class IncrementEvent extends BlocEvent {}

class DecrementEvent extends BlocEvent {}

class CounterBloc extends Bloc<int, BlocEvent>{
  //State item

  CounterBloc() {
    this.item = 0;
  }

  void _mapEventToState(BlocEvent event) {
    if (event is IncrementEvent)
      this.item++;
    else
      this.item <= 0 ? this.item = 0 :this.item--;

    _stateStream.sink.add(this.item);
  }

}