
class Lectures {
  int _id = LectureId.id;
  String _name;
  int _credit;
  double _letterValue;

  Lectures(this._name, this._credit, this._letterValue);

  Lectures.withId (String name, int credit, double letterValue){
    this._id = LectureId.id++;
    this._name = name;
    this._credit = credit;
    this._letterValue = letterValue;
  }

  double get letterValue => _letterValue;

  set letterValue(double value) {
    _letterValue = value;
  }

  int get credit => _credit;

  set credit(int value) {
    _credit = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}

class LectureId {
  static int id = 100;
}