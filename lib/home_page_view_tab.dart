import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nested_scroll_view/nested_scroll_view_inner_scroll_position_key_widget.dart';
import 'package:nested_scroll_view/old_extended_nested_scroll_view.dart';

class HomePageViewTab extends StatefulWidget {
  String item;
  GlobalKey<MyNestedScrollViewState> nestedScrollViewStateKey;

  HomePageViewTab(this.item, {this.nestedScrollViewStateKey});

  @override
  _HomePageViewTabState createState() => _HomePageViewTabState();
}

class _HomePageViewTabState extends State<HomePageViewTab>
{
  GestureTapCallback onRetryTap;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
              ScrollConfiguration(
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: NestedScrollViewInnerScrollPositionKeyWidget(
                    Key(widget.item),
                    ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemBuilder: getItem,
                      itemCount: 60,
                    ),
                  ),
                ),
              )
        ],
      ),
    );
  }

  Widget getItem(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        Container(child: Text(widget.item)),
      ],
    );
  }
}


