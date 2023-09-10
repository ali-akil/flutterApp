import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/cubit/cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton(
        {double width = double.infinity,
        Color background = Colors.blue,
        double radius = 0,
        bool isupperCase = true,
        required function,
        required String text}) =>
    Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: background),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isupperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
Widget defaultFormfiled({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required validate,
  bool ispassword = false,
  bool isClickable = true,
  var suffix,
  var onSubmit,
  var suffixpressed,
  var onTap,
  required IconData prefix,
}) =>
    TextFormField(
        controller: controller,
        validator: validate,
        keyboardType: type,
        obscureText: ispassword,
        onTap: onTap,
        onFieldSubmitted: onSubmit,
        enabled: isClickable,
        decoration: InputDecoration(
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixpressed,
                  icon: Icon(suffix),
                )
              : null,
          labelText: label,
          prefixIcon: Icon(prefix),
          border: const OutlineInputBorder(),
        ));

Widget bulidTaskItem(Map modle, context) => Dismissible(
      key: Key(modle['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          children: [
            CircleAvatar(radius: 40.0, child: Text('${modle['time']}')),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${modle['title']}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${modle['date']}',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .upDateData(status: "done", id: modle['id']);
                },
                icon: Icon(Icons.check_box, color: Colors.green)),
            SizedBox(
              width: 20,
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .upDateData(status: "archived", id: modle['id']);
                },
                icon: Icon(
                  Icons.archive,
                  color: Colors.black45,
                ))
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: modle['id']);
      },
    );

Widget taskesBuilder({required List<Map> tasks}) => ConditionalBuilder(
    condition: tasks.length > 0,
    builder: (context) => ListView.separated(
        itemBuilder: (context, index) => bulidTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
        itemCount: tasks.length),
    fallback: (context) => Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              "No Tasks Yet , Please Add Some Tasks",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            )
          ],
        )));
Widget myDivider() => Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey,
    );
Widget buildArticaleItem(articale, context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/flower.jpg'), //${articale['urlToImage']}
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Title Title Title Title Title Title Title ', //${articale['title']}
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '2022-2-22', //${articale['publishedAt']
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void NavigatorAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => Widget),
    (Route<dynamic> route) => false);
Widget defaultTextButton({required var function, required String text}) =>
    TextButton(onPressed: function, child: Text(text.toUpperCase()));
void showToast({required String message, required ToastState state}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state: state),
        textColor: Colors.white,
        fontSize: 16.0);

//for proccessing color Toast
enum ToastState { SUCCESS, ERROR, WARNIG }

Color chooseToastColor({required ToastState state}) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNIG:
      color = Colors.amber;
      break;
  }
  return color;
}
