import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';

class details extends StatefulWidget {
  Map map ;
   details(this.map) ;

  @override
  _detailsState createState() => _detailsState();
}


class _detailsState extends State<details> with WidgetsBindingObserver {
  final FlutterTts tts = FlutterTts();


  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);

    tts.setLanguage('en');
    tts.setSpeechRate(0.4);

    tts.speak(widget.map['tweet']);

    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }

  Future _stop() async {
    await tts.stop();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;

    if (isBackground) {
      print('baaack');
      _stop();
    }else{
      tts.speak(widget.map['tweet']);
    }

    /* if (isBackground) {
      // service.stop();
    } else {
      // service.start();
    }*/
  }




  @override
  Widget build(BuildContext context) {







    print(widget.map);
    var  dateTime =DateTime.parse(widget.map['date']);
    var format = DateFormat.yMEd().add_jms();


    @override ///3
    void dispose() {
      _stop();
      super.dispose();
    }

    return  Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _stop();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back , color: Colors.black,),
          ),
          title: Text('Details' , style: TextStyle(color: Colors.black),),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                 width: 200,
                 height: 180,
                 decoration: BoxDecoration(
                   image: DecorationImage(image: Image.asset(widget.map['image']).image ,fit: BoxFit.cover),
                     borderRadius: BorderRadius.all(Radius.circular(20)),
                 ),
               child: null,),
             ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Text(widget.map['nom_user']),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Text(widget.map['tweet']),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  child: Text(format.format(dateTime))),


              ],
            ),
          ),
        ),
    );
  }
}
