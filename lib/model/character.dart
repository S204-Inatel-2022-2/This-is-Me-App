class Character {
  final String id;
  final String sex;
  final String characterName;
  final int xp;
  final int level;

  Character(
      {required this.id,
      required this.sex,
      required this.characterName,
      required this.xp,
      required this.level});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
        id: json['id'],
        sex: json['sex'],
        characterName: json['characterName'],
        xp: json['xp'],
        level: json['level']);
  }
}
