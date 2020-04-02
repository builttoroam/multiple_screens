class Hinge {
  int angle;
  int accuracy;

  Hinge.fromJson(Map<String, dynamic> json) {
    angle = json['angle'];
    accuracy = json['accuracy'];
  }
}