import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample_design_system/components/tree_view/tree_view_item_data.dart';
import 'package:sample_design_system/components/tree_view/tree_viewer.dart';

void main() {
  testWidgets('Tree view - general test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TreeViewer(
            headerBuilder: (context, data, isRoot) {
              return Text(
                '${data.id} - ${(data.extra! as dynamic)['name']}',
                overflow: TextOverflow.ellipsis,
              );
            },
            treeData: [
              TreeViewItemData(
                id: '1',
                children: [],
                extra: {'name': 'empty item'},
              ),
              TreeViewItemData(
                id: '2',
                children: [
                  TreeViewItemData(
                    id: '4',
                    children: [
                      TreeViewItemData(
                        id: '5',
                        children: [],
                        extra: {'name': 'component 5'},
                      ),
                    ],
                    extra: {'name': 'asset 4'},
                  ),
                  TreeViewItemData(
                    id: '3',
                    children: [],
                    extra: {'name': 'asset 3'},
                  ),
                ],
                extra: {'name': 'location 2'},
              ),
            ],
          ),
        ),
      ),
      duration: const Duration(seconds: 2),
    );
    expect(find.textContaining('empty item'), findsOneWidget);
    final nonRederdComponent5 = find.text('component 5');
    await tester.pump(const Duration(seconds: 1));
    expect(nonRederdComponent5, findsNothing);
    await tester.ensureVisible(find.textContaining('location 2'));
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.textContaining('location 2'));
    await tester.pump(const Duration(seconds: 1));
    await tester.ensureVisible(find.textContaining('asset 4').first);
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.textContaining('asset 4').first);
    await tester.pump(const Duration(seconds: 1));
    final rederdComponent5 = find.textContaining('component 5');
    expect(rederdComponent5, findsOneWidget);
  });
}
