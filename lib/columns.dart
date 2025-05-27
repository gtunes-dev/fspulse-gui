class ColumnSpec {
  final String id;
  final String label;
  bool visible;
  SortOrder? sortOrder;

  ColumnSpec({
    required this.id,
    required this.label,
    this.visible = true,
    this.sortOrder,
  });
}

enum SortOrder { ascending, descending }

final List<ColumnSpec> rootsColumns = [
  ColumnSpec(id: 'root_id', label: 'Root Id'),
  ColumnSpec(id: 'path', label: 'Path'),
  ColumnSpec(id: 'lastScan', label: 'Last Scan', sortOrder: SortOrder.descending),
  ColumnSpec(id: 'itemCount', label: 'Item Count'),
];

final List<ColumnSpec> alertsColumns = [
  ColumnSpec(id: 'alert_id', label: 'Alert Id'),
  ColumnSpec(id: 'path', label: 'Path'),
  ColumnSpec(id: 'lastScan', label: 'Last Scan', sortOrder: SortOrder.descending),
  ColumnSpec(id: 'itemCount', label: 'Item Count'),
];

final List<ColumnSpec> changesColumns = [
  ColumnSpec(id: 'change_id', label: 'Change Id'),
  ColumnSpec(id: 'path', label: 'Path'),
  ColumnSpec(id: 'lastScan', label: 'Last Scan', sortOrder: SortOrder.descending),
  ColumnSpec(id: 'itemCount', label: 'Item Count'),
];

final List<ColumnSpec> itemsColumns = [
  ColumnSpec(id: 'item_id', label: 'Item Id'),
  ColumnSpec(id: 'path', label: 'Path'),
  ColumnSpec(id: 'lastScan', label: 'Last Scan', sortOrder: SortOrder.descending),
  ColumnSpec(id: 'itemCount', label: 'Item Count'),
];

final List<ColumnSpec> scansColumns = [
  ColumnSpec(id: 'scan_id', label: 'Scan Id'),
  ColumnSpec(id: 'path', label: 'Path'),
  ColumnSpec(id: 'lastScan', label: 'Last Scan', sortOrder: SortOrder.descending),
  ColumnSpec(id: 'itemCount', label: 'Item Count'),
];