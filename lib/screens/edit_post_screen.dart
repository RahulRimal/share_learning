import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:share_learning/models/book.dart';
import 'package:share_learning/providers/books.dart';

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

  List<bool> sellingBuying = [true, false];
  var _edittedBook = Book(
    id: '',
    author: '',
    title: '',
    uId: '',
    selling: false,
    boughtTime: DateTime.now().toNepaliDateTime(),
    description: '',
    isWishlisted: false,
    price: 0,
    bookCount: 1,
  );

  bool isSelling = true;

  NepaliDateTime? _boughtTime;

  final _datePickercontroller = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(NepaliDateTime.now()).toString(),
  );

  @override
  void didChangeDependencies() {
    final bookId = ModalRoute.of(context)!.settings.arguments as String;
    if (bookId.isNotEmpty) {
      _edittedBook =
          Provider.of<Books>(context, listen: false).getBookById(bookId);

      isSelling = _edittedBook.selling;
      sellingBuying = [isSelling, !isSelling];
    } else
      print('Book Id Is Empty');

    _datePickercontroller.text =
        DateFormat('yyyy-MM-dd').format(_edittedBook.boughtTime).toString();

    super.didChangeDependencies();
  }

  Future<void> _showPicker(BuildContext context) async {
    _boughtTime = await picker.showAdaptiveDatePicker(
      context: context,
      initialDate: _edittedBook.boughtTime,
      firstDate: picker.NepaliDateTime(2070),
      lastDate: picker.NepaliDateTime.now(),
    );
    _datePickercontroller.text =
        DateFormat('yyyy-MM-dd').format(_boughtTime as DateTime).toString();
  }

  bool _updatePost() {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return false;
    }
    _form.currentState!.save();
    Provider.of<Books>(context, listen: false)
        .updatePost(_edittedBook.id, _edittedBook);
    Navigator.of(context).pop();
    Navigator.of(context).pop();

    return true;
  }

  void showUpdateSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        'Posted Updated Successfully',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Post'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_updatePost()) showUpdateSnackbar(context);
            },
          ),
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
                    initialValue: _edittedBook.title,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      labelText: 'Title',
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
                        return 'Please provide the title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _edittedBook = Book(
                        id: _edittedBook.id,
                        author: _edittedBook.author,
                        title: value as String,
                        uId: _edittedBook.uId,
                        selling: _edittedBook.selling,
                        boughtTime: _edittedBook.boughtTime,
                        description: _edittedBook.description,
                        isWishlisted: _edittedBook.isWishlisted,
                        price: _edittedBook.price,
                        bookCount: _edittedBook.bookCount,
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
                                title: _edittedBook.title,
                                uId: _edittedBook.uId,
                                selling: _edittedBook.selling,
                                boughtTime: _edittedBook.boughtTime,
                                description: _edittedBook.description,
                                isWishlisted: _edittedBook.isWishlisted,
                                price: _edittedBook.price,
                                bookCount: _edittedBook.bookCount,
                              );
                            }),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // initialValue: _edittedBook.boughtTime.toIso8601String(),
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

                                // _datePickercontroller.text = _boughtTime.toString();
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
                              title: _edittedBook.title,
                              uId: _edittedBook.uId,
                              selling: _edittedBook.selling,
                              // boughtTime: (DateFormat("yyyy/MM/dd")
                              //         .parse(value as String))
                              //     .toNepaliDateTime(),
                              boughtTime: NepaliDateTime.parse(value as String),

                              description: _edittedBook.description,
                              isWishlisted: _edittedBook.isWishlisted,
                              price: _edittedBook.price,
                              bookCount: _edittedBook.bookCount,
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
                                title: _edittedBook.title,
                                uId: _edittedBook.uId,
                                selling: _edittedBook.selling,
                                boughtTime: _edittedBook.boughtTime,
                                description: _edittedBook.description,
                                isWishlisted: _edittedBook.isWishlisted,
                                price: double.parse(value as String),
                                bookCount: _edittedBook.bookCount,
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
                              title: _edittedBook.title,
                              uId: _edittedBook.uId,
                              selling: isSelling,
                              boughtTime: _edittedBook.boughtTime,
                              description: _edittedBook.description,
                              isWishlisted: _edittedBook.isWishlisted,
                              price: _edittedBook.price,
                              bookCount: int.parse(value as String),
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
                          title: _edittedBook.title,
                          uId: _edittedBook.uId,
                          selling: isSelling,
                          boughtTime: _edittedBook.boughtTime,
                          description: value as String,
                          isWishlisted: _edittedBook.isWishlisted,
                          price: _edittedBook.price,
                          bookCount: _edittedBook.bookCount,
                        );
                      }),
                ),
                Container(
                  child: ToggleButtons(
                    isSelected: sellingBuying,
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
                        for (int i = 0; i < sellingBuying.length; i++) {
                          if (i == index)
                            sellingBuying[i] = true;
                          else
                            sellingBuying[i] = false;
                        }
                        isSelling = sellingBuying[0];
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
                      if (_updatePost()) showUpdateSnackbar(context);
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
