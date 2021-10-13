import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:share_learning/models/book.dart';

class AddPostScreen extends StatefulWidget {
  static const routeName = '/add-post';

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _form = GlobalKey<FormState>();

  final _authorFocusNode = FocusNode();
  final _dateFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _booksCountFocusNode = FocusNode();
  final _descFocusNode = FocusNode();

  picker.NepaliDateTime? _boughtTime;

  var _edittedBook = Book(
    id: '',
    author: '',
    title: '',
    uId: '',
    selling: false,
    boughtTime: DateTime.now(),
    description: '',
    isWishlisted: false,
    price: 0,
  );

  final _datePickercontroller = TextEditingController(
    text:
        DateFormat('yyyy/MM/dd').format(picker.NepaliDateTime.now()).toString(),
  );

  Future<void> _showPicker(BuildContext context) async {
    _boughtTime = await picker.showAdaptiveDatePicker(
      context: context,
      initialDate: picker.NepaliDateTime.now(),
      firstDate: picker.NepaliDateTime(2070),
      lastDate: picker.NepaliDateTime.now(),
    ) as picker.NepaliDateTime;

    _datePickercontroller.text =
        DateFormat('yyyy/MM/dd').format(_boughtTime as DateTime).toString();
  }

  void _savePost() {
    _form.currentState!.save();

    print(_edittedBook.title);
    print(_edittedBook.author);
    print(_edittedBook.boughtTime);
    print(_edittedBook.price);
    print(_edittedBook.description);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Post'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
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
                        return 'Please provide a value.';
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
                      );
                    }
                    ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          cursorColor: Theme.of(context).primaryColor,
                          focusNode: _authorFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Author',
                            focusColor: Colors.redAccent,
                          ),
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.always,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_dateFocusNode);
                          },
                          onSaved: (value) {
                      _edittedBook = Book(
                        id: _edittedBook.id,
                        author: value as String,
                        title: _edittedBook.title,
                        uId: _edittedBook.uId,
                        selling: _edittedBook.selling,
                        boughtTime: _edittedBook.boughtTime,
                        description: _edittedBook.description,
                        isWishlisted: _edittedBook.isWishlisted,
                        price: _edittedBook.price,
                      );
                    }
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
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
                          onSaved: (value) {
                      _edittedBook = Book(
                        id: _edittedBook.id,
                        author: _edittedBook.author,
                        title: _edittedBook.title,
                        uId: _edittedBook.uId,
                        selling: _edittedBook.selling,
                        boughtTime: DateFormat("yyyy/MM/dd").parse(value as String),
                        description: _edittedBook.description,
                        isWishlisted: _edittedBook.isWishlisted,
                        price: _edittedBook.price,
                      );
                    }
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
                      );
                    }
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          focusNode: _booksCountFocusNode,
                          initialValue: '1',
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
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    focusNode: _descFocusNode,
                    keyboardType: TextInputType.number,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      labelText: 'Book description',
                    ),
                    textInputAction: TextInputAction.newline,
                    autovalidateMode: AutovalidateMode.always,
                    // onFieldSubmitted: (_) {
                    //   FocusScope.of(context).requestFocus(_descFocusNode);
                    // },

                    onSaved: (value) {
                    _edittedBook = Book(
                      id: _edittedBook.id,
                      author: _edittedBook.author,
                      title: _edittedBook.title,
                      uId: _edittedBook.uId,
                      selling: _edittedBook.selling,
                      boughtTime: _edittedBook.boughtTime,
                      description: value as String,
                      isWishlisted: _edittedBook.isWishlisted,
                      price: _edittedBook.price,
                    );
                  }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                    ),
                    onPressed: _savePost,
                    child: Text(
                      'Add this Post',
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
