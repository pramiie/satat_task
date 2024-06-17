import 'package:flutter/material.dart';
import 'package:satat_task/ui/second_page.dart';

import '../framework/api/api_end_point.dart';
import '../framework/api/dio_client.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  int res = 0;
  String quote = '';

  // List of history
  List<String> history = [];

  void add() {
    setState(() {
      int num1 = int.tryParse(num1Controller.text) ?? 0;
      int num2 = int.tryParse(num2Controller.text) ?? 0;
      res = num1 + num2;
      // Add to history
      history.add("$num1 + $num2 = $res");
    });
  }

  Future<void> fetchQuote() async {
    try {
      final response = await DioClient.dioClient.getAPI(endPoint: APIEndPoint.quotes);
      setState(() {
        quote = response.data[0]['q'];
      });
    } catch (e) {
      setState(() {
        quote = "Failed to fetch quote: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            "Adder",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 50),
          Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: num1Controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Text(
                "+",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                  controller: num2Controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                child: Text(
                  "=",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                onTap: () {
                  add();
                },
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  "$res",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            "History",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(history[index]),
                );
              },
            ),
          ),
          SizedBox(height: 5),
          TextButton(
            onPressed: () async {
              await fetchQuote();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondPage(fetchQuote: fetchQuote, initialQuote: quote),
                ),
              );
            },
            child: Text("Go to second page"),
          ),
        ],
      ),
    );
  }
}
