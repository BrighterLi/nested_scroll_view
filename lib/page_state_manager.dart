
import 'package:flutter/widgets.dart';

class PageStateManager extends StatefulWidget {
  Widget content;
  LoadState pageLoadState = LoadState.State_Loading;
  int errorCode = 0;
  String errorMsg = "";
  String emptyInfo = "数据为空";
  GestureTapCallback onRetryTap;
  double widgetHeight;

  PageStateManager(this.content, this.pageLoadState,
      {Key key, this.errorCode, this.errorMsg, this.onRetryTap, this.widgetHeight})
      : super(key: key);

  @override
  PageStateManagerState createState() => PageStateManagerState();
}

enum LoadState { State_Success, State_Error, State_Loading, State_Empty }

class PageStateManagerState extends State<PageStateManager> {
  PageStateManagerState();

  @override
  Widget build(BuildContext context) {
    switch (widget.pageLoadState) {
      case LoadState.State_Success:
        return widget.content;
      case LoadState.State_Error:
        return Container(height: widget.widgetHeight, child: getErrorWidget(widget.errorCode, widget.onRetryTap));
      case LoadState.State_Loading:
        //return Container(height: widget.widgetHeight, child: FQLLoadingWidget());
      case LoadState.State_Empty:
        //return Container(height: widget.widgetHeight, child: FQLEmptyWidget(widget.emptyInfo));
      default:
        return widget.content;
    }
  }

  Widget getErrorWidget(int errorCode, GestureTapCallback _onRetryTap) {
    switch (errorCode) {
      case ErrorCode.LOCAL_ERROR:
      case ErrorCode.TIME_OUT:
      case ErrorCode.IOS_TIME_OUT:
        //return FQLErrorWidget("网络响应超时", "[" + errorCode.toString() + "]" + "请检查网络设置或刷新重试", _onRetryTap);
      default:
        //return FQLErrorWidget("数据加载失败", "[" + errorCode.toString() + "]" + "请检查网络设置或刷新重试", _onRetryTap);
    }
  }
}


class ErrorCode {
  static const int JSON_ERROR = 90062303;  //json解析错误
  static const int UNKNOWN_ERROR = 99020000;

  /// Android中需要特殊处理的错误码
  static const int TIME_OUT = 1006;
  static const int LOCAL_ERROR = 1007;

  /// iOS中需要特殊处理的错误码
  static const int IOS_TIME_OUT = 92010001;
}