import 'package:flutter/material.dart';
import 'package:untitled22/contact.dart';
import 'package:untitled22/sqll.dart';
import 'contactscreen.dart';

class ContactDetailScreen extends StatelessWidget {
  final contact contactDetail;

  const ContactDetailScreen({Key? key, required this.contactDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController =
        TextEditingController(text: contactDetail.name);
    final TextEditingController _phoneController =
        TextEditingController(text: contactDetail.phone);
    final TextEditingController _imageController =
        TextEditingController(text: contactDetail.imagePath);
    final DatabaseHelper databaseHelper = DatabaseHelper();

    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(_imageController.text),
                onBackgroundImageError: (error, stackTrace) {},
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Save contact',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            content: Text(
                                'Are you sure you want to Save this contact?',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal)),
                            actions: [
                              TextButton(
                                child: Text('No',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red),
                                ),
                                onPressed: () async {
                                  final updatedContact = contact(
                                    name: _nameController.text,
                                    phone: _phoneController.text,
                                    imagePath: _imageController.text,
                                  );

                                  await databaseHelper
                                      .updateContact(updatedContact);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(200, 60),
                      padding: EdgeInsets.symmetric(
                          horizontal: 150.0, vertical: 8.0),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Delete contact',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            content: Text(
                                'Are you sure you want to delete this contact?',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal)),
                            actions: [
                              TextButton(
                                child: Text('No',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red),
                                ),
                                onPressed: () async {
                                  await databaseHelper.deleteData(
                                    'DELETE FROM book WHERE id = ?',
                                    ['id'],
                                  );
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 60),
                      padding: EdgeInsets.symmetric(
                          horizontal: 150.0, vertical: 2.0),
                    ),
                    child: Text('Delete',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
