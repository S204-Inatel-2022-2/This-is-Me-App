class Quest {
  final String questId;
  final String name;
  final String skill;
  final String startTime;
  final String endTime;
  final String duration;
  final String color;
  final int xp;

  Quest({
    required this.questId,
    required this.name,
    required this.skill,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.color,
    required this.xp,
  });

  factory Quest.fromJson(Map<String, dynamic> json) {
    return Quest(
      questId: json['questId'],
      name: json['name'],
      skill: json['skill'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      duration: json['duration'],
      color: json['color'],
      xp: json['xp'],
    );
  }
}
