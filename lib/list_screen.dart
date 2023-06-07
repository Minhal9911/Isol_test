import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_testing/firebase_service.dart';
import 'package:demo_testing/user_req.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: SizedBox(
            height: 40,
            width: 200,
            child: Marquee(
              text: 'List Screen',
              style: const TextStyle(color: Colors.white),
              blankSpace: 20.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.purple,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          )),
      body: StreamBuilder(
        stream: FirebaseService.getUsers(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text("Data not found"));
          }
          List<UserReq> userList = getUserItems(snapshot);

          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Text('😊 Name: ${userList[index].name}'),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('✉ Email: ${userList[index].email}'),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('📱 Mobile: ${userList[index].mobile}'),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('📖 Description: ${userList[index].description}'),
                      const SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                )),
              );
            },
          );
        },
      ),
    );
  }

  List<UserReq> getUserItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.map((e) {
      var userMap = e.data() as Map<String, dynamic>;
      return UserReq.fromJson(userMap);
    }).toList();
  }
}
