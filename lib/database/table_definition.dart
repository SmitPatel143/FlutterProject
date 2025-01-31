class TableDefinition {
  final String tableName;
  final Map<String, String> columns;
  final List<String> foreignKeys;
  final List<String> indices;

  TableDefinition(
      {required this.tableName,
      required this.columns,
      this.foreignKeys = const [],
      this.indices = const []});
}
