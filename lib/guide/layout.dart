import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  Layout({super.key});

  final List<String> items = ['', 'Apple', 'Banana', 'Orange', 'Grapes'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Layout Example'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              Text('Simple List Example'),
              SizedBox(
                height: 230,
                child: ListView(
                  children: [
                    ListTile(leading : Icon(Icons.car_crash) , title: Text('Heello')),
                    ListTile(leading : Icon(Icons.car_crash) , title: Text('Heello')),
                    ListTile(leading : Icon(Icons.car_crash) , title: Text('Heello')),
                    ListTile(leading : Icon(Icons.car_crash) , title: Text('Heello')),         
                  ],
                ),
              ),
              Text('List Builder Example'),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: Text(item),
                    );
                  }
                ),
              ),
        
              Text('List Builder Example'),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: Text(item),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}