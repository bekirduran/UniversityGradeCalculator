import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:university_grade_calculation/Model/lectures.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _controller = TextEditingController();
  var lectureName;
  var selectedCredit;
  var selectedLetter;
  var gradeAverage = 0.0;
  List<Lectures> myLectureList;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    myLectureList = [];
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Theme(
      data: ThemeData(
          primaryColor: Colors.orange.shade400,
          accentColor: Colors.teal.shade400),
      child: Scaffold(
      //  appBar: AppBar(  title: Text("University Grade Calculate"), ),
        body: Form(
          child: (orientation == Orientation.portrait)
              ? buildBodyPortraitSection()
              : buildBodyLandscapeSection(),
        ),
        floatingActionButton: buildButtonSaveData(),
      ),
    );
  }

  Widget buildBodyLandscapeSection(){
    return Container(

      padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
        Expanded(child: SingleChildScrollView(

          child: Column(
            children: [
              SizedBox(height: 20,),
              buildTopSection(),
              SizedBox(height: 50,),
              buildMiddleSection()
            ],
          ),
        ), flex: 1,),

        Expanded(child: buildLecturesList(), flex:1,)
      ],),
    );
}

  Widget buildBodyPortraitSection() {
    return Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildTopSection(),
            buildMiddleSection(),
            buildBottomSection(),
          ],
        ),
      );
  }


  Widget buildTopSection() {
    return Container(
      //color: Colors.blue,
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            buildTextFormFiled(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildDropDownLectureCredit(),
                  buildDropDownLectureLetters(),
                ],

              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMiddleSection() {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(15),
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: myLectureList.length == 0? "Add Lecture to Calculate":"Grade Average : ",style: myTextStyle().copyWith(fontSize: 25)),
              TextSpan(text:  myLectureList.length == 0? "":"${gradeAverage.toStringAsFixed(2)}", style: myTextStyle().copyWith(fontSize: 30, color: Colors.green))
            ]
          ),
        ),
      ),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(30))),
    );
  }

  Widget buildBottomSection() {
    return Flexible(
      child: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          // color: Colors.brown,
          child: buildLecturesList()),
    );
  }

  FloatingActionButton buildButtonSaveData() {
    return FloatingActionButton(
      child: Icon(Icons.save),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          setState(() {
            calculateAverage();
            _controller.clear();
          });
        }
      },
    );
  }



  //TextFromFiled Entry Lecture Name
  buildTextFormFiled() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        validator: (value) {
          if (value.length < 5) {
            return "Invalid entry";
          } else {
            return null;
          }
        },
        onSaved: (value) {
          setState(() {
            lectureName = value;
            myLectureList
                .add(Lectures.withId(lectureName, selectedCredit, selectedLetter));
          });
        },
        textAlign: TextAlign.center,
        controller: _controller,
        decoration: InputDecoration(
            icon: Icon(Icons.chrome_reader_mode),
            border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(30))),
            suffixIcon: IconButton(onPressed:()=> _controller.clear(), icon: Icon(Icons.clear),),
            labelText: "Enter the Lesson",
            labelStyle: myTextStyle(),
            hintText: "Physics"),
      ),
    );
  }

  //DropDownButton about LECTURE CREDITS
  buildDropDownLectureCredit() {
    return Flexible(
      child: Container(
        padding: EdgeInsets.only(left: 25),
        margin: EdgeInsets.only(right: 15),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<int>(
            items: myDropItemList(),
            onChanged: (selection) {
              setState(() {
                selectedCredit = selection;
              });
            },
            value: selectedCredit,
            validator:  (selection) {
              if(selection == null){
                return "Select Credit";
              }else {
                return null;
              }
            },
          ),
        ),
        decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            borderRadius: BorderRadius.horizontal(left: Radius.circular(20))),
      ),
    );
  }

//DropDownButton CREDITS menu items
  List<DropdownMenuItem<int>> myDropItemList() {
    List<DropdownMenuItem<int>> myCreditList = [];
    for (int i = 1; i < 11; i++) {
      var newStepItems = DropdownMenuItem<int>(
          value: i,
          child: Center(
            child: Text(
              "$i Credit",
              style: myTextStyle(),
            ),
          ));
      myCreditList.add(newStepItems);
    }
    return myCreditList;
  }

  //DropDownButton about LECTURE LETTERS
  buildDropDownLectureLetters() {
    return Flexible(
      child: Container(
        padding: EdgeInsets.only(left: 25),
        margin: EdgeInsets.only(left: 15),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<double>(
            items: myLetterDropItemList(),
            onChanged: (selection) {
              setState(() {
                selectedLetter = selection;
              });
            },
            value: selectedLetter,
            validator:  (selection) {
              if(selection == null){
                return "Select letter";
              }else {
                return null;
              }
            },
          ),
        ),
        decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            borderRadius: BorderRadius.horizontal(left: Radius.circular(20))),
      ),
    );
  }

//DropDownButton LETTERS menu items
  List<DropdownMenuItem<double>> myLetterDropItemList() {
    List<DropdownMenuItem<double>> myList = [];
    for (double i = 4.0; i >= 0; i = i - 0.5) {
      myList.add(DropdownMenuItem<double>(
        child: Center(
          child: Text(
            letterAdder(i),
            style: myTextStyle(),
          ),
        ),
        value: i,
      ));
    }
    return myList;
  }

  // Letter switch statement
  String letterAdder(double i) {
    switch (i.toString()) {
      case "4.0":
        return "AA";
      case "3.5":
        return "BA";
      case "3.0":
        return "BB";
      case "2.5":
        return "CB";
      case "2.0":
        return "CC";
      case "1.5":
        return "DC";
      case "1.0":
        return "DD";
      case "0.5":
        return "FD";
      case "0.0":
        return "FF";
    }
    return "null";
  }

  //Text style
  TextStyle myTextStyle() {
    return TextStyle(
      color: Colors.black54,
      fontSize: 20,
      fontWeight: FontWeight.w400,
      decorationThickness: 5,
    );
  }

  //LECTURE ListView BUILDER
  Widget buildLecturesList() {
    return ListView.builder(
        itemBuilder: _listViewItemBuilder, itemCount: myLectureList.length);
  }

  // ListView ListTile items.
  Widget _listViewItemBuilder(BuildContext context, int index) {
    var lecture = myLectureList[index];

    return Dismissible(
      key: Key("${myLectureList[index].id}") ,
      direction: DismissDirection.endToStart,
      onDismissed: (value){
      setState(() {
        myLectureList.removeAt(index);
        calculateAverage();
      });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ),
        color: Colors.orange[50],
        child: ListTile(
          leading: Icon(Icons.menu_book),
          title: Text(lecture.name),
          subtitle: Text(
              "Credit : ${lecture.credit} - Letter Value: ${lecture.letterValue}"),
        ),
      ),
    );
  }

  // Grade calculator method
  void calculateAverage() {
    var totalCredit = 0.0;
    var totalGrade= 0.0;
    for (var i in myLectureList){
      var eachCredit = i.credit;
      var eachLetterValue = i.letterValue;

      totalCredit += eachCredit;
      totalGrade += (eachLetterValue * eachCredit);
    }

    gradeAverage = totalGrade / totalCredit;
  }
}
