// To parse this JSON data, do
//
//     final chckEmailModel = chckEmailModelFromJson(jsonString);

import 'dart:convert';

CheckEmailModel chckEmailModelFromJson(String str) => CheckEmailModel.fromJson(json.decode(str));

String chckEmailModelToJson(CheckEmailModel data) => json.encode(data.toJson());

class CheckEmailModel {
    CheckEmailModel({
        this.exist,
        this.userType,
    });

    bool? exist;
    int? userType;  /// verify er somoy token dile user info asbe... na hole asbe na save kora token verify er somoy dbo kvbe oikhane jan

    factory CheckEmailModel.fromJson(Map<String, dynamic> json) => CheckEmailModel(
        exist: json["Exist"],
        userType: json["UserType"],
    );  /// ei token ta save kore rakhbo,,, pore verify er somoy token ta use korbo , token ta k string a raken hmmm.. string ii to
    ///respons token ta decode kore sting a rakhen
    /// kno pore oi string locally save korben.. ok... tai koren... tahole response jan

    Map<String, dynamic> toJson() => {
        "Exist": exist,
        "UserType": userType,
    };
}
