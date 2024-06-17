import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key, required this.fetchQuote, required this.firstQuote});
  final Future<String> Function() fetchQuote;
  final String firstQuote;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late String quote;

  @override
  void initState() {
    super.initState();
    quote = widget.firstQuote;
  }

  Future<void> _getQuote() async {
    String newQuote = await widget.fetchQuote();
    setState(() {
      quote = newQuote;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                quote,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getQuote,
                child: Text('Get New Quote'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
