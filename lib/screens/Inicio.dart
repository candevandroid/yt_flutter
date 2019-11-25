import 'package:flutter/material.dart';
import 'package:yt_flutter/Api.dart';
import 'package:yt_flutter/model/Video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Inicio extends StatefulWidget {

   String query;
   Inicio(this.query);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {

    _listarVideos(String q){
        Api api = Api();
        return api.pesquisar(q);
    }

    return FutureBuilder<List<Video>>(
        future: _listarVideos(widget.query),
        builder: (context, snapshot){
            switch(snapshot.connectionState){
                case ConnectionState.none:
                case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                case ConnectionState.active:
                case ConnectionState.done:
                    if(snapshot.hasData){
                        return ListView.separated(
                            itemBuilder: (context, index){

                                List<Video> videos = snapshot.data;
                                Video video = videos[index];

                                return GestureDetector(
                                    onTap: (){
                                        FlutterYoutube.playYoutubeVideoById(
                                            apiKey: YOUTUBE_KEY,
                                            videoId: video.id,
                                            autoPlay: true,
                                            fullScreen: true,
                                        );
                                    },
                                    child: Column(
                                        children: <Widget>[
                                            Container(
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(video.screenshot)
                                                    )
                                                ),
                                            ),
                                            ListTile(
                                                title: Text(video.title),
                                                subtitle: Text(video.channel),
                                            )
                                        ],
                                    ),
                                );
                            },
                            separatorBuilder: (context, index) => Divider(
                                height: 3,
                                color: Colors.grey,
                            ),
                            itemCount: snapshot.data.length);
                    }else{
                        return Center(
                          child: Text("Nenhum dado a ser exibido!!"),
                        );
                    }
                    break;
            }
        },
    );
  }
}
