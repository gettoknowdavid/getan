import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/todo/presentation/bloc/todo_bloc.dart';
import '../../../features/todo/presentation/widgets/add_todo_widget.dart';
import '../../bottom_nav/bloc/bottom_nav_bloc.dart';
import '../../bottom_nav/widgets/bottom_nav_bar.dart';
import '../../bottom_nav/widgets/bottom_nav_bar_item.dart';
import '../../widgets/custom_bottom_sheet.dart';
import '../screen_enum.dart';
import 'screen_widget.dart';

class BottomNavBarContainer extends StatelessWidget {
  const BottomNavBarContainer({Key key, @required this.selectedIndex})
      : super(key: key);

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = context.read<BottomNavBloc>();
    return BottomNavBar(
      items: _items(context),
      selectedIndex: selectedIndex,
      onSelected: (i) {
        bloc..add(UpdateBottomNav(ScreenEnum.values[i]));
      },
    );
  }

  Widget _icons(ScreenEnum screen, BuildContext context) {
    final theme = Theme.of(context);
    // ignore: close_sinks
    final bloc = context.read<TodoBloc>();

    switch (screen) {
      case ScreenEnum.home:
        return Icon(Icons.home);
        break;
      case ScreenEnum.stats:
        return Icon(Icons.bar_chart_rounded);
        break;
      default:
        return Material(
          color: Colors.white,
          elevation: 20,
          shadowColor: theme.colorScheme.primary.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
          child: IconButton(
            icon: Icon(Icons.add),
            color: theme.primaryColor,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => CustomBottomSheet(
                  child: AddTodoWidget(
                    onSave: (todo) => bloc..add(AddTodo(todo: todo)),
                  ),
                ),
              );
            },
            padding: EdgeInsets.all(11),
            iconSize: 30,
          ),
        );
    }
  }

  List<BottomNavBarItem> _items(BuildContext context) {
    final theme = Theme.of(context);

    List<BottomNavBarItem> _list = [];

    for (ScreenEnum screen in ScreenEnum.values) {
      _list.add(
        BottomNavBarItem(
          icon: _icons(screen, context),
          title: _titles(screen),
          activeColor: theme.colorScheme.primary,
          inactiveColor: theme.colorScheme.onBackground.withOpacity(0.4),
        ),
      );
    }
    return _list;
  }

  Widget _titles(ScreenEnum screen) {
    switch (screen) {
      case ScreenEnum.home:
        return Text(home.title.toUpperCase());
        break;

      case ScreenEnum.stats:
        return Text(stats.title.toUpperCase());
        break;
      default:
        return Text(add.title.toUpperCase());
    }
  }
}
