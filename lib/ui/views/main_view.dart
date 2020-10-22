import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pizza_simplified/ui/shared/shared.dart';
import 'package:pizza_simplified/ui/utils/utils.dart';
import 'package:pizza_simplified/ui/widgets/widgets.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController categoryController,
      pizzaController,
      saladController,
      pastaController,
      drinkController;
  FixedExtentScrollController pickerController;
  int numberOfCategories = 4;
  int numberOfPages = 5;
  double viewportFraction = 0.9;
  double transition = 30;
  double bottomPosition = 50;
  double scale = 1.0;
  List<int> latestVisitedPages;

  @override
  void initState() {
    categoryController = PageController(initialPage: 1000);
    pizzaController = PageController(
      viewportFraction: viewportFraction,
      initialPage: 1000,
    );
    saladController = PageController(
      viewportFraction: viewportFraction,
      initialPage: 1000,
    );
    pastaController = PageController(
      viewportFraction: viewportFraction,
      initialPage: 1000,
    );
    drinkController = PageController(
      viewportFraction: viewportFraction,
      initialPage: 1000,
    );
    pickerController = FixedExtentScrollController(initialItem: 0);
    categoryController.addListener(pickerListener);
    latestVisitedPages = [for (int i = 0; i < numberOfCategories; i++) 1000];
    super.initState();
  }

  void pickerListener() {
    pickerController.animateToItem(
      categoryController.page.round(),
      duration: Duration(milliseconds: 200),
      curve: Curves.ease,
    );
    _updateTransition();
    setState(() {});
  }

  double diff;

  _updateTransition() {
    if (categoryController?.page != null) {
      diff = categoryController.page - categoryController.page.floor();
    } else {
      diff = 30.0;
    }
    double resultDiff = 1 - 2 * (diff - 0.5).abs();
    transition = Curves.easeOutCubic.transform(resultDiff) * 150 + 30;
    scale = Curves.easeOutCubic.transform(resultDiff) * 1 + 1.0;
    bottomPosition = -Curves.ease.transform(resultDiff) * 300 + 50;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: transition,
              left: 0,
              right: 0,
              child: Transform.scale(
                scale: scale,
                child: Container(
                  height: 170,
                  child: CustomPicker(
                    scrollController: pickerController,
                    looping: true,
                    // magnification: 1.5,
                    squeeze: .7,
                    useMagnifier: true,
                    backgroundColor: Colors.transparent,
                    onSelectedItemChanged: (value) {},
                    itemExtent: 25.0,
                    children: [
                      Container(
                        height: 40,
                        child: Text(
                          'PIZZA',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        height: 40,
                        child: Text(
                          'SALLADS',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        height: 40,
                        child: Text(
                          'PASTA',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        height: 40,
                        child: Text(
                          'DRINKS',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            PageView.builder(
              controller: categoryController,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                if (index % numberOfCategories == 0)
                  return PageView.builder(
                    controller: pizzaController,
                    itemBuilder: (context, index) => Container(
                      child: CirclicPageAnimation(
                        initialPage: latestVisitedPages[0],
                        minScale: 0.4,
                        controller: pizzaController,
                        index: index,
                        maxRotate: 10,
                        child: PlateListTile(
                          initialPage: latestVisitedPages[0],
                          backgroundColor: Colors.red,
                          index: index % numberOfPages,
                          controller: pizzaController,
                        ),
                      ),
                    ),
                  );
                if (index % numberOfCategories == 1)
                  return PageView.builder(
                    controller: saladController,
                    itemBuilder: (context, index) => CirclicPageAnimation(
                      initialPage: latestVisitedPages[1],
                      minScale: 0.4,
                      controller: saladController,
                      index: index,
                      maxRotate: 10,
                      child: Container(
                        child: PlateListTile(
                          initialPage: latestVisitedPages[1],
                          backgroundColor: Colors.green,
                          index: index % numberOfPages,
                          controller: saladController,
                        ),
                      ),
                    ),
                  );
                if (index % numberOfCategories == 2)
                  return PageView.builder(
                    controller: pastaController,
                    itemBuilder: (context, index) => CirclicPageAnimation(
                      initialPage: latestVisitedPages[2],
                      minScale: 0.4,
                      controller: pastaController,
                      index: index,
                      maxRotate: 10,
                      child: Container(
                        child: PlateListTile(
                          initialPage: latestVisitedPages[2],
                          backgroundColor: Colors.yellow,
                          index: index % numberOfPages,
                          controller: pastaController,
                        ),
                      ),
                    ),
                  );
                if (index % numberOfCategories == 3)
                  return PageView.builder(
                    controller: drinkController,
                    itemBuilder: (context, index) => CirclicPageAnimation(
                      initialPage: latestVisitedPages[3],
                      minScale: 0.4,
                      controller: drinkController,
                      index: index,
                      maxRotate: 10,
                      child: Container(
                        child: PlateListTile(
                          initialPage: latestVisitedPages[3],
                          backgroundColor: Colors.blueGrey,
                          index: index % numberOfPages,
                          controller: drinkController,
                        ),
                      ),
                    ),
                  );
                return SizedBox();
              },
            ),
            Positioned(
              top: 35,
              left: 10,
              child: IconButton(
                icon: Icon(
                  OMIcons.map,
                ),
                color: Colors.grey,
                iconSize: 35,
                onPressed: () {},
              ),
            ),
            Positioned(
              top: 35,
              right: 10,
              child: IconButton(
                icon: Icon(
                  OMIcons.shoppingCart,
                ),
                color: Colors.grey,
                iconSize: 35,
                onPressed: () {},
              ),
            ),
            Positioned(
              bottom: bottomPosition,
              left: 80,
              right: 80,
              child: Container(
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(50.0),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(50.0),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    splashColor: splashColor,
                    focusColor: focusColor,
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Icon(
                        Icons.add_shopping_cart,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
