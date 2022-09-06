import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 0,
            shadowColor: Colors.amber,
            color: Colors.grey.shade100,
            margin: const EdgeInsets.all(30),
            child: Wrap(
              spacing: 30,
              runSpacing: 10,
              children: [
                TextButton.icon(
                    onPressed: () async {
                      Future.delayed(const Duration(seconds: 10));
                      Navigator.of(context).pushNamed('/bloc/example/');
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Bloc Example')),
                TextButton.icon(
                    onPressed: () async {
                      Navigator.of(context).pushNamed('/bloc/example/freezed');
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Freezed Example')),
                TextButton.icon(
                    onPressed: () async {
                      Navigator.of(context).pushNamed('/contacts/list');
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Contact Bloc Example')),
                TextButton.icon(
                    onPressed: () async {
                      Navigator.of(context).pushNamed('/contacts/list/cubit');
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Contact Cubit Example'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
