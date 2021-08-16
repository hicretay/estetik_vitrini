import 'dart:convert';

StoryContentJsn storyContentJsnFromJson(String str) => StoryContentJsn.fromJson(json.decode(str));

String storyContentJsnToJson(StoryContentJsn data) => json.encode(data.toJson());

class StoryContentJsn {
    StoryContentJsn({
        this.success,
        this.result,
    });

    bool success;
    List<Result> result;

    factory StoryContentJsn.fromJson(Map<String, dynamic> json) => StoryContentJsn(
        success: json["success"],
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.id,
        this.storyContentPicture,
        this.storyContent,
    });

    int id;
    String storyContentPicture;
    String storyContent;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        storyContentPicture: json["storyContentPicture"],
        storyContent: json["storyContent"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "storyContentPicture": storyContentPicture,
        "storyContent": storyContent,
    };
}
