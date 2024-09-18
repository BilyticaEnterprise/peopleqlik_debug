import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/repo/organogram_states.dart';

class OrganizationChartHandlerModel
{
  SwiperController swiperController;
  int currentPageIndex;
  Key currentPageKey;
  bool allowScrolling;
  OrganizationChartState organizationChartData;

  OrganizationChartHandlerModel(
      {
        required this.swiperController,
        required this.currentPageIndex,
        required this.currentPageKey,
        this.allowScrolling = false,
        required this.organizationChartData,
      });
}