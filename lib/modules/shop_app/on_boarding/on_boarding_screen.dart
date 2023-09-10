import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/shop_app/on_boarding/login/shop_login.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/network/local/cach_helper.dart';
import 'package:flutter_application_1/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModle {
  final String image;
  final String title;
  final String body;

  BoardingModle({required this.title, required this.image, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModle> boarding = [
    BoardingModle(
        image: 'assets/images/onboard_1.jpg',
        title: 'OnBoard 1 Title',
        body: 'OnBoard 1 Body'),
    BoardingModle(
        image: 'assets/images/onboard_2.jpg',
        title: 'OnBoard 2 Title',
        body: 'OnBoard 2 Body'),
    BoardingModle(
        image: 'assets/images/onboard_3.jpg',
        title: 'OnBoard 3 Title',
        body: 'OnBoard 3 Body'),
  ];
  var boardController = PageController();
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          defaultTextButton(function: submit, text: 'SKIP'),
        ]),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardController,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                    print(isLast);
                  },
                  itemBuilder: (context, index) =>
                      buildBordingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: defaultColor,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastEaseInToSlowEaseOut);
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget buildBordingItem(BoardingModle modle) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(
            image: AssetImage('${modle.image}'),
            fit: BoxFit.cover,
          )),
          SizedBox(
            height: 10,
          ),
          Text(
            '${modle.title}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '${modle.body}',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      );

  void submit() {
    CachHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        NavigatorAndFinish(
          context,
          ShopLoginScreen(),
        );
      }
    });
  }
}
