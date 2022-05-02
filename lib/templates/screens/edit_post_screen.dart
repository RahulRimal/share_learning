import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:share_learning/models/book.dart';
import 'package:share_learning/models/session.dart';
import 'package:share_learning/providers/books.dart';
import 'package:share_learning/templates/managers/color_manager.dart';
import 'package:share_learning/templates/managers/style_manager.dart';

class EditPostScreen extends StatefulWidget {
  static const routeName = '/edit-post';

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _form = GlobalKey<FormState>();

  final _authorFocusNode = FocusNode();
  final _dateFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _booksCountFocusNode = FocusNode();
  final _descFocusNode = FocusNode();

  List<bool> postTypeBuying = [true, false];

  var _edittedBook = Book(
    id: '',
    author: '',
    bookName: '',
    userId: '',
    // postType: false,
    postType: 'B',
    boughtDate: DateTime.now().toNepaliDateTime(),
    description: '',
    wishlisted: false,
    price: 0,
    bookCount: 1,
    postedOn: DateTime.now().toNepaliDateTime(),
    postRating: '',
  );

  bool ispostType = true;

  NepaliDateTime? _boughtDate;

  final _datePickercontroller = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(NepaliDateTime.now()).toString(),
  );

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    String bookId = args['bookId'];
    if (bookId.isNotEmpty) {
      _edittedBook =
          Provider.of<Books>(context, listen: false).getBookById(bookId);

      ispostType = _edittedBook.postType == 'S' ? true : false;
      postTypeBuying = [ispostType, !ispostType];
    } else
      print('Book Id Is Empty');

    _datePickercontroller.text =
        DateFormat('yyyy-MM-dd').format(_edittedBook.boughtDate).toString();

    super.didChangeDependencies();
  }

  Future<void> _showPicker(BuildContext context) async {
    _boughtDate = await picker.showAdaptiveDatePicker(
      context: context,
      initialDate: _edittedBook.boughtDate,
      firstDate: picker.NepaliDateTime(2070),
      lastDate: picker.NepaliDateTime.now(),
    );
    _datePickercontroller.text =
        DateFormat('yyyy-MM-dd').format(_boughtDate as DateTime).toString();
  }

  bool _updatePost(Session loggedInUserSession, Book edittedBook) {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return false;
    }
    _form.currentState!.save();
    Provider.of<Books>(context, listen: false)
        // .updatePost(_edittedBook.id, _edittedBook);
        .updatePost(loggedInUserSession, _edittedBook);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    // showUpdateSnackbar(context);

    return true;
  }

  // void _showUpdateSnackbar(BuildContext context) {
  //   final snackBar = SnackBar(
  //     content: Text(
  //       'Posted Updated Successfully',
  //       textAlign: TextAlign.center,
  //       style: TextStyle(
  //         fontSize: 13,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    // String bookId = args['id'];
    final Session loggedInUserSession = args['loggedInUserSession'] as Session;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Post'),
        actions: <Widget>[
          loggedInUserSession.userId == _edittedBook.userId
              ? IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    if (_updatePost(loggedInUserSession, _edittedBook))
                      // _showUpdateSnackbar(context);
                      BotToast.showSimpleNotification(
                        title: 'Posted Updated Successfully',
                        duration: Duration(seconds: 3),
                        backgroundColor: ColorManager.primary,
                        titleStyle: getBoldStyle(color: ColorManager.white),
                        align: Alignment(0, 1),
                        hideCloseButton: true,
                      );

                    // BotToast.showCustomNotification(
                    //   toastBuilder: (c) => Center(
                    //     child: Text(
                    //       'Posted Updated Successfully',
                    //       style: getBoldStyle(color: ColorManager.white),
                    //     ),
                    //   ),
                    //   duration: Duration(seconds: 5),
                    //   align: Alignment(1, 1),
                    // );
                  },
                  // onPressed: _updatePost,
                )
              : Container(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                    initialValue: _edittedBook.bookName,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      labelText: 'bookName',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_authorFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide the bookName';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _edittedBook = Book(
                        id: _edittedBook.id,
                        author: _edittedBook.author,
                        bookName: value as String,
                        userId: _edittedBook.userId,
                        postType: _edittedBook.postType,
                        boughtDate: _edittedBook.boughtDate,
                        description: _edittedBook.description,
                        wishlisted: _edittedBook.wishlisted,
                        price: _edittedBook.price,
                        bookCount: _edittedBook.bookCount,
                        postedOn: _edittedBook.postedOn,
                        postRating: _edittedBook.postRating,
                      );
                    }),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            initialValue: _edittedBook.author,
                            cursorColor: Theme.of(context).primaryColor,
                            focusNode: _authorFocusNode,
                            decoration: InputDecoration(
                              labelText: 'Author',
                              focusColor: Colors.redAccent,
                            ),
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_dateFocusNode);
                            },
                            onSaved: (value) {
                              _edittedBook = Book(
                                id: _edittedBook.id,
                                author: value!.isEmpty ? 'Unknown' : value,
                                bookName: _edittedBook.bookName,
                                userId: _edittedBook.userId,
                                postType: _edittedBook.postType,
                                boughtDate: _edittedBook.boughtDate,
                                description: _edittedBook.description,
                                wishlisted: _edittedBook.wishlisted,
                                price: _edittedBook.price,
                                bookCount: _edittedBook.bookCount,
                                postedOn: _edittedBook.postedOn,
                                postRating: _edittedBook.postRating,
                              );
                            }),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // initialValue: _edittedBook.boughtDate.toIso8601String(),
                          controller: _datePickercontroller,
                          focusNode: _dateFocusNode,
                          // initialValue:
                          //     DateFormat('yyyy/MM/dd').format(DateTime.now()),
                          keyboardType: TextInputType.datetime,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            labelText: 'Bought Date',
                            // suffix: IconButton(
                            //   // onPressed: _showPicker,
                            //   tooltip: 'Tap to open datePicker',
                            //   onPressed: () {
                            //     DatePickerDialog(
                            //       initialDate: DateTime.now(),
                            //       firstDate: DateTime(2000),
                            //       lastDate: DateTime(2025),
                            //     );
                            //   },
                            //   icon: Icon(Icons.calendar_view_day_rounded),
                            // ),
                            suffix: IconButton(
                              icon: Icon(Icons.calendar_today),
                              tooltip: 'Tap to open date picker',
                              onPressed: () {
                                _showPicker(context);

                                // _datePickercontroller.text = _boughtDate.toString();
                              },
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.always,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_priceFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide bought date';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // print(DateFormat.yMd());
                            _edittedBook = Book(
                              id: _edittedBook.id,
                              author: _edittedBook.author,
                              bookName: _edittedBook.bookName,
                              userId: _edittedBook.userId,
                              postType: _edittedBook.postType,
                              // boughtDate: (DateFormat("yyyy/MM/dd")
                              //         .parse(value as String))
                              //     .toNepaliDateTime(),
                              boughtDate: NepaliDateTime.parse(value as String),

                              description: _edittedBook.description,
                              wishlisted: _edittedBook.wishlisted,
                              price: _edittedBook.price,
                              bookCount: _edittedBook.bookCount,
                              postedOn: _edittedBook.postedOn,
                              postRating: _edittedBook.postRating,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            initialValue: _edittedBook.price.toString(),
                            cursorColor: Theme.of(context).primaryColor,
                            focusNode: _priceFocusNode,
                            decoration: InputDecoration(
                              prefix: Text('Rs. '),
                              labelText: 'Price',
                              focusColor: Colors.redAccent,
                            ),
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_booksCountFocusNode);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Price can\'t be empty';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Invalid number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _edittedBook = Book(
                                id: _edittedBook.id,
                                author: _edittedBook.author,
                                bookName: _edittedBook.bookName,
                                userId: _edittedBook.userId,
                                postType: _edittedBook.postType,
                                boughtDate: _edittedBook.boughtDate,
                                description: _edittedBook.description,
                                wishlisted: _edittedBook.wishlisted,
                                price: double.parse(value as String),
                                bookCount: _edittedBook.bookCount,
                                postedOn: _edittedBook.postedOn,
                                postRating: _edittedBook.postRating,
                              );
                            }),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: _edittedBook.bookCount.toString(),
                          focusNode: _booksCountFocusNode,
                          keyboardType: TextInputType.number,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            labelText: 'Number of Books',
                          ),
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.always,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_descFocusNode);
                          },
                          validator: (value) {
                            if (double.tryParse(value as String) == null) {
                              return 'Invalid Number';
                            }

                            if (double.parse(value) < 1) {
                              return 'Book count must be at least 1';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _edittedBook = Book(
                              id: _edittedBook.id,
                              author: _edittedBook.author,
                              bookName: _edittedBook.bookName,
                              userId: _edittedBook.userId,
                              postType: _edittedBook.postType,
                              boughtDate: _edittedBook.boughtDate,
                              description: _edittedBook.description,
                              wishlisted: _edittedBook.wishlisted,
                              price: _edittedBook.price,
                              bookCount: int.parse(value as String),
                              postedOn: _edittedBook.postedOn,
                              postRating: _edittedBook.postRating,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      initialValue: _edittedBook.description,
                      focusNode: _descFocusNode,
                      keyboardType: TextInputType.number,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        labelText: 'Book description',
                      ),
                      textInputAction: TextInputAction.newline,
                      autovalidateMode: AutovalidateMode.always,
                      minLines: 3,
                      maxLines: 7,
                      // onFieldSubmitted: (_) {
                      //   FocusScope.of(context).requestFocus(_descFocusNode);
                      // },
                      validator: (value) {
                        if (value!.length < 50) {
                          return 'Please provide a big description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _edittedBook = Book(
                          id: _edittedBook.id,
                          author: _edittedBook.author,
                          bookName: _edittedBook.bookName,
                          userId: _edittedBook.userId,
                          postType: _edittedBook.postType,
                          boughtDate: _edittedBook.boughtDate,
                          description: value as String,
                          wishlisted: _edittedBook.wishlisted,
                          price: _edittedBook.price,
                          bookCount: _edittedBook.bookCount,
                          postedOn: _edittedBook.postedOn,
                          postRating: _edittedBook.postRating,
                        );
                      }),
                ),
                Container(
                  child: ToggleButtons(
                    isSelected: postTypeBuying,
                    color: Colors.grey,
                    selectedColor: Colors.white,
                    fillColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'Selling',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'Buying',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < postTypeBuying.length; i++) {
                          if (i == index)
                            postTypeBuying[i] = true;
                          else
                            postTypeBuying[i] = false;
                        }
                        ispostType = postTypeBuying[0];
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                    ),
                    // onPressed: _savePost,
                    onPressed: () {
                      if (_updatePost(loggedInUserSession, _edittedBook))
                        // _showUpdateSnackbar(context);
                        BotToast.showSimpleNotification(
                          title: 'Posted Updated Successfully',
                          duration: Duration(seconds: 3),
                          backgroundColor: ColorManager.primary,
                          titleStyle: getBoldStyle(color: ColorManager.white),
                          align: Alignment(1, 1),
                        );
                    },
                    child: Text(
                      'Update Post',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
