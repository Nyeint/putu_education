import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:putu_education/app/config/widget_extensions.dart';
import '../../app/typedef_factory.dart';
import '../../app/widgets/err_state_widget/unknown_err_widget.dart';
import '../../app/widgets/err_widget.dart';
import '../../app/widgets/loading_widgets.dart';
import '../../app/widgets/more_widget.dart';
import '../../network/dio_basenetwork.dart';
import '../model/response_ob.dart';
import '../single_ui_builder/single_ui_builder.dart';
import 'refresh_ui_bloc.dart';

typedef Widget ChildWidget<T extends Object>(T data,RefreshLoad func, bool? isList);

typedef Widget AddOnWidget<T extends Object>(T data);

typedef Widget CustomMoreWidget(Map<String, dynamic> data);

class RefreshUiBuilder<T extends Object, P extends Object?> extends StatefulWidget {
  /// request link ရေးရန်
  P? param;
  Axis? direction;
  String? url;

  /// request body ရေးရန်
  Map<String, dynamic>? map;

  /// listview  နဲ့ ဖော်ပြမယ်ဆိုရင် true, gridview နဲ့ ဖော်ပြမယ်ဆိုရင် false
  bool? isList;

  /// Listview ကို Sliver အနေနဲ့ သုံးချင််ရင် true
  bool isSliver;

  /// RequestType က Get ဒါမှမဟုတ် Post
  ReqType requestType;

  /// HeaderType က ယခု apex project အတွက် သီးသန့်ဖြစ်ပြီး customer, normal,agent ; default က normal

  /// ကိုယ်တိုင် loading widget ရေးချင်တဲ့အချိန်မှာ ထည့်ပေးရန် ; default က widget folder အောက်က LoadingWidget
  Widget? loadingWidget;

  /// girdView အသုံးပြုတဲ့အခါ ဖော်ပြမယ့် gridCount
  int gridCount;

  /// gridChildRatio က gridview ရဲ့ child တွေ size သတ်မှတ်ဖို့ အသုံးပြုပါတယ်
  double gridChildRatio;

  /// successResponse ကို စစ်ရန်
  SuccessCallback? successCallback;

  /// customMoreResponse
  CustomMoreCallback? customMoreCallback;

  /// errorMoreResponse
  CustomErrorCallback? customErrorCallback;

  /// listview or gridview အတွက် children widget ရေးရန်

  ChildWidget<T>? childWidget;
  AddOnWidget<T>? addOnWidget;

  Widget? scrollHeaderWidget;

  CustomMoreWidget? customMoreWidget;

  /// စာမျက်အစမှာ data ရယူချင်ရင် true, မယူချင်ရင် false,  default က true
  bool isFirstLoad;

  /// child widget ကို နှိပ်ရင် အလုပ်လုပ်မယ့် method
  // Function onChildPress;

  bool enablePullUp = false;

  ScrollController? scrollController;


  // Is Cached or not
  bool? isCached;

  //No Data Custom Widget
  Widget? noDataWidget;



  bool isNotShowSnack = false;

  RefreshUiBuilder.init(
      {
        this.param,
        required this.url,
        Key? key,
        this.direction=Axis.vertical,
        this.scrollController,
        this.childWidget,
        this.addOnWidget,
        this.isFirstLoad = true,
        this.map,
        this.scrollHeaderWidget,
        this.isList = true,
        this.requestType = ReqType.Get,
        this.loadingWidget,
        this.gridCount = 2,
        this.successCallback,
        this.customMoreCallback,
        this.customErrorCallback,
        this.gridChildRatio = 100 / 130,
        // this.onChildPress,
        this.customMoreWidget,
        this.enablePullUp = false,
        this.isCached = false,
        this.isNotShowSnack = false,
        this.noDataWidget,
        this.isSliver = false})
      : super(key: key);

