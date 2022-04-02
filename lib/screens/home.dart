import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tp_4_m/screens/details.dart';
import 'package:tp_4_m/screens/dialog.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<dynamic> tweets = [];
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {





    add_tweet(String saha) async{
      Map map = {
        'image':'assets/Images/samy.jpg',
        'nom_user':'Belambri Samy',
        'tweet':saha.toString(),
        'date':DateTime.now().toString()
      };
      setState(() {

        tweets.add(map);
        print(tweets);
      });
      setState(() {

      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Twitter'),
        actions: [
          IconButton(
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (context) => dialog(add_tweet));

          }, icon: SvgPicture.asset("assets/Icons/icons8-twitter.svg" , color: Colors.white,))
        ],
      ),
      body: tweets.isEmpty?  Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('No tweets found!'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Please click the Twitter icon to add one"),
          ),
        ],
      ),)
          : ListView.builder(
        itemCount: tweets.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:  EdgeInsets.only(top:8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> details(tweets[index])));
                details(tweets[index]);
              },
              onLongPress: (){
                showDialog(
                  context: context,
                  builder: (context) =>
                  AlertDialog(
                    insetPadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.all(20),
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Suppression" ,style: TextStyle( fontWeight: FontWeight.w700 , fontSize: 20),),
                    ),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Vous confirmez la suppression ?'),
                    ),
                    actions: [
                      FlatButton(
                        child: Text("Annuler" , style: TextStyle( color: Colors.cyan ,fontWeight: FontWeight.bold),),
                        onPressed:()=> Navigator.pop(context),
                      ),
                      FlatButton(
                        child: Text("Oui" ,style: TextStyle(color: Colors.cyan , fontWeight: FontWeight.bold ,), ),
                        onPressed:(){
                          setState(() {
                            tweets.removeAt(index);
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
              child: Slidable(

               endActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion: const ScrollMotion(),

                  // A pane can dismiss the Slidable.
                  dismissible: DismissiblePane(onDismissed: () {}),

                  // All actions are defined in the children parameter.
                  children:  [
                    // A SlidableAction can have an icon and/or a label.
                    SlidableAction(
                      onPressed:(context)=>  showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      insetPadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.all(20),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Suppression" ,style: TextStyle( fontWeight: FontWeight.w700 , fontSize: 20),),
                      ),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Vous confirmez la suppression ?'),
                      ),
                      actions: [
                        FlatButton(
                          child: Text("Annuler" , style: TextStyle( color: Colors.cyan ,fontWeight: FontWeight.bold),),
                          onPressed:()=> Navigator.pop(context),
                        ),
                        FlatButton(
                          child: Text("Oui" ,style: TextStyle(color: Colors.cyan , fontWeight: FontWeight.bold ,), ),
                          onPressed:(){
                            setState(() {
                              tweets.removeAt(index);
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
              ),
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      onPressed: (context)=> showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          insetPadding: EdgeInsets.zero,
                          contentPadding: EdgeInsets.all(20),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Update" ,style: TextStyle( fontWeight: FontWeight.w700 , fontSize: 20),),
                          ),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: myController,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: 'Edit ur tweet',
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
                              child: Text("Update" ,style: TextStyle(color: Colors.cyan , fontWeight: FontWeight.bold , fontSize: 16),),
                              onPressed:(){
                              Map edit=  tweets.elementAt(index);
                              edit.update('tweet', (value) => myController.text);
                            setState(() {
                              tweets.removeAt(index);
                              tweets.insert(index, edit);
                              myController.clear();
                            });

                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      backgroundColor: Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                  ],
                ),

                child: Card(
                  elevation: 2,
                  child: ListTile(
                    leading :CircleAvatar(
                      backgroundImage: Image.asset(tweets[index]['image']).image,
                    ),
                    title: Text(tweets[index]['nom_user'] , style: TextStyle(color: Colors.cyan , fontWeight: FontWeight.bold),),
                    subtitle: Text(tweets[index]['tweet'] , style: TextStyle(fontWeight: FontWeight.w500),),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
