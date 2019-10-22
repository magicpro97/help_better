import 'package:equatable/equatable.dart';

abstract class Base extends Equatable {
  final String id;
  final DateTime created;
  final DateTime updated;

  Base(this.id, this.created, this.updated)
      : assert(id != null),
        assert(created != null);

  @override
  List<Object> get props => [id, created, updated];
}
