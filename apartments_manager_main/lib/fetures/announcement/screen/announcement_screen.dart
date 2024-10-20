import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apartments_manager_main/fetures/residents/models/resident_model.dart';
import 'package:apartments_manager_main/fetures/announcement/screen/announcements_list_screen.dart';

class AnnouncementForm extends StatefulWidget {
  const AnnouncementForm({super.key});

  @override
  _AnnouncementFormState createState() => _AnnouncementFormState();
}

class _AnnouncementFormState extends State<AnnouncementForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Announcement"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create Announcement",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: "Title",
                          labelStyle: TextStyle(color: Colors.teal),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter announcement title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          labelText: "Message",
                          labelStyle: TextStyle(color: Colors.teal),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter the message';
                          }
                          return null;
                        },
                        maxLines: 4,
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              sendAnnouncement(_titleController.text,
                                  _messageController.text);
                            }
                          },
                          child: Text("Send"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendAnnouncement(String title, String message) async {
    List<String> residentEmails =
        await fetchResidentEmails(); // Fetch emails dynamically

    var url = Uri.parse('http://localhost:8080/announcement');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "title": title,
          "message": message,
          "emails": residentEmails,
        }),
      );

      if (response.statusCode == 200) {
        await FirebaseFirestore.instance.collection('announcements').add({
          'title': title,
          'message': message,
          'timestamp': FieldValue.serverTimestamp(),
        });

        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");

        print("Announcement sent successfully");

        // Clear the input fields
        _titleController.clear();
        _messageController.clear();

        // Navigate to AnnouncementsListScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AnnouncementsListScreen()),
        );

        // Show a success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Announcement sent successfully')),
        );
      } else {
        print("Failed to send announcement");
        // Show an error snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to send announcement: ${response.body}')),
        );
      }
    } catch (e) {
      print("Error sending announcement: $e");
      // Show an error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending announcement: $e')),
      );
    }
  }
}
