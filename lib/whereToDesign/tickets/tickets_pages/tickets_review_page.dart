import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../rating_bar/rating_bar.dart';

class TicketsReviewPage extends StatefulWidget {
  const TicketsReviewPage({super.key});

  @override
  State<TicketsReviewPage> createState() => _TicketsReviewPageState();
}

class _TicketsReviewPageState extends State<TicketsReviewPage> {
  File? file;
  List<File> pickedImagesList = [];
  double _initialRating = 0.0;
  late double _rating;
  int _ratingBarMode = 1;
  bool addCommentValue = false;
  @override
  void initState() {
    _rating = _initialRating;
  }

// function for rating
  Widget _ratingBar(int mode) {
    switch (mode) {
      case 1:
        return RatingBar.builder(
          initialRating: _initialRating,
          minRating: 0,
          //direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 50.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );

      default:
        return Container();
    }
  }

// function to pick image from camera
  Future takeFromCamera(
    context,
  ) async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.camera);
    File image = File(xfile!.path);

    setState(() {
      file = image;
      pickedImagesList.add(file!);
    });
  }

// function to pick image from gallery
  Future takeFromGallary(context) async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xfile != null) {
      File image = File(xfile.path);
      setState(() {
        file = image;
        pickedImagesList.add(file!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              shadowColor: Colors.grey.shade300,
              elevation: 3,
              margin: EdgeInsets.only(bottom: 160),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please Rate',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        _ratingBar(_ratingBarMode),
                        // ...List.generate(
                        //   5,
                        //   (index) => Icon(
                        //     Icons.star,
                        //     color: Colors.yellow,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Add Photo',
                      style: TextStyle(fontSize: 20),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (pickedImagesList.length < 5) {
                                // dialog for image picking options.
                                // showDialog(
                                //   context: context,
                                //   builder: (context) {
                                //     return SimpleDialog(
                                //       children: [
                                //         TextButton(
                                //           child: Text('Chose from Camera'),
                                //           onPressed: () {
                                //             Navigator.of(context).pop();
                                //             setState(() {
                                //               takeFromCamera(context);
                                //             });
                                //           },
                                //         ),
                                //         TextButton(
                                //           onPressed: () {
                                //             Navigator.of(context).pop();
                                //             setState(() {
                                //               takeFromGallary(context);
                                //             });
                                //           },
                                //           child: Text('Chose from gallary'),
                                //         ),
                                //       ],
                                //     );
                                //   },
                                // );
                                // dialog for image picking option.
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 300,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10),
                                          //Chose from camera.
                                          Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  takeFromCamera(context);
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.camera_alt),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text('Chose from Camera'),
                                                    Spacer(),
                                                    Icon(Icons.arrow_right),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          // Chose from gallery.
                                          Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  takeFromGallary(context);
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.photo_album),
                                                    SizedBox(width: 15),
                                                    Text('Chose from gallary'),
                                                    Spacer(),
                                                    Icon(Icons.arrow_right),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'You can upload only 5 photos')));
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 8.0,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(color: Colors.grey),
                                  child: const Center(
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 50,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ...pickedImagesList
                              .map(
                                (element) => GestureDetector(
                                  onTap: () {
                                    // dialog for image deleting options.
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 300,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 10),
                                              //Delete button.
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      Navigator.of(context)
                                                          .pop();
                                                      pickedImagesList
                                                          .remove(element);
                                                    });
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.delete),
                                                        SizedBox(width: 15),
                                                        Text('Delete'),
                                                        Spacer(),
                                                        Icon(Icons.arrow_right),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              // Chose from Gallery button.
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.cancel),
                                                        SizedBox(width: 15),
                                                        Text('Cancel'),
                                                        Spacer(),
                                                        Icon(Icons.arrow_right),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (context) {
                                    //     return SimpleDialog(
                                    //       children: [
                                    //         TextButton(
                                    //           onPressed: () {
                                    //             setState(() {
                                    //               Navigator.of(context).pop();
                                    //               pickedImagesList
                                    //                   .remove(element);
                                    //             });
                                    //           },
                                    //           child: Text('delete'),
                                    //         ),
                                    //         TextButton(
                                    //             onPressed: () {
                                    //               setState(() {
                                    //                 Navigator.of(context).pop();
                                    //               });
                                    //             },
                                    //             child: Text('cancel'))
                                    //       ],
                                    //     );
                                    //   },
                                    // );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.file(
                                        element,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Your Comment',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        hintText: 'describe your impressions',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      maxLines: 15,
                      minLines: 10,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          addCommentValue = !addCommentValue;
                        });
                      },
                      child: Row(
                        children: [
                          addCommentValue == false
                              ? Icon(Icons.crop_square_rounded)
                              : Icon(
                                  Icons.check_box,
                                  color: Colors.green,
                                ),
                          SizedBox(width: 10),
                          Text('I agree with the rules for posting review')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Add comment',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
