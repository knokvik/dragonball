import 'package:flutter/material.dart';
import 'package:knokvik/backend/provider.dart';
import 'package:provider/provider.dart';

class StateMangagement extends StatefulWidget {
  const StateMangagement({super.key});

  @override
  State<StateMangagement> createState() => _StateMangagementState();
}

class _StateMangagementState extends State<StateMangagement>  {

  int pageNo = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('StateMangagement'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('StateMangagement'),
            Text('Page No : ${pageNo}', style: TextStyle( fontSize: 20 ),),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  pageNo += 1;
                });
              }, 
              child: Text(Provider.of<Counter>(context, listen: true).count.toString()),
              ),

              SizedBox(height: 80),
              Text('Provider Counter'),
              Consumer<Counter>(
                builder: (context, cart, child) {
                  return Column(
                    children: [
                      Text('Total price: ${cart.count}'),
                       ElevatedButton(
                        onPressed: () {
                          cart.increment();
                        }, 
                        child: Text('Increment')),
                    ],
                  );
                },
              ),

              SizedBox(height: 80),
              Text('Future Provider Counter'),
              FutureBuilder<int>(
              future: Provider.of<Counter>(context, listen: false).delayData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                }
                return Container();
              },
            ),

            SizedBox(height: 80),
              Text('Stream Provider Counter'),
              StreamBuilder<int>(
                stream: Provider.of<Counter>(context, listen: false).randomIntStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    print('!!!!!');
                    return Text(snapshot.data.toString());
                  }
                  return Container();
                },
              )

          ],
        ),
      ),
    );
  }
}