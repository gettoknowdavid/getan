import 'package:flutter/material.dart';

import '../../../features/todo/presentation/pages/todo_page.dart';
import '../../../features/todo/presentation/widgets/add_todo_widget.dart';
import '../screen_enum.dart';

final ScreenWidget home = ScreenWidget(
  title: 'home',
  screen: ScreenEnum.home,
  widget: TodoPage(),
);

final ScreenWidget stats = ScreenWidget(
  title: 'stats',
  screen: ScreenEnum.stats,
  widget: StatsPage(),
);

final ScreenWidget add = ScreenWidget(
  title: 'add',
  screen: ScreenEnum.add,
  widget: AddTodoWidget(),
);

class ScreenWidget {
  final String title;
  final ScreenEnum screen;
  final Widget widget;

  ScreenWidget({this.title, this.screen, this.widget});
}

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
