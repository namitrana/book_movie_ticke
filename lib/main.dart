import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'book_ticket_model.dart';

/// This is the starting point of the application
void main() {

  /// Our home page listens to MyModel ChangeNotifier to reflect data in the UI
  runApp(
      ChangeNotifierProvider(
        create: (context) => MyModel(),
        child: MovieTicketApp(),
      )
  );
}

