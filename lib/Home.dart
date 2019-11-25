import 'package:flutter/material.dart';
import 'package:yt_flutter/CustomSearchDelegate.dart';
import 'package:yt_flutter/screens/Biblioteca.dart';
import 'package:yt_flutter/screens/EmAlta.dart';
import 'package:yt_flutter/screens/Inicio.dart';
import 'package:yt_flutter/screens/Inscricoes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

   int _currentIndex = 0;
   String _result = "";

  @override
  Widget build(BuildContext context) {

     List<Widget> _telas = [
         Inicio(_result),
         EmAlta(),
         Inscricoes(),
         Biblioteca()
     ];

    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
                color: Colors.grey,
                opacity: 1
            ),
            backgroundColor: Colors.white,
            title: Image.asset(
                "images/youtube.png",
                width: 98,
                height: 22,
            ),
            actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async{
                        String res = await showSearch(context: context, delegate: CustomSearchDelegate());
                        setState(() {
                          _result = res;
                        });
                    },
                ),
            ],
        ),
        body: Container(
            padding: EdgeInsets.all(16),
            child: _telas[_currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.red,
            onTap: (index){
                setState(() {
                  _currentIndex = index;
                });
            },
            items: [
                BottomNavigationBarItem(
                    title: Text("Início"),
                    icon: Icon(Icons.home)
                ),
                BottomNavigationBarItem(
                    title: Text("Em alta"),
                    icon: Icon(Icons.whatshot)
                ),
                BottomNavigationBarItem(
                    title: Text("Inscrições"),
                    icon: Icon(Icons.subscriptions)
                ),
                BottomNavigationBarItem(
                    title: Text("Biblioteca"),
                    icon: Icon(Icons.folder)
                ),
            ]
        ),
    );
  }
}
