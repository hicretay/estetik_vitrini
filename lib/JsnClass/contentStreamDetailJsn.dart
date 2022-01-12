import 'dart:convert';

ContentStreamDetailJsn contentStreamDetailJsnFromJson(String str) => ContentStreamDetailJsn.fromJson(json.decode(str));

String contentStreamDetailJsnToJson(ContentStreamDetailJsn data) => json.encode(data.toJson());

class ContentStreamDetailJsn {
    ContentStreamDetailJsn({
        this.success,
        this.result,
    });

    bool? success;
    List<Result>? result;

    factory ContentStreamDetailJsn.fromJson(Map<String, dynamic> json) => ContentStreamDetailJsn(
        success: json["success"],
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.campaingId,
        this.campaingTitle,
        this.campaingDetail,
        this.likeCount,
        this.liked,
        this.appointmentStatus,
        this.contentPictures,
    });

    int? campaingId;
    String? campaingTitle;
    String? campaingDetail;
    int? likeCount;
    bool? liked;
    bool? appointmentStatus;
    List<ContentPicture>? contentPictures;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        campaingId: json["campaingId"],
        campaingTitle: json["campaingTitle"],
        campaingDetail: json["campaingDetail"],
        likeCount: json["likeCount"],
        liked: json["liked"],
        appointmentStatus: json["appointmentStatus"],
        contentPictures: List<ContentPicture>.from(json["contentPictures"].map((x) => ContentPicture.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "campaingId": campaingId,
        "campaingTitle": campaingTitle,
        "campaingDetail": campaingDetail,
        "likeCount": likeCount,
        "liked": liked,
        "appointmentStatus": appointmentStatus,
        "contentPictures": List<dynamic>.from(contentPictures!.map((x) => x.toJson())),
    };
}

class ContentPicture {
    ContentPicture({
        this.cPicture,
    });

    String? cPicture;

    factory ContentPicture.fromJson(Map<String, dynamic> json) => ContentPicture(
        cPicture: json["cPicture"],
    );

    Map<String, dynamic> toJson() => {
        "cPicture": cPicture,
    };
}
