import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/src/divider.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:provider/provider.dart';

import '../../../../../BusinessLogicModel/Listeners/Accounts/CompanyChangeListener/company_change_listener.dart';
import '../../../../../BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../Reuse_Widgets/Buttons/bottom_single_button.dart';
import '../../../../Reuse_Widgets/Default_Screens/default_screens.dart';
import '../../../../Reuse_Widgets/DropDowns/drop_down_header.dart';
import '../../../../Reuse_Widgets/circular_indicator_customized.dart';

class ChangeCompanyPage extends StatelessWidget {
  const ChangeCompanyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CompanyChangeListener>(
      create: (_) => CompanyChangeListener(),
      builder: (context, snapshot) {
        return GetPageStarterScaffold(
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
                const DividerVertical(2),
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
