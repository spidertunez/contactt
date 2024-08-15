import 'package:flutter/foundation.dart';

class contact {
  int? id ;
   String name ;
 String phone ;
  String imagePath ;

  contact ({this.id,required this.imagePath, required this.phone,required this.name
  });

   Map<String, dynamic> toMap() {
     return {
       'name': name,
       'phone': phone,
       'imagePath': imagePath,
     };
   }
  factory contact.fromMap(Map<String, dynamic> map) {
    return contact(
      name: map['name'],
      phone: map['phone'],
      imagePath: map['imagePath'],
      id: map['id'],
    );
  }

}
