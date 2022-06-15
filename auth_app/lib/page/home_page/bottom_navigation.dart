import 'package:auth_app/page/home_page/home_page.dart';
import 'package:auth_app/page/home_page/settings_page.dart';
import 'package:auth_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  late TabController _tabController;

  static final List<Widget> _widgetOptions = <Widget>[Home(), Settings()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.colors.white,
          borderRadius: BorderRadius.circular(2.h),
        ),
        height: 8.h,
        margin: EdgeInsets.fromLTRB(2.w, 0, 2.w, 1.h),
        child: TabBar(
            controller: _tabController,
            unselectedLabelColor: AppTheme.colors.darkGray.withOpacity(0.25),
            labelColor: AppTheme.colors.orange,
            onTap: (index) => _onItemTapped(index),
            indicator: CircleTabIndicator(
                color: AppTheme.colors.orange, radius: 0.5.h),
            tabs: [
              Tab(
                  icon: Icon(
                Icons.insert_photo_outlined,
                size: 3.5.h,
              )),
              Tab(
                  icon: Icon(
                Icons.settings_outlined,
                size: 3.5.h,
              ))
            ]),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Offset circleOffset = offset +
        Offset(configuration.size!.width / 2,
            radius - configuration.size!.height / 20);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
