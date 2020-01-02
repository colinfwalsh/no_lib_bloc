
import 'abstract_bloc.dart';

class IncrementEvent extends BlocEvent {}

class DecrementEvent extends BlocEvent {}

class CounterBloc extends Bloc<int, BlocEvent>{
  int item;

  CounterBloc(this.item){
    onStart(this._mapEventToState);
  }

  void _mapEventToState(BlocEvent event) {
    if (event is IncrementEvent)
      this.item++;
    else
      this.item <= 0 ? this.item = 0 :this.item--;

    stateSink.add(this.item);
  }

}