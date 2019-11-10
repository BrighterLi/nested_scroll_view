import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nested_scroll_view/home_page_view.dart';
import 'package:nested_scroll_view/old_extended_nested_scroll_view.dart';
import 'package:nested_scroll_view/page_state_manager.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {};
  runZoned(
    () => runApp(HomePage()),
    onError: (Object obj, StackTrace stack) {},
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return HomePageReal();
  }
}

class HomePageReal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageRealState();
  }
}

class _HomePageRealState extends State<HomePageReal>
    with TickerProviderStateMixin {
  GlobalKey<MyNestedScrollViewState> _nestedScrollViewStateKey =
      GlobalKey<MyNestedScrollViewState>();
  ScrollController _outScrollController = new ScrollController();
  TabController _tabController;

  LoadState _loadState = LoadState.State_Loading;
  int errorCode;
  String errorMsg;
  GestureTapCallback onRetryTap;
  bool showHeader = true;
  bool headerTransparent = true;
  double lastScrollPixels;
  double commonHeaderMaxHeight = 0;
  double commonHeaderMinHeight = 0;
  List itemList = ['推荐', '手机', '数码','运动', '手表','旅游'];
  double _scrollPixels = 0;

  @override
  void initState() {
    super.initState();

    onRetryTap = () {
      setState(() {
        _loadState = LoadState.State_Loading;
      });
    };

    _outScrollController.addListener(() {
      /*bool lastShowHeader = showHeader;
      bool lastHeaderTransparent = headerTransparent;
      if (lastScrollPixels == null ||
          (lastScrollPixels > _outScrollController.position.pixels)) {
        //向下滑动 滑动到头部最大高度头部展开等于0时候设置背景为透明
        headerTransparent = _outScrollController.position.pixels <= 0;
        showHeader = (_outScrollController.position.maxScrollExtent -
                _outScrollController.position.pixels) >
            (commonHeaderMaxHeight - commonHeaderMinHeight);
      } else {
        //向上滑动 头部不透明   20像素后收起头部
        headerTransparent = false;
        showHeader = _outScrollController.position.pixels < 20;
      }

      if (showHeader != lastShowHeader ||
          headerTransparent != lastHeaderTransparent) {
        // LxBridge.setCommonHeaderState(showHeader, headerTransparent);
      }

      lastScrollPixels = _outScrollController.position.pixels;*/
      _scrollPixels = _outScrollController.position.pixels;

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'nestedscrollview',
      home: Scaffold(
        appBar: AppBar(
          title: Text('nestedscrollview'),
        ),
        body: PageStateManager(
          getContentWidget(),
          _loadState,
          errorCode: errorCode,
          errorMsg: errorMsg,
          onRetryTap: onRetryTap,
        ),
      ),
    );
  }

  Widget getContentWidget() {
    initTabController();
    return Container(
      color: Color(0xFFFFFFFF),
      child: ScrollConfiguration(
        child: MyNestedScrollView(
            key: _nestedScrollViewStateKey,
            controller: _outScrollController,
            pinnedHeaderSliverHeightBuilder: () {
              //防止出现衔接不上问题
              return commonHeaderMinHeight > 1
                  ? (commonHeaderMinHeight - 1)
                  : commonHeaderMinHeight;
            },
            headerSliverBuilder: (context, innerScrolled) => <Widget>[
                  MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: SliverList(
                          delegate: SliverChildBuilderDelegate(getItem,
                              childCount: 10)))
                ],
            innerScrollPositionKeyBuilder: () {
              return Key(itemList[_tabController.index]);
            },
            body: HomePageView(
              itemList,
              _tabController,
              nestedScrollViewStateKey: _nestedScrollViewStateKey,
            )

        ),
      ),
    );
  }

  void initTabController() {
    int length = 6;
    int index = 0;

    _tabController = TabController(
      initialIndex: index,
      length: length,
      vsync: this,
    );
    _tabController.addListener(() {
    });
  }

  Widget getItem(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        Container(child: _scrollPixels < 10 ? Text("$_scrollPixels- 111") : Text("$_scrollPixels-  222")),
      ],
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _outScrollController?.dispose();
    super.dispose();
  }
}


