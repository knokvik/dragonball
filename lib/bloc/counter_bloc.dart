import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knokvik/bloc/counter_state.dart';
import 'package:knokvik/bloc/event.dart';

class CounterBloc extends Bloc<CounterEvent , CounterState> {
    CounterBloc() : super(const CounterState(count: 0)){ 
    on<Increment>((event,emit) => emit(CounterState(count: state.count +1)));
    on<Decrement>((event,emit) => emit(CounterState(count: state.count -1)));
    }
}

