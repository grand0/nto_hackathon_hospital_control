class PostTempModel {
  late final double minTemperature;
  late final double maxTemperature;

  PostTempModel({
    required this.minTemperature,
    required this.maxTemperature,
  });

  PostTempModel.fromJson(Map<String, dynamic> json) {
    minTemperature = json['min_temp'];
    maxTemperature = json['max_temp'];
  }

  Map<String, dynamic> toJson() => {
        'min_temp': minTemperature,
        'max_temp': maxTemperature,
      };
}
