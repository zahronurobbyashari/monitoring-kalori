class Food {
  String? foodName;
  String? multiplier;

  Food();

  Map<String, dynamic> toJson() =>
      {'foodName': foodName, 'multiplier': multiplier};

  Food.fromSnapshot(snapshot)
      : foodName = snapshot.data()['food_name'],
        multiplier = snapshot.data()['multiplier'];
}