  RefreshUiBuilder(
      {
        this.param,
        required this.url,
        Key? key,
        this.scrollController,
        this.childWidget,
        this.addOnWidget,
        this.isFirstLoad = true,
        this.map,
        this.scrollHeaderWidget,
        this.isList = true,
        this.requestType = ReqType.Get,
        this.loadingWidget,
        this.gridCount = 2,
        this.successCallback,
        this.customMoreCallback,
        this.customErrorCallback,
        this.gridChildRatio = 100 / 130,
        // this.onChildPress,
        this.customMoreWidget,
        this.enablePullUp = false,
        this.isCached = false,
        this.noDataWidget,
        this.isNotShowSnack = false,
        this.isSliver = false,
        this.direction = Axis.vertical,
       })
      : super(key: key);

  @override
  RefreshUiBuilderState<T,P> createState() {
    return RefreshUiBuilderState<T,P>();
  }
}

class RefreshUiBuilderState<T,P> extends State<RefreshUiBuilder> with AutomaticKeepAliveClientMixin{
  late RefreshUiBloc<T,P?> bloc;
  List<T> ois = [];
  P? addOnData;

  // Map<String,dynamic> map;
  late RefreshController _rController;

  @override
  void initState() {
    super.initState();
    bloc = RefreshUiBloc<T,P?>();
    _rController = RefreshController();

    if (widget.isFirstLoad) {
      bloc.getData(widget.url!,
          map: widget.map,
          requestType: widget.requestType,
          isCached: widget.isCached);
    }

    bloc.streamData().listen((rv) {
      if (rv.pgState != null) {
        if (rv.pgState == PageState.first) {
          _rController.refreshCompleted();
          _rController.resetNoData();
          _rController.loadComplete();
        } else {
          if (rv.message == MsgState.data) {
            if (rv.pgState == PageState.no_more) {
              _rController.loadNoData();
            } else {
              _rController.loadComplete();
            }
          }
        }
      }
      if (rv.message == MsgState.data) {
        if (widget.successCallback != null) {
          widget.successCallback!(rv);
        }
      }
      if (rv.message == MsgState.error) {
        if (widget.customErrorCallback != null) {
          widget.customErrorCallback!(rv);
        }
      }
      if (rv.message == MsgState.more) {
        if (widget.isNotShowSnack) {
        } else {
          if (widget.customMoreCallback != null) {
            Map<String, dynamic> map = rv.data;

            // AppUtils.showNormal(
            //   map['message'].toString(),
            //   textColor: Colors.white,
            // );

          }
        }
      }
    });
  }

