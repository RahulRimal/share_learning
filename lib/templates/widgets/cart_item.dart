import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_learning/models/book.dart';
import 'package:share_learning/models/cart.dart';
import 'package:share_learning/models/session.dart';
import 'package:share_learning/providers/carts.dart';
import 'package:share_learning/templates/managers/color_manager.dart';
import 'package:share_learning/templates/managers/font_manager.dart';
import 'package:share_learning/templates/managers/style_manager.dart';
import 'package:share_learning/templates/managers/values_manager.dart';

class CartItem extends StatefulWidget {
  const CartItem({Key? key, required this.cartItem}) : super(key: key);

  final Cart cartItem;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  bool _cartItemChanged = false;
  late int _quantity;

  // _incrementQuantity() {
  //   if (mounted) {
  //     setState(() {
  //       _quantity++;
  //     });
  //   }
  //   _ifCartItemChanged();
  // }

  // _decrementQuantity() {
  //   if (mounted) {
  //     setState(() {
  //       _quantity--;
  //     });
  //   }

  //   _ifCartItemChanged();
  // }

  _ifCartItemChanged() {
    if (_quantity != widget.cartItem.bookCount) {
      //   setState(() {
      //     _cartItemChanged = true;
      //   });
      // } else {
      //   setState(() {
      //     _cartItemChanged = false;
      //   });
      _cartItemChanged = true;
    } else {
      _cartItemChanged = false;
    }
  }

  @override
  void initState() {
    _quantity = widget.cartItem.bookCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    final Session authendicatedSession = args['loggedInUserSession'] as Session;

    Carts _carts = context.watch<Carts>();

    return FutureBuilder(
        future: _carts.getCartItemBook(
            authendicatedSession, widget.cartItem.bookId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong'),
              );
            } else {
              if (snapshot.data is Book) {
                final Book orderedBook = snapshot.data as Book;
                return Container(
                  // margin: EdgeInsets.only(
                  //   top: 8.00,
                  //   bottom: 8.00,
                  // ),
                  margin: EdgeInsets.all(AppMargin.m8),
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
                  child: Column(
                    children: [
                      Row(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 158.00,
                                        child: Text(
                                          // "Nike Air Zoom Pegasus 36 Miami",
                                          // snapshot.data!.bookName,
                                          orderedBook.bookName,
                                          // order.boo
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 1.00,
                                          bottom: 1.00,
                                        ),
                                        child: Text(
                                          // "299,43",
                                          "Rs. ${widget.cartItem.pricePerPiece * widget.cartItem.bookCount}",
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
                                      // Container(
                                      //   width: 108.29,
                                      //   child: Row(
                                      //     crossAxisAlignment: CrossAxisAlignment.center,
                                      //     mainAxisSize: MainAxisSize.min,
                                      //     children: [
                                      //       Container(
                                      //         height: 20.00,
                                      //         width: 33.32,
                                      //         child: IconButton(
                                      //           icon: Icon(Icons.plus_one),
                                      //           onPressed: () {},
                                      //         ),
                                      //       ),
                                      //       Container(
                                      //         alignment: Alignment.center,
                                      //         height: 20.00,
                                      //         width: 41.65,
                                      //         decoration: BoxDecoration(
                                      //           // color: ColorConstant.blue50,
                                      //           color: Colors.blue,
                                      //           border: Border.all(
                                      //             // color: ColorConstant.blue50,
                                      //             color: Colors.blue,
                                      //             width: 1.00,
                                      //           ),
                                      //         ),
                                      //         child: Text(
                                      //           "1",
                                      //           textAlign: TextAlign.center,
                                      //           style: TextStyle(
                                      //             // color: ColorConstant.indigo900,
                                      //             color: Colors.indigo,
                                      //             fontSize: 12,

                                      //             fontFamily: 'Poppins',
                                      //             fontWeight: FontWeight.w400,
                                      //             letterSpacing: 0.06,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       Container(
                                      //         height: 20.00,
                                      //         width: 33.32,
                                      //         child: IconButton(
                                      //           icon: Icon(Icons.plus_one),
                                      //           onPressed: () {},
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),

                                      Container(
                                        child: ButtonBar(
                                          children: [
                                            IconButton(
                                              // color: ColorManager.primary,
                                              color: Colors.black,
                                              // onPressed: () {},
                                              // icon: Icon(
                                              //   Icons.miscellaneous_services,
                                              // ),
                                              // onPressed: _decrementQuantity(),
                                              onPressed: _quantity < 2
                                                  ? null
                                                  : () {
                                                      setState(() {
                                                        _quantity--;
                                                        _ifCartItemChanged();
                                                      });
                                                    },

                                              icon: Container(
                                                width: AppSize.s40,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: ColorManager.black,
                                                ),
                                                child: Text(
                                                  '-',
                                                  style: getBoldStyle(
                                                      color: ColorManager.white,
                                                      fontSize: FontSize.s20),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              // '1',
                                              _quantity.toString(),
                                              style: getBoldStyle(
                                                color: ColorManager.primary,
                                                fontSize: FontSize.s20,
                                              ),
                                            ),
                                            IconButton(
                                              // color: ColorManager.primary,
                                              color: Colors.black,
                                              // onPressed: () {},
                                              // icon: Icon(
                                              //   Icons.miscellaneous_services,
                                              // ),
                                              // onPressed: _incrementQuantity(),
                                              onPressed: () {
                                                setState(() {
                                                  _quantity++;
                                                  _ifCartItemChanged();
                                                });
                                              },

                                              icon: Container(
                                                width: AppSize.s40,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: ColorManager.black,
                                                ),
                                                child: Text(
                                                  '+',
                                                  style: getBoldStyle(
                                                      color: ColorManager.white,
                                                      fontSize: FontSize.s17),
                                                ),
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
                      _cartItemChanged
                          ? ElevatedButton(
                              onPressed: () {}, child: Text('Update Cart'))
                          : Container(),
                    ],
                  ),
                );
              } else if (snapshot.data is CartError) {
                Center(
                    child: Container(
                  child: Text((snapshot.data as CartError).message.toString()),
                ));
              }
              return Container();
            }
          }
        });
  }
}
