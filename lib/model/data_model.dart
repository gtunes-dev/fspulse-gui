import '../columns.dart';

enum DataDomain { roots, scans, items, changes, alerts }

class FsPulseDataModel {
  DataDomain activeDomain = DataDomain.roots;

  final Map<DataDomain, TableModel> _tables = {
    DataDomain.roots: TableModel(columns: [...rootsColumns]),
    DataDomain.scans: TableModel(columns: [...scansColumns]), // placeholder
    DataDomain.items: TableModel(columns: [...itemsColumns]),
    DataDomain.changes: TableModel(columns: [...changesColumns]),
    DataDomain.alerts: TableModel(columns: [...alertsColumns]),
  };

  TableModel get current => _tables[activeDomain]!;

  TableModel getTable(DataDomain domain) => _tables[domain]!;
}

class TableModel {
  final List<ColumnSpec> columns;
  final List<Map<String, dynamic>> rows = [];

  TableModel({required this.columns});
}