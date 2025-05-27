import 'package:flutter/material.dart';
import 'columns.dart';
import 'widgets/column_list.dart';

void main() {
  runApp(const FsPulseApp());
}

class FsPulseApp extends StatelessWidget {
  const FsPulseApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FsPulse',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const FsPulseHomePage(title: 'FsPulse'),
    );
  }
}

class FsPulseHomePage extends StatefulWidget {
  const FsPulseHomePage({super.key, required this.title});
  final String title;

  @override
  State<FsPulseHomePage> createState() => _FsPulseHomePageState();
}

class _FsPulseHomePageState extends State<FsPulseHomePage> {
  void _handleToggleSortOrder(ColumnSpec column) {
    setState(() {
      column.sortOrder = switch (column.sortOrder) {
        null => SortOrder.ascending,
        SortOrder.ascending => SortOrder.descending,
        SortOrder.descending => null,
      };
    });
  }

  void _handleReorder(int oldIndex, int newIndex) {
  setState(() {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = mockRootsColumns.removeAt(oldIndex);
    mockRootsColumns.insert(newIndex, item);
  });
}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Roots'),
              Tab(text: 'Scans'),
              Tab(text: 'Items'),
              Tab(text: 'Changes'),
              Tab(text: 'Alerts'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Row(
              children: [
                Container(
                  width: 200,
                  color: Colors.grey.shade200,
                  child: ColumnList(
                    columns: mockRootsColumns,
                    onToggleVisibility: (column, visible) {
                      setState(() {
                        column.visible = visible;
                      });
                    },
                    onToggleSortOrder: _handleToggleSortOrder,
                    onReorder: _handleReorder,
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: const Center(child: Text('Main Content: Roots')),
                  ),
                ),
              ],
            ),
            Center(child: Text('Scans View')),
            Center(child: Text('Items View')),
            Center(child: Text('Changes View')),
            Center(child: Text('Alerts View')),
          ],
        ),
      ),
    );
  }
}
