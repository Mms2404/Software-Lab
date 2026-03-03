class BusinessHoursModel {
  final Map<String, List<String>> hours;

  const BusinessHoursModel({required this.hours});

  factory BusinessHoursModel.empty() {
    return const BusinessHoursModel(
      hours: {
        'mon': [],
        'tue': [],
        'wed': [],
        'thu': [],
        'fri': [],
        'sat': [],
        'sun': [],
      },
    );
  }

  Map<String, dynamic> toJson() => hours;
}