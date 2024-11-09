abstract class Errors{
  String massage;

  Errors(this.massage);
}
class RemoteError extends Errors{
  RemoteError(super.massage);
}
class LocalError extends Errors{
  LocalError(super.massage);
}