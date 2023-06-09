import 'package:demo_testing/services/firebase_service.dart';
import 'package:demo_testing/screens/list_screen.dart';
import 'package:demo_testing/models/user_req.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobController = TextEditingController();
  TextEditingController desController = TextEditingController();

  RxBool isSubmitting = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Demo',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildTextField(),
              const SizedBox(height: 15.0),
              buildEmailTextField(),
              const SizedBox(height: 15.0),
              buildMobileTextField(),
              const SizedBox(height: 15.0),
              buildDescriptionTextField(),
              const SizedBox(height: 20.0),
              buildButton(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const ListScreen(),transition: Transition.leftToRight);
        },
        child: const Icon(Icons.menu),
      ),
    );
  }

  Widget buildTextField() {
    return TextField(
      controller: nameController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: 'Name',
        hintStyle: const TextStyle(color: Colors.black54, fontSize: 20),
        suffix: const Icon(Icons.person, color: Colors.blue),
      ),
      onChanged: (text) {},
    );
  }

  Widget buildEmailTextField() {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: 'Email',
        hintStyle: const TextStyle(color: Colors.black54, fontSize: 20),
      ),
      onChanged: (text) {},
    );
  }

  Widget buildMobileTextField() {
    return TextField(
      controller: mobController,
      maxLength: 10,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: 'Mobile No',
        hintStyle: const TextStyle(color: Colors.black54, fontSize: 20),
      ),
      keyboardType: TextInputType.number,
      onChanged: (text) {},
    );
  }

  Widget buildDescriptionTextField() {
    return TextField(
      controller: desController,
      maxLines: 5,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: 'Description',
        hintStyle: const TextStyle(color: Colors.black54, fontSize: 20),
      ),
      keyboardType: TextInputType.text,
      onChanged: (text) {},
    );
  }

  Widget buildButton() {
    return Obx(
      () => isSubmitting.value
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                String name = nameController.text.trim();
                String email = emailController.text.trim();
                String mob = mobController.text.trim();
                String des = desController.text.trim();
                if (name.isEmpty) {
                  showMessage('Name can not be empty');
                } else if (email.isEmpty) {
                  showMessage('Email can not be empty');
                } else if (!GetUtils.isEmail(email)) {
                  showMessage('Invalid email address');
                } else if (mob.isEmpty) {
                  showMessage('Mobile no. can not be empty');
                } else if (mob.length < 10) {
                  showMessage('Invalid mobile number');
                } else if (des.isEmpty) {
                  showMessage('Description can not be empty');
                } else {
                  UserReq userReq = UserReq(
                    name: name,
                    email: email,
                    mobile: mob,
                    description: des,
                  );
                  isSubmitting.value = true;

                  nameController.clear();
                  emailController.clear();
                  mobController.clear();
                  desController.clear();
                  FirebaseService.addUserDetail(userReq).then((value) {
                    isSubmitting.value = false;
                    Get.to(const ListScreen());
                  });
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 24),
              ),
            ),
    );
  }

  void showMessage(String msg) {
    final snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(8),
      // for margin snackbar behavior should not be fixed
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      backgroundColor: Colors.red,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(width: 1, color: Colors.white)),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
