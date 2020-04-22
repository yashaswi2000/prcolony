import 'package:flutter/material.dart';
void main()
{
  runApp(SignUp());
}
class SignUp extends StatefulWidget {

  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
 String dropdownValue = 'RESIDENT';
/* String holder = '' ;
  List <String> name = [
    'RESIDENT',
    'VOLUNTEER'
    ] ;
 
  void getDropDownItem(){
 
    setState(() {
      holder = dropdownValue ;
    });
  }*/
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
     home : Scaffold(
        appBar: AppBar(
          title: const Text("Signup page",textAlign: TextAlign.center,),
          actions: <Widget>[
            FlatButton.icon(onPressed: (){widget.toggleView();}, icon: Icon(Icons.person), label: Text("Login"))
          ],
        ),
        resizeToAvoidBottomPadding: false,
       body : Container(
         width :MediaQuery.of(context).size.width,
         margin : EdgeInsets.fromLTRB(10, 20, 10, 20),
         padding : EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
        child: SingleChildScrollView(
                  child: Column(
               children: <Widget>[
                

      SizedBox(height:20),
    
      TextFormField(
        
  decoration: InputDecoration(
    icon :Icon(Icons.person,
    color : Colors.blue,),
     border:OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    
                                    width: 5.0),
                              ) ,
   
    labelText: 'Enter your name:'
  ),
),
SizedBox(height:20),
TextFormField(
  decoration: InputDecoration(
    icon : Icon(Icons.phone,
    color : Colors.green,),
     border:OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 5.0),
                              ) ,
   
    labelText: 'Mobile Number'
  ),
   keyboardType: TextInputType.number,
                
),
SizedBox(height:20),
TextFormField(
  decoration: InputDecoration(
    icon :Icon(Icons.streetview,
    color : Colors.black,),
     border:OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 5.0),
                              ) ,
  labelText: 'Street No'
  ),
   keyboardType: TextInputType.number,
                
),
SizedBox(height:20),
TextFormField(
  decoration: InputDecoration(
    icon : Icon(Icons.home,
                  color : Colors.red,
                  ),
     border:OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 5.0),
                              ) , 
  labelText: 'Plot No'
  ),
   keyboardType: TextInputType.number,
                
),
              SizedBox(
        height :20
              ),
               SizedBox(
                  child :
               Text("please select an option",style: TextStyle(color :Colors.black,fontSize: 20),),
             ),
          /* DropdownButton<String>( 
            value:dropdownValue,
           DropdownButton<String>( 
            value:name[0],
          
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black, fontSize: 18),
            underline: Container(
              height: 2,
              padding :EdgeInsets.fromLTRB(40, 20, 10, 20),
              color :Colors.grey[300],
              
            ),
            onChanged: (String data) {
              setState(() {
                dropdownValue = data;
              });
            },
            items: name.map<DropdownMenuItem<String>>((String value1) {
              return DropdownMenuItem<String>(
                value: value1,
                child: Text(value1),
              );
            }).toList(),
          ),*/
            DropdownButton<String>(
    value: dropdownValue,
    icon: Icon(Icons.arrow_drop_down),
    iconSize: 24,
    elevation: 16,
    style: TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
    underline: Container(
      height: 3,
      color :Colors.grey[200],

    ),
    onChanged: (String newValue) {
      setState(() {
        dropdownValue = newValue;
      });
    },
    items: <String>['RESIDENT', 'VOLUNTEER' ]
      .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })
      .toList(),
  ),
          SizedBox(height:19), 
RaisedButton(
                color :Colors.blue,
                padding :EdgeInsets.fromLTRB(40, 20, 40, 20),
              
                child : Text("submit",style:TextStyle(color :Colors.white,fontSize: 23),
                                             
                              ),onPressed:() async {
                               // final result = await Navigator.push(context,MaterialPageRoute(builder: (context) => Phoneverificationpage()));
                }   
                ),
               ]
          ),
        ),
                    ),
         )
           
       
    ,);
  }
}