import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:orchid_furniture/backend/auth/auth.dart';
import 'package:orchid_furniture/constants.dart';
import 'package:orchid_furniture/frontend/widgets/home_card.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({super.key});

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  List<Map<String, dynamic>> postList = [];
  List<String> pids = [];
  getPosts() async {
    await FirebaseFirestore.instance
        .collection('Posts')
        .where('uid', isEqualTo: Auth().currentUser!.uid)
        .orderBy('time')
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) {
            setState(() {
              postList.add(element.data());
              pids.add(element.id);
            });
          },
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Posts'),
      ),
      body: Container(
        color: col30,
        child: ListView(
          children: [
            postList.isEmpty
                ? Center(child: Lottie.asset('assets/empty.json', height: 300))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: size.height * .7,
                      child: ListView.separated(
                          itemBuilder: (context, index) => HomeCard(
                                size: size,
                                pids: pids,
                                index: index,
                                postList: postList,
                              ),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 5,
                              ),
                          itemCount: postList.length),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
