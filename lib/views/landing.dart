import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gpt_web/constants/constants.dart';
import 'package:gpt_web/views/components/gradienttext.dart';
import 'package:gpt_web/views/home.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  TextEditingController usercon = TextEditingController();

  final gptusers = FirebaseFirestore.instance.collection('gptusers');

  bool loading = false;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundClr,
      body: loading == true
      ? SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) 
      : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GradientText(
            "GPT Web",
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w900,
            ),
            gradient: LinearGradient(
              colors: [cyanC, torquiseT],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.0, 1.0],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          const Text(
            'Add your  Username',
            style: TextStyle(color: white, fontSize: 20),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.4),
            child: TextField(
              controller: usercon,
              style: TextStyle(color: white),
              onChanged: (value) {
                setState(() {
                  
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          usercon.text.isEmpty
            ? SizedBox()
            : ElevatedButton(
              child: Text('Submit'),
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                await FirebaseAuth.instance.signInAnonymously();
                // await FirebaseAuth.instance.;
                await gptusers.doc(FirebaseAuth.instance.currentUser?.uid).set({
                  'user': usercon.text
                }).whenComplete(() {
                  loading = false;
                  if(context.mounted){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView(user: usercon.text),));
                  }
                });
              }
            )
        ],
      ),
    );
  }
}