import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/buttons/bottom_single_button.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/utils/dropDowns/drop_down_header.dart';
import '../../../../../../../../utils/screenLoader/circular_indicator_customized.dart';
import '../../listeners/company_change_listener.dart';

class ChangeCompanyPage extends StatelessWidget {
  const ChangeCompanyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CompanyChangeListener>(
      create: (_) => CompanyChangeListener(),
      builder: (context, snapshot) {
        return GetPageStarterScaffoldStateLess(
          title: '${CallLanguageKeyWords.get(context, LanguageCodes.changeCompanyHeader)}',
          body: BodyData(),
          bottomNavigationBar: BottomSingleButton(text: '${CallLanguageKeyWords.get(context, LanguageCodes.requestsaddFormButton)}',onPressed: (){Provider.of<CompanyChangeListener>(context,listen: false).confirmPressed(context);},),
        );
      }
    );
  }
}
class BodyData extends StatefulWidget {
  const BodyData({Key? key}) : super(key: key);

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CompanyChangeListener>(context,listen: false).start(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyChangeListener>(
      builder: (context, data, child) {
        if(data.apiStatus == ApiStatus.done)
          {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const DividerByHeight(2),
                HeaderDropDownField(dropDownDataType: data.companyDropDown!, header:'${CallLanguageKeyWords.get(context, LanguageCodes.companyCompanyName)}', key: const Key('2'),selectedIndex: Provider.of<GlobalSelectedEmployeeController>(context,listen: false).companyData?.index, isCompulsory: true, onSelectedDropDown: data.dropDownCallBack,isEnabled: true),
                Expanded(child: Container()),
              ],
            );
          }
        else
          {
            return const CircularIndicatorCustomized();
          }
      }
    );
  }
}
