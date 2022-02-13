class DataModel {
  late final double temperature;
  late final double humidity;
  late final double light;
  late final double energy;
  late final bool motion;
  late final bool open;
  late final bool heater;
  late final bool cooler;
  late final bool unknownCard;
  late final bool thief;

  DataModel({
    required this.temperature,
    required this.humidity,
    required this.light,
    required this.energy,
    required this.motion,
    required this.open,
    required this.heater,
    required this.cooler,
    required this.unknownCard,
    required this.thief,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    temperature = json["temp"];
    humidity = json["hum"];
    light = json["light"];
    energy = json["energy"];
    motion = json["motion"];
    open = json["open"];
    heater = json["heater"];
    cooler = json["cooler"];
    unknownCard = json['unknown_card'];
    thief = json['thief'];
  }

  Map<String, dynamic> toJson() => {
        "temp": temperature,
        "hum": humidity,
        "light": light,
        "energy": energy,
        "motion": motion,
        "open": open,
        "heater": heater,
        "cooler": cooler,
        'unknown_card': unknownCard,
        'thief': thief,
      };
}
