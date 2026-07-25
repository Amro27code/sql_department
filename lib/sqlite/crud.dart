abstract class CRUD {
  //Future<int> بخليه bool لانه مش بهمني الرقم اللي برجعلياياه فيهم اللي بهمني انه عمل insert او لا
  Future<bool> insert({
    required Map<String, Object?> values,
    required String tableName,
  });

  Future<bool> update({required String userName,required int id});

  Future<bool> delete();

  Future<List<Map<String, Object?>>> select({required String tableName});
}
