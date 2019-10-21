class Screens {
  final _value;

  const Screens._internal(this._value);

  toString() => '$_value';

  static const WELCOME = Screens._internal('/welcome');
  static const USER_TYPE = Screens._internal('/user_type');
  static const NICKNAME = Screens._internal('/nickname');
  static const MAIN = Screens._internal('/main');
  static const MESSAGE = Screens._internal('/message');
}
