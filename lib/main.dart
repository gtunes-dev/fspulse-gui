import 'package:flutter/material.dart';
import 'columns.dart';
import 'model/data_model.dart';
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

class _FsPulseHomePageState extends State<FsPulseHomePage>
    with SingleTickerProviderStateMixin {
  late final FsPulseDataModel _model;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _model = FsPulseDataModel();

    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {
        _model.activeDomain = DataDomain.values[_tabController.index];
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
      final columns = _model.current.columns;
      if (newIndex > oldIndex) newIndex -= 1;
      final item = columns.removeAt(oldIndex);
      columns.insert(newIndex, item);
    });
  }

  Widget _buildTabViewForCurrentDomain() {
    return Row(
      children: [
        Container(
          width: 200,
          color: Colors.grey.shade200,
          child: ColumnList(
            columns: _model.current.columns,
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
            child: Center(
              child: Text('Main Content: ${_model.activeDomain.name}'),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          bottom: TabBar(
            controller: _tabController,
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
          controller: _tabController,
          children: List.generate(5, (_) => _buildTabViewForCurrentDomain()),
        ),
      ),
    );
  }
}
