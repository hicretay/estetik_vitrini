import 'dart:convert';

ImageModel imageModelFromJson(String str) => ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
    ImageModel({
        this.campaingImage,
    });

    List<CampaingImage>? campaingImage;

    factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        campaingImage: List<CampaingImage>.from(json["campaingImage"].map((x) => CampaingImage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "campaingImage": List<dynamic>.from(campaingImage!.map((x) => x.toJson())),
    };
}

class CampaingImage {
    CampaingImage({
        this.campaingPicture,
        this.mainPicture,
        this.pictureId,
        this.pictureActive,
    });

    String? campaingPicture;
    bool? mainPicture;
    int? pictureId;
    bool? pictureActive;

    factory CampaingImage.fromJson(Map<String, dynamic> json) => CampaingImage(
        campaingPicture: json["campaingPicture"],
        mainPicture: json["mainPicture"],
        pictureId: json["pictureId"],
        pictureActive: json["pictureActive"],
    );

    Map<String, dynamic> toJson() => {
        "campaingPicture": campaingPicture,
        "mainPicture": mainPicture,
        "pictureId": pictureId,
        "pictureActive": pictureActive,
    };
}