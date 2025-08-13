import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knokvik/bloc/cubit.dart';

class CubitExample extends StatelessWidget {
  const CubitExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cubit Example'),
      ),
      body: Center(
      child: BlocProvider(
        create: (context) => CounterCubit(),
        child: BlocBuilder<CounterCubit, Data>(
          builder: (context, data) {
            return Column(
              children: [
                Text((data.id).toString()),
                Text((data.name).toString()),
                Text((data.designation).toString()),
              ],
            );
          },
        ),
      ),
    )
   );
  }
}
