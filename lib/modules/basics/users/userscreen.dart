import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user/user/user_modle.dart';

class UserScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(id: 1, name: "Ali Hassan Akil ", phone: "087436477"),
    UserModel(id: 2, name: "mohmad Hassan Akil ", phone: "909i0i09"),
    UserModel(id: 3, name: "jahfar Hassan Akil ", phone: "008088798"),
    UserModel(id: 4, name: "ahmad Hassan Akil ", phone: "09087877"),
    UserModel(id: 5, name: "gader  Akil ", phone: "09808987477"),
    UserModel(id: 1, name: "Ali Hassan Akil ", phone: "087436477"),
    UserModel(id: 2, name: "mohmad Hassan Akil ", phone: "909i0i09"),
    UserModel(id: 3, name: "jahfar Hassan Akil ", phone: "008088798"),
    UserModel(id: 4, name: "ahmad Hassan Akil ", phone: "09087877"),
    UserModel(id: 5, name: "gader  Akil ", phone: "09808987477")
  ];

  UserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Users"),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) => BulidUserItem(users[index]),
          itemCount: users.length,
          separatorBuilder: (context, index) => Container(
              width: double.infinity, height: 1.0, color: Colors.grey[200]),
        ));
  }

  Widget BulidUserItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(children: [
          CircleAvatar(
            radius: 30,
            child: Text(
              "${user.id}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                user.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                user.phone,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          )
        ]),
      );
}
