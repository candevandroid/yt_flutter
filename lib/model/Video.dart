class Video{
    String id;
    String title;
    String description;
    String screenshot;
    String channel;

    Video({this.id, this.title, this.description, this.screenshot, this.channel});

    factory Video.fromJson(Map<String, dynamic> json){
        return Video(
            id: json["id"]["videoId"],
            title: json["snippet"]["title"],
            description: json["snippet"]["description"],
            screenshot: json["snippet"]["thumbnails"]["high"]["url"],
            channel: json["snippet"]["channelTitle"],
        );
    }
}