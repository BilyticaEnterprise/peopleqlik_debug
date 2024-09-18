import 'dart:async';
import 'dart:convert';

import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/models/PaysSlipApprovalsRequest/get_payslip_month.dart';
import 'package:provider/provider.dart';

import '../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
import '../../../Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import '../EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';


class PayslipMonthModelListener extends GetChangeNotifier
{
  ApiStatus apiStatus = ApiStatus.nothing;
  List<GetPaySlipResultSet>? getPaySlipResultSet;
  double? actualSalary = 0.0;
  double? earningSalary = 0.0;
  double? deductionsSalary = 0.0;
  double? total = 0.0;

  double? earnings = 0.0,deduction = 0.0,allowance = 0.0,accountable = 0.0,reimbursement = 0.0;

  Future? start(BuildContext context,String period)
    async {

      apiStatus = ApiStatus.started;
      notifyListeners();

      EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

      ApiResponse apiResponse = await UseCaseGetApisUrlCaller().getPaySlipByMonthApi(context, '?CompanyCode=${employeeInfoMapper.companyCode}&EmployeeCode=${employeeInfoMapper.employeeCode}&PeriodCode=$period');
      // GetPayslipMonthData? getPayslipListData = await GetPayslipMonthApiCall().callApi(context,period);
      if(apiResponse.apiStatus == ApiStatus.done)
      {
        getPaySlipResultSet = apiResponse.data!.resultSet;
        apiStatus = ApiStatus.done;
        calculateSalary();
        notifyListeners();

      }
      else if(apiResponse.apiStatus == ApiStatus.done)
      {
        apiStatus = ApiStatus.empty;
        notifyListeners();
      }
      else
      {
        apiStatus = apiResponse.apiStatus!;
        notifyListeners();
        ShowErrorMessage.show(apiResponse);
      }

    }
    void calculateSalary()
    {
      if(getPaySlipResultSet!.isNotEmpty)
        {
          for(int x=0;x<getPaySlipResultSet!.length;x++)
          {
            if(getPaySlipResultSet?[x].elementTypeID == 1)
              {
                earnings = earnings! + double.parse(getPaySlipResultSet![x].amount.toString());
              }
            if(getPaySlipResultSet?[x].elementTypeID == 2)
            {
              deduction = deduction! + double.parse(getPaySlipResultSet![x].amount.toString());
            }
            if(getPaySlipResultSet?[x].elementTypeID == 3)
            {
              allowance = allowance! + double.parse(getPaySlipResultSet![x].amount.toString());
            }
            if(getPaySlipResultSet?[x].elementTypeID == 4)
            {
              accountable = accountable! + double.parse(getPaySlipResultSet![x].amount.toString());
            }
            if(getPaySlipResultSet?[x].elementTypeID == 5)
            {
              reimbursement = reimbursement! + double.parse(getPaySlipResultSet![x].amount.toString());
            }
          }

          earningSalary = earnings;
          deductionsSalary = deduction;
          total = (earnings! + allowance! + reimbursement!) - deduction!;
        }
    }

}

