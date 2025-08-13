import 'package:equatable/equatable.dart';
import 'package:knokvik/backend/provider.dart';

abstract class CounterEvent extends Equatable{
  List<Object> get props => [];
}

class Increment extends CounterEvent{}
class Decrement extends CounterEvent{}

