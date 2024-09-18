import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organization_chart_handler_model.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organogram_model.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/repo/organogram_states.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/bloc/organization_current_page_widget_index_bloc.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/bloc/organization_swiper_handler_bloc.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/bloc/organogram_data_handler_bloc.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/bloc/controllerRepo/organization_bloc_controller.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/ui/widgets/name_text_views/textViews_builder.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/ui/widgets/page_builder/organization_widget_page_builder.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/presentation/ui/widgets/extraWidgets/bottom_separator_widget.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class OrganizationChartWidgetBuilder extends StatelessWidget {
  final OrganizationChartController organizationChartController;
  const OrganizationChartWidgetBuilder({required this.organizationChartController,super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedMultiBlocProvider(
        providers: [
          BlocProvider<OrganizationChartBloc>(
              create: (_) => OrganizationChartBloc(
                  [OrganizationChartHandlerModel(swiperController: SwiperController(), currentPageIndex: 0, currentPageKey: Key('value'), organizationChartData: OrganizationChartDummyState(data: 1))],
                  blocController: organizationChartController)
          ),
          BlocProvider<OrganizationSwiperHandlerBloc>(create: (_) => OrganizationSwiperHandlerBloc(null)),
          BlocProvider<OrganizationCurrentWidgetIndex>(create: (_) => OrganizationCurrentWidgetIndex([0]))
        ],
        builder: (context) => const _BodyWidget()
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    OrganizationChartBloc organizationChartBloc = BlocProvider.of<OrganizationChartBloc>(context,listen: false);
    organizationChartBloc.seContext(context);
    return BlocConsumer<OrganizationChartBloc,List<OrganizationChartHandlerModel>>(
        listener: (context, data){},
        builder: (context, data) {
          if(organizationChartBloc.uiCreated == false)
            {
              return Container(height: 0,);
            }
          return ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: ScreenSize(context).heightOnly(2),bottom: ScreenSize(context).heightOnly(6)),
              itemBuilder: (context, listIndex){
                return Column(
                  key: data[listIndex].currentPageKey,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OrganizationChartWidgetPageBuilder(
                      listIndex: listIndex,
                      onUpTap: (){
                        organizationChartBloc.onUpTap();
                      },
                    ),
                    NamesTextViewsBuilder(
                      listIndex: listIndex,
                    ),
                  ],
                );
              },
              separatorBuilder: (context, listIndex)
              {
                return ChartBottomSeparatorWidget(
                  length: (data[listIndex+1].organizationChartData is OrganizationChartDummyState)||(data[listIndex+1].organizationChartData is OrganizationChartEmptyState)?null:((data[listIndex+1].organizationChartData as OrganizationChartDataState).data as OrganizationWidgetModel).teamData?.length,
                );
              },
              itemCount: data.length
          );
        }
    );
  }
}

