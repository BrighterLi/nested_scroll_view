import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nested_scroll_view/divider.dart';
import 'package:nested_scroll_view/home_page_view_tab.dart';
import 'package:nested_scroll_view/my_tabs.dart';
import 'package:nested_scroll_view/old_extended_nested_scroll_view.dart';

class HomePageView extends StatefulWidget {
  List itemList;
  TabController _tabController;
  GlobalKey<MyNestedScrollViewState> nestedScrollViewStateKey;

  HomePageView(this.itemList, this._tabController, {this.nestedScrollViewStateKey});

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with TickerProviderStateMixin {
  bool isScrollable = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemList == null) {
      return Container();
    }

    List itemList = widget.itemList;
    isScrollable = itemList.length > 7;

    return Column(
      children: <Widget>[
        _tabBar(),
        getFqlDivider(context),
        Expanded(
          flex: 1,
          child: _tabBarView(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _tabBar() {
    return FQLTabBar(
        //设置tab是否可水平滑动
        isScrollable: isScrollable,
        //控制器
        controller: widget._tabController,
        //设置tab选中得颜色
        labelColor: Color(0xFF050C1C),
        //设置tab未选中得颜色
        unselectedLabelColor: Color(0xFFABADB2),
        indicatorColor: Color(0xFF407AFF),
        indicatorSize: FQTabBarIndicatorSize.label,
        indicatorWeight: 3,
        labelPadding: EdgeInsets.fromLTRB(
            isScrollable ? 15 : 5, 5, isScrollable ? 15 : 5, 5),
        unselectedLabelStyle: TextStyle(
            color: Color(0xFFABADB2),
            fontSize: 15,
            fontWeight: FontWeight.w300),
        labelStyle: TextStyle(
            color: Color(0xFF050C1C),
            fontSize: 20,
            fontWeight: FontWeight.w300),
        tabs: widget.itemList.map((item) {
          return FQLTab(text: item);
        }).toList());
  }

  Widget _tabBarView() {
    return FQLTabBarView(
//      physics:BouncingScrollPhysics(),
      controller: widget._tabController,
      children: widget.itemList.map((item) {
        return Container(
          child: HomePageViewTab(
            item,
            nestedScrollViewStateKey: widget.nestedScrollViewStateKey,
          ),
        );
       /*return Column(
         children: <Widget>[
           //Container(child: Text(item),),
         ],
       );*/
      }).toList(),
    );
  }

}
