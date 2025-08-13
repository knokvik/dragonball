import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knokvik/bloc/counter_bloc.dart';
import 'package:knokvik/bloc/counter_state.dart';
import 'package:knokvik/bloc/event.dart';

class BlocCounter extends StatefulWidget {
  final String label;
  const BlocCounter({super.key, required this.label});

  @override
  State<BlocCounter> createState() => _BlocCounterState();
}

class _BlocCounterState extends State<BlocCounter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.label),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bloc Counter'),
            BlocProvider(
              create: (context) => CounterBloc(),
              child: BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state) => Column(
                  children: [
                    Text('Counter: ${state.count}'),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          heroTag: '${widget.label}_dec', // Unique hero tag
                          onPressed: () => context.read<CounterBloc>().add(Decrement()),
                          child: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 20),
                        FloatingActionButton(
                          heroTag: '${widget.label}_inc', // Unique hero tag
                          onPressed: () => context.read<CounterBloc>().add(Increment()),
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
