import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/core/services/snack_bar_service.dart';
import 'package:todo_app/core/utils/extract_date_time.dart';
import 'package:todo_app/models/task_model.dart';

import 'layout_view.dart';

class FirebaseUtils {
  Future<bool> creatAcount(String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print(credential.user?.email);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        SnackBarService.showErrorMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        SnackBarService.showErrorMessage(
            'The account already exists for that email.');
      }
      EasyLoading.dismiss();
      return Future.value(false);
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      return Future.value(false);
    }
  }

  Future<bool> loginUserAccount(String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      return Future.value(true);
      //print(credential.user?.email);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        SnackBarService.showErrorMessage("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        SnackBarService.showErrorMessage(
            'Wrong password provided for that user.');
      }
      print('Wrong password provided for that user.');
      SnackBarService.showErrorMessage(
          'Wrong password provided for that user.');
      EasyLoading.dismiss();
      return Future.value(false);
    }
  }
  //object convert map
  //map convert object
  CollectionReference<TaskModel>getCollectionRef(){
    var db = FirebaseFirestore.instance;
  return db.collection("Tasks_List").withConverter(
      fromFirestore: (snapshot, _) => TaskModel.fromFireStore(snapshot.data()!),
      toFirestore:(taskModel, options) => taskModel.toFireStore(), );

  }
  Future<void> addNewTask(TaskModel data){

    var collectionRef=getCollectionRef();
    var docRef=collectionRef.doc();
    data.id=docRef.id;
    return docRef.set(data);
  }
  //widegt called FutureWidget use is get Api and view it
  Future<List<TaskModel>>getDataFromFireStore(DateTime dateTime)async{
    var collectionRef=getCollectionRef().where("dateTime",isEqualTo:extractDateTime(dateTime).millisecondsSinceEpoch );
    var data=await collectionRef.get();
    return data.docs.map((e) => e.data()).toList();
  }
  Stream<QuerySnapshot<TaskModel>>getStreemDataFromFireStore(DateTime dateTime){
    var collectionRef=getCollectionRef().where("dateTime",isEqualTo:extractDateTime(dateTime).millisecondsSinceEpoch );
    return collectionRef.snapshots();
  }


  Future<void>deleteTask(TaskModel taskModel) {
    var collectionRef = getCollectionRef();
    return collectionRef.doc(taskModel.id).delete();
  }

  Future<void>updateTask(TaskModel taskModel) {
    var collectionRef = getCollectionRef();
    var dataRef =collectionRef.doc(taskModel.id);
    return dataRef.update(taskModel.toFireStore()); //use toFireStore()-->to convert from object to map
  }
}
