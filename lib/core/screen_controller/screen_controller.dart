import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bottom_nav/bloc/bottom_nav_bloc.dart';
import 'screen_enum.dart';
import 'widgets/bottom_nav_bar_container.dart';
import 'widgets/screen_body.dart';

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        final screen = state.widget.screen;
        final title = state.widget.title;
        final child = state.widget.widget;

        final selectedIndex = ScreenEnum.values.indexOf(screen);

        final theme = Theme.of(context);

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Container(
            color: theme.colorScheme.secondary,
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: theme.scaffoldBackgroundColor,
              body: _buildBody(child),
              appBar: _buildAppBar(context, title),
              bottomNavigationBar: _buildBottomNavBar(selectedIndex),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(Widget child) => ScreenBody(child: child);

  Widget _buildBottomNavBar(int selectedIndex) {
    return BottomNavBarContainer(selectedIndex: selectedIndex);
  }

  Widget _buildAppBar(BuildContext context, String title) {
    return AppBar(title: Text(title));
  }
}