  final pullUpSty = TextStyle(fontSize: 15, color: Colors.grey.shade400);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    return shopWidget(size);
  }

  func(
      {Map<String, dynamic>? map,
        ReqType? requestType = ReqType.Get,

        String? newUrl,
        bool? refreshShowLoading = true}) {
    widget.map = map;
    if (widget.isFirstLoad == false) {
      setState(() {
        widget.isFirstLoad = true;
      });
    }

    bloc.getData(newUrl == null ? widget.url! : newUrl,
        map: map,
        requestType: requestType,

        requestShowLoading: refreshShowLoading!,
        isCached: widget.isCached);
  }

  Widget shopWidget(Size size) {
    return Column(
      children: [
        !widget.isFirstLoad
            ? Container()
            : Expanded(
          child: StreamBuilder<ResponseOb>(
              stream: bloc.streamData(),
              initialData: ResponseOb(data: null, message: MsgState.loading),
              builder: (context, AsyncSnapshot<ResponseOb> snap) {
                ResponseOb rv = snap.data!;
                if (rv.message == MsgState.loading) {
                  return widget.loadingWidget != null
                      ? widget.loadingWidget!
                      : Center(
                    child: LoadingWidget(),
                  );
                } else if (rv.message == MsgState.data) {
                  if (rv.pgState == PageState.first) {
                    print("this is first ${rv.data} and then ${rv.result}");
                    ois = rv.data;
                    addOnData = rv.result;
                  }
                  else {
                    print('this is not first ${rv.data} and ois is $ois');
                    ois.addAll(rv.data);
                    addOnData = rv.result;
                  }
                  return
                    Column(
                      children: [
                        if(addOnData != null && widget.addOnWidget != null)
                        widget.addOnWidget!(addOnData!).pad(bottom: 20),
                        Expanded(
                          child: SmartRefresher(
                            // reverse: true,
                              physics: BouncingScrollPhysics(),
                              scrollController: widget.scrollController,
                              primary: widget.scrollController == null ? true : false,
                              controller: _rController,
                              footer: CustomFooter(
                                builder: (context, loadStatus) {
                                  if (loadStatus == LoadStatus.loading) {
                                    return LoadingWidget(size: 30);
                                  } else if (loadStatus == LoadStatus.failed) {
                                    return Center(child: Text("Load fail!", style: pullUpSty));
                                  } else if (loadStatus == LoadStatus.canLoading) {
                                    return Center(
                                        child: Text('Release to load more', style: pullUpSty));
                                  } else if (loadStatus == LoadStatus.idle) {
                                    return Center(child: Text('Pull up to load', style: pullUpSty));
                                  } else {
                                    return Center(child: Text('No more data', style: pullUpSty));
                                  }
                                },
                              ),
                              enablePullDown: widget.direction == Axis.horizontal ? false:true,
                              enablePullUp:
                              widget.enablePullUp ? widget.enablePullUp : ois.length > 9,
                              // enablePullUp: true,
                              onRefresh: () {
                                bloc.getData(widget.url!,
                                    map: widget.map,
                                    requestType: widget.requestType,
                                    isCached: widget.isCached);
                              },
                              onLoading: () {
                                bloc.getLoad(widget.url, widget.map,
                                    requestType: widget.requestType);
                              },
                              child: ois.isEmpty
                                  ? widget.noDataWidget == null
                                  ? ListView(
                                children: <Widget>[
                                  SizedBox(
                                    height: size.height * 0.20,
                                  ),
                                  Container(
                                    child: Image.asset('assets/images/empty_message.png'),
                                    width: 90,
                                    height: 90,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    tr("no_data"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                                  : Center(child: widget.noDataWidget)
                                  : widget.scrollHeaderWidget == null
                                  ? widget.isSliver
                                  ? sliverWidget(ois)
                                  : mainList(ois)
                                  : SingleChildScrollView(
                                child:
                                Column(
                                  children: [widget.scrollHeaderWidget!, mainList(ois)],
                                ),
                              )
                            // mainList(ois)
                          ),
                        )
                      ],
                    );
                } else if (rv.message == MsgState.error) {
                  return SingleChildScrollView(
                    child: ErrWidget(rv.errState, () {
                      bloc.getData(widget.url!,
                        map: widget.map,
                        requestType: widget.requestType,
                      );
                    },),
                  );
                } else if (rv.message == MsgState.more) {
                  return widget.customMoreWidget == null
                      ? MoreWidget(rv.data)
                      : widget.customMoreWidget!(rv.data);
                } else {
                  return UnknownErrWidget(
                    fun: () {
                      bloc.getData(widget.url!,
                        map: widget.map,
                        requestType: widget.requestType,
                      );
                    },
                  );
                }
              }),
        ),
      ],
    );
  }

  Widget mainList(List<T>? ois) {
    print("OIS  is list IS ${widget.isList}");
    return widget.isList!
        ? ListView.builder(
      scrollDirection: widget.direction == Axis.horizontal ? Axis.horizontal : Axis.vertical,
      shrinkWrap: widget.scrollHeaderWidget != null ? true : false,
      physics: widget.scrollHeaderWidget != null ? ClampingScrollPhysics() : null,
      itemBuilder: (context, index) {
        T data = ois![index];
        return widget.childWidget!(data!, func, widget.isList);
      },
      itemCount: ois!.length,
    )
        : GridView.builder(
      shrinkWrap: widget.scrollHeaderWidget != null ? true : false,
      physics: widget.scrollHeaderWidget != null ? ClampingScrollPhysics() : null,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.gridCount, childAspectRatio: widget.gridChildRatio),
      itemBuilder: (context, index) {
        return widget.childWidget!(ois![index]!, func, widget.isList);
      },
      itemCount: ois!.length,
    );
  }

  Widget sliverWidget(List<T>? ois) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              T data = ois![index];
              return widget.childWidget!(data!, func, widget.isList);
            },
            childCount: ois!.length,
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
