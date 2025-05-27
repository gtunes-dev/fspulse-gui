import 'package:flutter/material.dart';
import '../columns.dart';

class ColumnList extends StatelessWidget {
  final List<ColumnSpec> columns;
  final void Function(ColumnSpec column, bool visible) onToggleVisibility;
  final void Function(ColumnSpec column) onToggleSortOrder;
  final void Function(int oldIndex, int newIndex) onReorder;

  const ColumnList({
    super.key,
    required this.columns,
    required this.onToggleVisibility,
    required this.onToggleSortOrder,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      buildDefaultDragHandles: false,
      onReorder: onReorder,
      padding: const EdgeInsets.only(top: 8.0),
      children: [
        for (int index = 0; index < columns.length; index++)
          ColumnRow(
            key: ValueKey(columns[index].id),
            column: columns[index],
            index: index,
            onToggleVisibility: onToggleVisibility,
            onToggleSortOrder: onToggleSortOrder,
          ),
      ],
    );
  }
}

class ColumnRow extends StatelessWidget {
  final ColumnSpec column;
  final int index;
  final void Function(ColumnSpec column, bool visible) onToggleVisibility;
  final void Function(ColumnSpec column) onToggleSortOrder;

  const ColumnRow({
    super.key,
    required this.column,
    required this.index,
    required this.onToggleVisibility,
    required this.onToggleSortOrder,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: -2),
      contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ReorderableDragStartListener(
            index: index,
            child: const Icon(Icons.drag_handle, size: 16),
          ),
          const SizedBox(width: 4),
          Transform.scale(
            scale: 0.9,
            child: Checkbox(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: column.visible,
              onChanged: (value) {
                if (value != null) {
                  onToggleVisibility(column, value);
                }
              },
            ),
          ),
        ],
      ),
      title: Text(column.label),
      trailing: MouseRegion(
  cursor: SystemMouseCursors.click,
  child: GestureDetector(
    onTap: () => onToggleSortOrder(column),
    behavior: HitTestBehavior.translucent,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Icon(
        column.sortOrder == SortOrder.ascending
            ? Icons.arrow_upward
            : column.sortOrder == SortOrder.descending
                ? Icons.arrow_downward
                : Icons.unfold_more, // neutral sort icon
        size: 16,
        color: Colors.grey.shade500,
      ),
    ),
  ),
),
    );
  }
}
