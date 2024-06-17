import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key, required this.fetchQuote, required this.quote});
  final Future<void> fetchQuote;
  final String quote;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late String quote;
  @override
  void initState() {
    super.initState();
    quote = widget.quote;
    _getQuote();
  }
  Future<void> _getQuote() async {
    await widget.fetchQuote;
    setState(() {
      quote = widget.quote;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 60),
        Text(quote,style: TextStyle(fontSize: 24, )),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _getQuote,
          child: Text('Get New Quote'),
        ),
      ],
      ),
    );
  }
}
