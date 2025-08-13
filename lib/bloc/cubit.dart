import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<Data> {
    CounterCubit() : super(Data(id: 1, name: 'Niraj', designation: 'HR'));
    void increment() => emit( state.copyWith(id : state.id + 1) );
}

class Data {
  int id;
  String name;
  String designation;

  Data({ required this.id , required this.name , required this.designation });

  Data copyWith({int? id, String? name, String? designation}) {
    return Data(
      id: id ?? this.id,
      name: name ?? this.name,
      designation: designation ?? this.designation,
    );
  }
}