import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/components/components.dart';

class SerachScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: defaultFormfiled(
              controller: searchController,
              type: TextInputType.text,
              label: 'search',
              validate: (value) {
                if (value.isEmpty) {
                  return 'search must not be Empty';
                }
                return null;
              },
              prefix: Icons.search),
        ),
      ]),
    );
  }
}
