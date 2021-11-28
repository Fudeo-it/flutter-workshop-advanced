import 'package:uuid/uuid.dart';

class ExpenseModel {
  String uuid;
  double value;
  String? description;
  DateTime createdOn;

  ExpenseModel({
    required this.uuid,
    required this.value,
    required this.description,
    required this.createdOn,
  });

  factory ExpenseModel.create({
    required double value,
    required String? description,
    required DateTime createdOn,
  }) {
    return ExpenseModel(
      uuid: Uuid().v4(),
      value: value,
      description: description,
      createdOn: createdOn,
    );
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    final uuid = map["uuid"];
    final value = map["value"];
    final description = map["description"];
    final createdOn = DateTime.fromMillisecondsSinceEpoch(map["createdOn"]);

    return ExpenseModel(
      uuid: uuid,
      value: value,
      description: description,
      createdOn: createdOn,
    );
  }

  Map<String, dynamic> toMap() => {
        "uuid": uuid,
        "value": value,
        "description": description,
        "createdOn": createdOn.millisecondsSinceEpoch,
      };
}
