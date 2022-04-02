import 'package:flutter/material.dart';

class dialog extends StatefulWidget {

  final ValueChanged <String> add_tweet;
  const  dialog(this.add_tweet);

  @override
  State<dialog> createState() => _dialogState();
}

class _dialogState extends State<dialog> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Center(
      child: AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.all(20),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Tweeter" ,style: TextStyle( fontWeight: FontWeight.w700 , fontSize: 20),),
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: myController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Quoi de neuf',
              hintStyle: TextStyle(fontSize: 18 , fontWeight: FontWeight.w500)
            ),
          ),
        ),
        actions: [
          FlatButton(
            child: Text("cancel" , style: TextStyle(fontWeight: FontWeight.w500),),
            onPressed:()=> Navigator.pop(context),
          ),
          FlatButton(
            child: Text("Tweeter" ,style: TextStyle(color: Colors.cyan , fontWeight: FontWeight.bold , fontSize: 16),),
            onPressed:(){
              widget.add_tweet(myController.text);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}