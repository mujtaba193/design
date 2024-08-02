import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeadPage extends StatefulWidget {
  const HeadPage({super.key});

  @override
  State<HeadPage> createState() => _HeadPageState();
}

class _HeadPageState extends State<HeadPage> {
  late TabController tabController;
  late ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return PopScope(
        child: Scaffold(
      appBar: AppBar(
        title: Text('BSW Page'),
      ),
      body:
          NestedScrollView(headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            elevation: 0,
            pinned: true,
            expandedHeight: 400,
            floating: false,
            stretch: true,
            collapsedHeight: 200,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white60,
            flexibleSpace: Container(
              height: 400,
              padding: EdgeInsets.only(bottom: 100),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: Image.network(
                    'https://www.postgrad.co.uk/wp-content/uploads/2021/11/University-of-Edinburgh.jpg'),
              ),
            ),
            leading: CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_sharp),
            ),
          ),
        ];
      }, body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            height: constraints.smallest.height,
          );
        },
      )),
    ));
  }
}
