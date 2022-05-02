import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_learning/templates/managers/assets_manager.dart';
import 'package:share_learning/templates/managers/color_manager.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 8.00,
        bottom: 8.00,
      ),
      decoration: BoxDecoration(
        // color: ColorConstant.whiteA700,
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(
          5.00,
        ),
        border: Border.all(
          color: ColorManager.primary,
          width: 1.00,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 16.00,
              top: 16.00,
              bottom: 16.00,
            ),
            child: Image.network(
              'https://cdn.pixabay.com/photo/2017/02/04/12/25/man-2037255_960_720.jpg',
              width: 100.0,
              height: 100.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 12.00,
              top: 16.00,
              right: 16.00,
              bottom: 15.00,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 227.00,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 158.00,
                        child: Text(
                          "Nike Air Zoom Pegasus 36 Miami",
                          maxLines: null,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            // color: ColorConstant.indigo900,
                            color: Colors.indigo,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.50,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 12.00,
                        ),
                        child: Container(
                          height: 24.00,
                          width: 24.00,
                          child: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: ColorManager.primary,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 12.00,
                        ),
                        child: Container(
                          height: 24.00,
                          width: 24.00,
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 227.00,
                  margin: EdgeInsets.only(
                    top: 17.00,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 1.00,
                          bottom: 1.00,
                        ),
                        child: Text(
                          "299,43",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            // color: ColorConstant.lightBlueA200,
                            color: Colors.lightBlue,
                            fontSize: 12,

                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.50,
                          ),
                        ),
                      ),
                      Container(
                        width: 108.29,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 20.00,
                              width: 33.32,
                              child: IconButton(
                                icon: Icon(Icons.plus_one),
                                onPressed: () {},
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 20.00,
                              width: 41.65,
                              decoration: BoxDecoration(
                                // color: ColorConstant.blue50,
                                color: Colors.blue,
                                border: Border.all(
                                  // color: ColorConstant.blue50,
                                  color: Colors.blue,
                                  width: 1.00,
                                ),
                              ),
                              child: Text(
                                "1",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  // color: ColorConstant.indigo900,
                                  color: Colors.indigo,
                                  fontSize: 12,

                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.06,
                                ),
                              ),
                            ),
                            Container(
                              height: 20.00,
                              width: 33.32,
                              child: IconButton(
                                icon: Icon(Icons.plus_one),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
