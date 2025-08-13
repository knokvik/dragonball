import 'dart:convert';

class User{
    int id;
    String name;
    String address;

    User({ required this.id , required this.name , required this.address });

    factory User.fromJSON(Map<String, dynamic> json) {
      print('Hello');
      return User(
        id: json['id'],
        name : json['name'],
        address: json['address']
      );
    }

    Map<String , dynamic> toJSON () {
      return {
        'id' : this.id,
        'name' : this.name,
        'address' : this.address,
      };
    }
}

var data = {
  'id' : '232',
  'name' : 'Niraj',
  'address' : 'Morewasti'
};

final obj = User.fromJSON(data);
