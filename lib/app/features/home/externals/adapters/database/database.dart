abstract class IDatabase<DB> {
  Future<DB> openConnection();
}
