import 'package:meta/meta.dart';

class OrderBy {
    final String field;
    bool desc;

    OrderBy({@required this.field, this.desc = false});
}
