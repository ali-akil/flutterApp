//https://www.getpostman.com/collections/94db931dc503afd508a5
import '../../modules/shop_app/on_boarding/login/shop_login.dart';
import '../network/local/cach_helper.dart';
import 'components.dart';

var token = '';
bool? isdark = false;
void signOut(context) {
  CachHelper.removeData(key: 'token').then((value) {
    if (value) NavigatorAndFinish(context, ShopLoginScreen());
  });
}

void PrintFluttertext(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}
