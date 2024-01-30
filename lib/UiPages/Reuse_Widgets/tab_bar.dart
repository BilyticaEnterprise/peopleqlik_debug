import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';

class TabBarDesign extends StatefulWidget {
  TabController? tabController;
  PageController? pageController;
  List<TabHeaders?> tabHeadersData;
  TabBarDesign(this.tabController,this.pageController,this.tabHeadersData, {Key? key}) : super(key: key);

  @override
  _TabBarDesignState createState() => _TabBarDesignState();
}

class _TabBarDesignState extends State<TabBarDesign> {
  @override
  void initState() {
    // widget.updatedIndexFromPageView?.listen((event) {
    //   setState(() {
    //     widget.data[widget.tabController!.previousIndex]?.checked=false;
    //     widget.data[event]?.checked=true;
    //   });
    // });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget.tabController,
      unselectedLabelColor: const Color(MyColor.colorGrey4),
      labelColor: const Color(MyColor.colorBlack),
      labelStyle: GetFont.get(
        context,
        fontSize: 2.0,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GetFont.get(
        context,
        fontSize: 1.8,
        fontWeight: FontWeight.w400,
      ),
      labelPadding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly(2.2)),
      isScrollable: false,
      indicatorColor: const Color(MyColor.colorPrimary),
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: CircleTabIndicator(color: const Color(MyColor.colorPrimary), radius: ScreenSize(context).heightOnly( 0.5)),
      tabs: tabsText(widget.tabHeadersData),
      indicatorWeight: 2.0,
      onTap: (index){
        PrintLogs.printLogs('tap $index');
        widget.pageController?.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.linear);
        // setState(() {
        //   widget.data[widget.tabController!.previousIndex]?.checked=false;
        //   widget.data[index]?.checked=true;
        // });
      },

    );
  }
  List<Widget> tabsText(List<TabHeaders?> tabList)
  {
    List<Widget> list=List.empty(growable: true);
    for(int x=0;x<tabList.length;x++)
    {
      list.add(
          Container(
            padding: EdgeInsets.only(bottom: ScreenSize(context).heightOnly( tabList[x]!.checked==false?0.8:2.0)),
            child: Center(
              child:Text(tabList[x]!.name!),
            ),
          )
      );
    }
    return list;
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({@required Color? color, @required double? radius})
      : _painter = _CirclePainter(color!, radius!);

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
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size!.width/2,cfg.size!.height-radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

class TabHeaders
{
  String? name;
  bool? checked;
  HeadersEnum? headersEnum;
  TabHeaders(this.name,this.checked,this.headersEnum);
}
enum HeadersEnum
{
  timeOff,expense,loan
}