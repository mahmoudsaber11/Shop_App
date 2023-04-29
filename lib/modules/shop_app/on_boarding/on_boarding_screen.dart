import 'package:flutter/material.dart';
import 'package:news_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/s2.jpg',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body'),
    BoardingModel(
        image: 'assets/images/s2.jpg',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body'),
    BoardingModel(
        image: 'assets/images/s2.jpg',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                CacheHelper.saveData(key: 'onBoarding', value: true);
                navigateAndFinish(context, ShopLoginScreen());
              },
              child: const Text('SKIP'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
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
                },
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: ((context, index) =>
                    buildBoardingItem(boarding[index])),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      expansionFactor: 4.0,
                      spacing: 5.0,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.deepOrange,
                    ),
                    count: boarding.length),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      CacheHelper.saveData(key: 'onBoarding', value: true);
                      navigateAndFinish(context, ShopLoginScreen());
                    } else {
                      boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(model.image))),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 24.0,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );
}
