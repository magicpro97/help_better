import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class BaseEntity extends Equatable {
  final String id;
  final DateTime created;
  final DateTime updated;

  BaseEntity(
      {@required this.id, @required this.created, @required this.updated})
      : assert(id != null && created != null && updated != null);

  @override
  List<Object> get props => [id, created, updated];
}
