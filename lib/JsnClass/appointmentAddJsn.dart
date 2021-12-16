import 'dart:convert';

AppointmentAddJsn appointmentAddJsnFromJson(String str) => AppointmentAddJsn.fromJson(json.decode(str));

String appointmentAddJsnToJson(AppointmentAddJsn data) => json.encode(data.toJson());

class AppointmentAddJsn {
    AppointmentAddJsn({
        this.success,
    });

    bool success;

    factory AppointmentAddJsn.fromJson(Map<String, dynamic> json) => AppointmentAddJsn(
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
    };
}