import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:yt_flutter/model/Video.dart';

const YOUTUBE_KEY = "AIzaSyDCIYFc7pWtT30WcKLBMzDsDvDPeQhVmLo";
const URL_BASE = "https://www.googleapis.com/youtube/v3";

class Api{
    Future<List<Video>> pesquisar(String query) async{
        http.Response response = await http.get(
            URL_BASE + "/search"
                "?part=snippet&type=video&maxResults=20&order=relevance"
                "&key=${YOUTUBE_KEY}&q=${query}"
        );

        if(response.statusCode == 200){

            Map<String, dynamic> dadosJson = json.decode(response.body);
            List<Video> videos = dadosJson["items"].map<Video>(
                (map){
                    return Video.fromJson(map);
                }
            ).toList();

            return videos;

        }else{

        }
    }
}