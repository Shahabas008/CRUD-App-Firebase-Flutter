CRUD APP

This app is truly for the beginners on firebase and flutter.

Initially create an account in firebase and connect the app to the firebase. You can read the tutorial here https://firebase.google.com/docs/android/setup


Firebase is one of the most popular BaaS used in mobile development. It offers a variety of services for mobile development, one of which we will be discussing in this article — Firebase Firestore. Firestore allows you to upload and retrieve data with very short and simple commands.

I have built this app to demonstrate Firestore CRUD ( Create Read Update Delete) operations.

![Screenshot_20221226_105125](https://user-images.githubusercontent.com/109640095/209571293-76a1cafe-c1f2-4658-adf3-072ef174f79b.png)


We start by creating a Firebase project. If you need help creating a project on Firebase, you can check out this documentation that will guide you through that.

*Add the following packages to pubspec.yaml file:

![Screenshot_20221226_104156](https://user-images.githubusercontent.com/109640095/209570717-b346576d-b7f6-4893-a7d3-c07d9758e1eb.png)


Next, we initialize Firebase in our project

*Make your main function an async function and add these lines before the runApp() function:

![Screenshot_20221226_104233](https://user-images.githubusercontent.com/109640095/209570754-98003861-fb88-4d39-8967-1c8cf25340c2.png)

*Import the required packages to the project.

![Screenshot_20221226_104223](https://user-images.githubusercontent.com/109640095/209570797-548b1d6c-4bdc-4a7c-a594-d37001bf452f.png)

---------------------------------------------------------------------------------------------------------------------------------------------------------------

When entering some inputs to the textfields such as NAME, STUDENTID, CGPA ,the input data are stored in the firestore(database).

*My firestore for the project

![Screenshot_20221226_102919](https://user-images.githubusercontent.com/109640095/209573496-35f367c5-1777-4125-bc93-fedbed329e6a.png)

-------------------------------------------------------------------------------------------------------------------------------------------------

CREATE/WRITE

clicking on the create button will store all the inputs from the texfield to the firestore.

![Untitled video - Made with Clipchamp](https://user-images.githubusercontent.com/109640095/209573306-cd7110ed-052f-4986-b165-e922ecb9ea17.gif)

-------------------------------------------------------------------------------------------------------------------------------------------------


UPDATE

clicking on the update button will update the inputs.

![Untitled video - Made with Clipchamp (2)](https://user-images.githubusercontent.com/109640095/209573665-9f198a26-07af-40aa-90c8-dcdd5888a12f.gif)

-------------------------------------------------------------------------------------------------------------------------------------------------


DELETE

clicking on the delete button will eliminate the desired data from the firestore. Only 'Name'textfield is required to delete an element.


![Untitled video - Made with Clipchamp](https://user-images.githubusercontent.com/109640095/209573901-b261e483-51f0-47d5-b741-92ce19d90625.gif)

-------------------------------------------------------------------------------------------------------------------------------------------------



*At last we using a area where the stored data are display.
used streambuilder to display data.StreamBuilder is a widget that builds itself based on the latest snapshot of interaction with a stream. This is mainly used in applications like chat application clock applications where the widget needs to rebuild itself to show the current snapshot of data.

*A DocumentReference refers to a document location in a FirebaseFirestore database and can be used to write, read, or listen to the location. The document at the referenced location may or may not exist. A DocumentReference can also be used to create a CollectionReference to a subcollection.

*On line 279,given a textwidget when the database has no data to display which shows "EMPTY DATABASE".




