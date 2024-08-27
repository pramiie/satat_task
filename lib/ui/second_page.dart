import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key, required this.fetchQuote, required this.firstQuote});
  final Future<void> Function() fetchQuote;
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
    _getQuote();
  }

  Future<void> _getQuote() async {
    await widget.fetchQuote();
    setState(() {
      quote = widget.firstQuote;
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
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
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
