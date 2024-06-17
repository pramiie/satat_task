import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key, required this.fetchQuote, required this.Quote}) : super(key: key);
  final Future<void> Function() fetchQuote;
  final String Quote;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late String quote;

  @override
  void initState() {
    super.initState();
    quote = widget.Quote;
    _getQuote();
  }

  Future<void> _getQuote() async {
    await widget.fetchQuote();
    setState(() {
      quote = widget.Quote;
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
