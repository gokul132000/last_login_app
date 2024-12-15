class LastLoginModel {
  String userId;
  int id;
  int dateTime;
  String ipAddress;
  String city;
  String generatorNumber;

  LastLoginModel(
      {
        this.userId = '',
        required this.id,
        this.dateTime = 0,
        this.ipAddress = "0.0",
        this.city = "0.0",
        this.generatorNumber = "0",
      });

  factory LastLoginModel.fromMap(Map<dynamic, dynamic> map) {
    return LastLoginModel(
        userId: map['userId'] ?? "",
        id: map['id'] ?? 0,
        dateTime: map['dateTime'] ?? 0,
        ipAddress: map['ipAddress'] ?? "0.0",
        city: map['city'] ?? "0.0",
        generatorNumber: map["generatorNumber"] ?? "0",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "id": id,
      "dateTime": dateTime,
      "ipAddress": ipAddress,
      "city": city,
      "generatorNumber": generatorNumber,
    };
  }

  LastLoginModel copyWith({
    String? userId,
    int? id,
    int? dateTime,
    String? ipAddress,
    String? city,
    String? generatorNumber,
  }) {
    return LastLoginModel(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      ipAddress: ipAddress ?? this.ipAddress,
      city: city ?? this.city,
      generatorNumber: generatorNumber ?? this.generatorNumber,
    );
  }
}

