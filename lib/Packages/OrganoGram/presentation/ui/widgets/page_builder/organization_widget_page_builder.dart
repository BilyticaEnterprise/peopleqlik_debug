import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organization_chart_handler_model.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organogram_model.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/repo/organogram_states.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/bloc/organization_current_page_widget_index_bloc.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/bloc/organization_swiper_handler_bloc.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/bloc/organogram_data_handler_bloc.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/ui/widgets/extraWidgets/empty_widget_view.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/ui/widgets/page_builder/widget/organogram_widget.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/ui/widgets/extraWidgets/skeleton_widget.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/utils/icon_view/get_icons.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class OrganizationChartWidgetPageBuilder extends StatelessWidget {
  final int listIndex;
  final Function() onUpTap;
  const OrganizationChartWidgetPageBuilder({required this.listIndex,required this.onUpTap,super.key});

  @override
  Widget build(BuildContext context) {
    if(listIndex == 0)
    {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetIcons(icon: SvgPicturesData.upArrow,onTap: onUpTap,),
          _PageBuilderWithAnim(
            listIndex: listIndex,
          ),
        ],
      );
    }
    else
    {
      return _PageBuilderWithAnim(
        listIndex: listIndex,
      );
    }
  }
}

class _PageBuilderWithAnim extends StatefulWidget {
  final int listIndex;
  const _PageBuilderWithAnim({required this.listIndex, super.key});

  @override
  State<_PageBuilderWithAnim> createState() => _PageBuilderWithAnimState();
}

class _PageBuilderWithAnimState extends State<_PageBuilderWithAnim> with TickerProviderStateMixin{

  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;
  late OrganizationChartBloc organizationChartBloc;


  @override
  void initState() {
    super.initState();

    animation = AnimationController(vsync: this, duration: const Duration(milliseconds: 800),);
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1.0).animate(animation);

    //animation.forward();

    // animation.addStatusListener((status){
    //   if(status == AnimationStatus.dismissed){
    //     animation.forward();
    //   }
    // });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animation.forward();
      Future.delayed(const Duration(milliseconds: 300),(){
        if(mounted)
        {
          //print('calllsadas');
          BlocProvider.of<OrganizationSwiperHandlerBloc>(context,listen: false).updateScrollingPermissionAt(widget.listIndex);
          BlocProvider.of<OrganizationChartBloc>(context,listen: false).updateScrollingAt(widget.listIndex);
        }
      });
    });
  }
  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    organizationChartBloc = BlocProvider.of<OrganizationChartBloc>(context,listen: false);
    List<OrganizationChartHandlerModel> data = organizationChartBloc.state;
    OrganizationSwiperHandlerBloc swiperHandlerBloc = BlocProvider.of<OrganizationSwiperHandlerBloc>(context,listen: false);

    return SizedBox(
      height: ScreenSize(context).heightOnly(16),
      child: FadeTransition(
          opacity: _fadeInFadeOut,
          child: BlocConsumer<OrganizationSwiperHandlerBloc,List<bool>?>(
              listener: (context, data){},
              builder: (context, isScrollingAllowed) {

                print('listIndexx ${widget.listIndex} ${swiperHandlerBloc.getScrollingPermissionAt(widget.listIndex)}');
                return Swiper(
                  controller: data[widget.listIndex].swiperController,
                  itemBuilder: (BuildContext context, int index) {
                    if(data[widget.listIndex].organizationChartData is OrganizationChartDataState)
                    {
                      OrganizationWidgetModel organizationWidgetModel = (data[widget.listIndex].organizationChartData as OrganizationChartDataState).data as OrganizationWidgetModel;
                      if(widget.listIndex == 0)
                      {
                        return OrganizationChartWidget(
                          data: organizationWidgetModel.currentUserData,
                          pageIndex: index,
                          listIndex: widget.listIndex,
                          onTap: (){
                            //organizationChartBloc.widgetTapped(widget.listIndex,index,dataState[index]);
                          },
                        );
                      }
                      else
                      {
                        return OrganizationChartWidget(
                          data: organizationWidgetModel.teamData?[index],
                          pageIndex: index,
                          listIndex: widget.listIndex,
                          onTap: (){
                            //organizationChartBloc.widgetTapped(widget.listIndex,index,dataState[index]);
                          },
                        );
                      }
                    }
                    else if(data[widget.listIndex].organizationChartData is OrganizationChartDummyState)
                    {
                      return const OrganizationChartSkeleton();
                    }
                    else if(data[widget.listIndex].organizationChartData is OrganizationChartEmptyState)
                    {
                      return const OrganizationChartEmptyView();
                    }
                    return Container(height: 0,color: Colors.black,);

                  },
                  itemCount: data[widget.listIndex].organizationChartData is OrganizationChartDummyState?((data[widget.listIndex].organizationChartData as OrganizationChartDummyState).data??3):
                  data[widget.listIndex].organizationChartData is OrganizationChartEmptyState?1:
                  widget.listIndex == 0?1:
                  ((data[widget.listIndex].organizationChartData as OrganizationChartDataState).data as OrganizationWidgetModel).teamData?.length ,

                  physics: swiperHandlerBloc.getScrollingPermissionAt(widget.listIndex) == true?null:const NeverScrollableScrollPhysics(),
                  viewportFraction: 0.26,
                  loop: false,
                  autoplay: false,
                  allowImplicitScrolling: false,
                  index: data[widget.listIndex].currentPageIndex,
                  onIndexChanged: (widgetIndex){
                    if(swiperHandlerBloc.getScrollingPermissionAt(widget.listIndex) == true)
                      {
                        BlocProvider.of<OrganizationCurrentWidgetIndex>(context,listen: false).updateCurrentFocusedIndexAt(widget.listIndex, widgetIndex);
                        if(data[widget.listIndex].organizationChartData is OrganizationChartDataState)
                          {
                            OrganizationWidgetModel organizationWidgetModel = (data[widget.listIndex].organizationChartData as OrganizationChartDataState).data as OrganizationWidgetModel;
                            organizationChartBloc.currentRotateVerticalHorizontalIndex(widget.listIndex, widgetIndex, organizationWidgetModel);
                          }
                      }
                  },
                  scale: 0.35,
                );
              }
          )

      ),
    );

  }
}
