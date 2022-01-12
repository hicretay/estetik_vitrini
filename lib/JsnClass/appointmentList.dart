import 'dart:convert';

AppointmentListJsn appointmentListJsnFromJson(String str) => AppointmentListJsn.fromJson(json.decode(str));

String appointmentListJsnToJson(AppointmentListJsn data) => json.encode(data.toJson());

class AppointmentListJsn {
    AppointmentListJsn({
        this.success,
        this.result,
    });

    bool? success;
    List<Result>? result;

    factory AppointmentListJsn.fromJson(Map<String, dynamic> json) => AppointmentListJsn(
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
        this.id,
        this.companyName,
        this.operationName,
        this.appointmentTime,
        this.appointmentDate,
        this.confirmed,
    });

    int? id;
    String? companyName;
    String? operationName;
    String? appointmentTime;
    String? appointmentDate;
    bool? confirmed;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        companyName: json["companyName"],
        operationName: json["operationName"],
        appointmentTime: json["appointmentTime"],
        appointmentDate: json["appointmentDate"],
        confirmed: json["confirmed"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "companyName": companyName,
        "operationName": operationName,
        "appointmentTime": appointmentTime,
        "appointmentDate": appointmentDate,
        "confirmed":confirmed
    };
}
