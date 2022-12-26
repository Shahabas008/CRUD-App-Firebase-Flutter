import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);

  runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
    home: const MyApp(),
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.amber[500],
    ),
  ));
}

// This widget is the root of your application.

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String stdName, stdID;
  late double stdGPA;
  studentName(name) {
    stdName = name;
  }

  getStudentID(id) {
    stdID = id;
  }

  getStudentCGPA(result) {
    stdGPA = double.parse(result);
  }

  createData() {
    DocumentReference students =
        FirebaseFirestore.instance.collection('students').doc(stdName);

    // create Map to send data in key:value pair form
    Map<String, dynamic> student =
        ({"studentName": stdName, "studentID": stdID, "studentCGPA": stdGPA});

    // send data to Firebase
    students.set(student).whenComplete(() => debugPrint('$stdName created'));
  }

  readData() {
    DocumentReference students =
        FirebaseFirestore.instance.collection('students').doc();

    // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    students.get().then((students) {
      debugPrint(students["studentName"]);
      debugPrint(students["studentID"]);
      debugPrint(students["studentCGPA"]);
    });
  }

  updateData() {
    DocumentReference students =
        FirebaseFirestore.instance.collection('students').doc(stdName);

    Map<String, dynamic> student =
        ({"studentName": stdName, "studentID": stdID, "studentCGPA": stdGPA});

    // update data to Firebase
    students.update(student).whenComplete(() => debugPrint('$stdName updated'));
  }

  deleteData() {
    DocumentReference students =
        FirebaseFirestore.instance.collection('students').doc(stdName);

    // delete data from Firebase
    students.delete().whenComplete(
          () => debugPrint('$stdName deleted'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
            home: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.green.shade400,
                  centerTitle: true,
                  title: const Text(
                    'C R U D',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                body: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (String name) {
                            setState(() {
                              studentName(name);
                            });
                          },
                          decoration:  InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green.shade400),
                              ),
                            prefixIcon: Icon(Icons.person,
                             color: Colors.green.shade400,),
                            border:const UnderlineInputBorder(),
                            labelText: 'Name',
                             labelStyle: TextStyle(
                                color: Colors.green.shade400,
                              )
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          onChanged: (String sID) {
                            getStudentID(sID);
                          },
                          decoration:  InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green.shade400),
                              ),
                            prefixIcon: Icon(Icons.school,
                             color: Colors.green.shade400,),
                            border: const UnderlineInputBorder(),
                            labelText: 'Student ID',
                             labelStyle: TextStyle(
                                color: Colors.green.shade400,
                              )
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          onChanged: (String gpa) {
                            getStudentCGPA(gpa);
                          },
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green.shade400),
                              ),
                              prefixIcon: Icon(
                                Icons.newspaper,
                                color: Colors.green.shade400,
                              ),
                              border: const UnderlineInputBorder(),
                              labelText: 'CGPA',
                              labelStyle: TextStyle(
                                color: Colors.green.shade400,
                              )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: () => createData(),
                                child: const Text('CREATE')),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                onPressed: () => readData(),
                                child: const Text('READ')),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                ),
                                onPressed: () => updateData(),
                                child: const Text('UPDATE')),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () => deleteData(),
                                child: const Text('DELETE')),
                          ],
                        ),
                       const SizedBox(
                        height: 50,
                       ),
              Row(
                children:const [
                  Expanded(
                    child: Text(
                      'Name',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Student ID',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  
                  Expanded(
                    child: Text(
                      'CGPA',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
                        const SizedBox(height: 10.0),
                        StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('students').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      // ignore: unnecessary_cast
                      itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot students =
                            // ignore: unnecessary_cast
                            (snapshot.data! as QuerySnapshot).docs[index];
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                students["studentName"],
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                students["studentID"],
                                textAlign: TextAlign.center,
                              ),
                            ),
                            
                            Expanded(
                              child: Text(
                                students["studentCGPA"].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return const Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Text('NO DATA FOUND')
                      );
                  }
                },
              ),
                      ],
                    ),
                  )),
                ))));
  }
}
