import 'dart:convert';

import 'package:design/whereToDesign/models/user_model.dart';
import 'package:flutter/material.dart';

class UsersMainPage2 extends StatefulWidget {
  late List<UsersModel>? newUsersd;
  late List<UsersModel>? usersd;

  UsersMainPage2({
    Key? key,
    this.newUsersd,
    //this.userTimeNow1,
    //this.userTimeNow2,
  }) : super(key: key);

  @override
  State<UsersMainPage2> createState() => _UsersMainPageState();
}

class _UsersMainPageState extends State<UsersMainPage2> {
  late List<UsersModel>? usersd;
  List<dynamic>? usersList;

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  getUsers() async {
    var response = await DefaultAssetBundle.of(context)
        .loadString('asset/user_booking.json');
    usersList = json.decode(response);
    /*setState(() {
      usersd = usersList.map((e) => UsersModel.fromJson(e)).toList();
    });*/
    usersd = usersList!.map((e) => UsersModel.fromJson(e)).toList();
    return usersd;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  /* Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return WhereTo(usersd: usersd);
                    }),
                  );*/
                },
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 48),
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.7),
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          // offset: Offset(4.0, 4.0),
                          blurRadius: 10,
                          spreadRadius: 2),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Search',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  FutureBuilder(
                      future: getUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.newUsersd == null
                                  ? usersd!.length
                                  : widget.newUsersd!.length,
                              itemBuilder: (context, index) {
                                {
                                  if (widget.newUsersd != null) {
                                    return ListTile(
                                      title:
                                          Text(widget.newUsersd![index].name),
                                      subtitle:
                                          Text(widget.newUsersd![index].review),
                                      trailing: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              'Start: ${widget.newUsersd![index].bookedStartTime}'),
                                          Text(
                                              'End: ${widget.newUsersd![index].bookedFinishTime}'),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return ListTile(
                                      title: Text(usersd![index].name),
                                      subtitle: Text(usersd![index].review),
                                      trailing: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              'Start: ${usersd![index].bookedStartTime}'),
                                          Text(
                                              'End: ${usersd![index].bookedFinishTime}'),
                                        ],
                                      ),
                                    );
                                  }
                                }
                              });
                        }
                      }),
                ],
              )
              /*  ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: usersd.length,
                  itemBuilder: (context, index) {
                    if (widget.userTimeNow1 == null) {
                      return ListTile(
                        title: Text(usersd![index].name),
                        subtitle: Text(usersd![index].review),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Start: ${usersd![index].bookedStartTime}'),
                            Text('End: ${usersd![index].bookedFinishTime}'),
                          ],
                        ),
                      );
                    }
                  //  if (widget.userTimeNow1 != null)
                   //   return Text('${widget.userTimeNow2!.isBefore(usersd![index].bookedStartTime.toLocal())}');
                    if ((widget.userTimeNow1!.isAfter(
                            usersd![index].bookedFinishTime.toLocal()) ||
                        widget.userTimeNow2!.isBefore(
                            usersd![index].bookedStartTime.toLocal())))
                      return ListTile(
                        title: Column(
                          children: [
                            Text(usersd![index].name),
                            Text(
                                '${widget.userTimeNow2!.isBefore(usersd![index].bookedStartTime.toLocal())}'),
                          ],
                        ),
                        subtitle: Text(usersd![index].review),
                        trailing: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  'Start: ${usersd![index].bookedStartTime.toLocal()}'),
                              Text(
                                  'End: ${usersd![index].bookedFinishTime.toLocal()}'),
                              Text('${widget.userTimeNow1!.toLocal()}'),
                              Text('${widget.userTimeNow2!.toLocal()}'),
                            ],
                          ),
                        ),
                      );
                    // if (( widget.userTimeNow1!.isAfter(usersd![index].bookedFinishTime) &&  widget.userTimeNow2!isBefore(usersd![index].bookedStartTime)))
                    //   return ListTile(
                    //     title: Text(usersd![index].name),
                    //     subtitle: Text(usersd![index].review),
                    //     trailing: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.end,
                    //       children: [
                    //         Text('Start: ${usersd![index].bookedStartTime}'),
                    //         Text('End: ${usersd![index].bookedFinishTime}'),
                    //       ],
                    //     ),
                    //   );
                  }),*/
            ],
          ),
        ),
      ),
    );
  }
}
