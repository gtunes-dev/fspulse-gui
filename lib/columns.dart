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

final List<ColumnSpec> mockRootsColumns = [
  ColumnSpec(id: 'path', label: 'Path'),
  ColumnSpec(id: 'lastScan', label: 'Last Scan', sortOrder: SortOrder.descending),
  ColumnSpec(id: 'itemCount', label: 'Item Count'),
];