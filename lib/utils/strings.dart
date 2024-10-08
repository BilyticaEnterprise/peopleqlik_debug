class GetVariable
{
  static const String emailRestriction = '[A-Za-z0-9\d.@_-]*';
  static const String events  = 'Events';
  static const String timeOff  = 'Time Off';
  static const String holidays  = 'Holidays';
  static const String employeeEvents  = 'Employee Events';
  static const int success = 200;
  static const int fourZeroOne = 401;
  static const int requestScreenId = 26;
  static const int leaveScreenId = 164;
  static const int noInternetValue = -1212;
  static const String tempToken = '1289gfv3';

  static const int missingIn = 1;
  static const int missingOut = 2;
  static const int lateness = 3;
  static const int earlyOut = 4;
  static const int absent = 5;
  static const int onTime = 6;
  static const int weekEnd = 7;
  static const int publicHoliday = 8;
  static const int officePermission = 9;
  static const int missingShift = 10;
  static const int breakIn = 11;
  static const int breakOut = 12;
  static const int personalWork = 13;

  static const String reLogin = 'Your token has been expired so you have to re login again';

  // static String enableLocation = 'Enable your Location';
  // static String enableLocationHeader = 'You have turned off your GPS please enable it to use this feature and also provide us your location permission.';
  // static String locationPermissionDenied = 'Location Permission Denied!!';
  // static String locationPermissionRequired = "This app must require your current location to mark your attendance according to your Location and Distance. To allow permission please click on GIVE PERMISSION button.";
  // static String deniedStorage = 'External Storage permission Denied!!!';
  // static String deniedStorageHeader = 'You have declined External Storage permission please provide us this permission so that we can save downloaded documents in your phone documents folder.';
  // static String enableStorage = 'External Storage permission Required';
  // static String enableStorageHeader = 'We need your external storage permission so that we can save downloaded documents in your phone documents folder.';
  // static String headerNotAvailable='Not available';
  // static String descriptionNotAvailable='The requested information is not available right now';
  // static String headerTimeOffNotAvailable='No leaves available';
  // static String descriptionTimeOffNotAvailable='Looks like no leaves request are submitted yet. You better should try again later';
  // static String headerEmployeesByDateTypeNotAvailable='No Employees available';
  // static String descriptionEmployeesByDateTypeNotAvailable='Looks like no employees are available to show.';
  // static String headerErrorNotAvailable='Something went wrong';
  // static String descriptionErrorNotAvailable='We are really sorry for this. Please try again later';
  // static String headerLoanNotAvailable='No Loans available';
  // static String descriptionLoanNotAvailable='Looks like no loans request are available to view. You better should try again later';
  // static String headerSummaryNotAvailable='No Summary available';
  // static String descriptionSummaryNotAvailable='Looks like no summary is available to view against selected year. Try to select other years code';
  // static String headerExpenseNotAvailable='No Expense available';
  // static String descriptionExpenseNotAvailable='Looks like no expense data is available to view right now. You better should try again later';
  // static String headerNotificationNotAvailable='No notifications are available';
  // static String descriptionNotificationNotAvailable='No notifications are available to show right now.';
  // static String headerTimeOffLeavesNotAvailable='No leaves available';
  // static String descriptionTimeOffLeavesNotAvailable='No leaves are available to show right now for pending, approve or other statuses.';
  // static String noInternetHeader = 'No internet!!!';
  // static String noInternet = 'Looks like you don\'t have an internet connection available. Please make sure you have an active internet connection available.';
  // static String headerRequestListNotAvailable='No Request List available';
  // static String descriptionRequestListNotAvailable='No Requests are available right now try to add some';
  // static String headerApprovalsNotAvailable = 'No Approvals are available';
  // static String descriptionApprovalsListNotAvailable = 'No Approval list is currently available to display';
  // static String headerAnnouncementNotAvailable = 'No announcements are available';
  // static String descriptionAnnouncementNotAvailable = 'Announcements are special occasions you will be notified once there is any announcement available for you.';

  // static String awaiting = 'Awaiting';
  // static String approved = 'Approved';
  // static String declined = 'Declined';
  // static String paySlips = 'Pay Slips';
  // static String paySlipText = 'Click here to check all you monthly earnings allowances.';
  // static String requests = 'Requests';
  // static String requestText = 'Click here to view all your Requests like Expense, Loans, Payroll, Shifts Hiring request and much more.';
  // static String approvals = 'Approvals';
  // static String approvalsText = 'This section is all about pending approvals. To approve or view any pending request please click here';
  // static String approvalReasonIssue = 'You must have to select Leave status';
  // static String approvalDateIssue = 'You must have to select date option';
  //static String fullDay = 'Full Day';
  //static String optionalString = 'Select an option';
  static String companyCode = 'CompanyCode';
  static String employeeCode = 'EmployeeCode';
  static String requestCode = 'RequestCode';
  static int isDate = 1;
  static int isTime = 2;

  static var errorValue = 'We are really sorry for this. Please try again later';

  static var testPic = 'https://media.licdn.com/dms/image/D4D03AQGyA8TuAL95XQ/profile-displayphoto-shrink_200_200/0/1692188087664?e=2147483647&v=beta&t=SxB69LHW1iLUQf8de0O8KyhuSreeraA5cawy2Qsz4Ug';
  //static String PDL = 'PDL';
  static var htmlcode = """
  <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sample Blog Post</title>
</head>
<body>
    <h1>Welcome to My Blog</h1>
    <p>Welcome to my blog! This is a sample blog post to demonstrate how HTML content can be rendered in a Flutter app using the flutter_html widget.</p>
    
    <h2>Getting Started</h2>
    <p>To get started with Flutter and the flutter_html package, you'll need to add the package to your pubspec.yaml file:</p>
    <pre><code>dependencies:
  flutter:
    sdk: flutter
  flutter_html: ^2.1.1</code></pre>
    <p>Once you have added the package, you can use the <code>Html</code> widget to render HTML content. Here's an example:</p>
    <pre><code>Html(
  data: 
  &lt;h1&gt;Hello, Flutter!&lt;/h1&gt;
  &lt;p&gt;This is a paragraph.&lt;/p&gt;
  ,
)</code></pre>
    
    <h2>Features</h2>
    <p>The flutter_html package supports various HTML tags, including:</p>
    <ul>
        <li><strong>Headings:</strong> &lt;h1&gt;, &lt;h2&gt;, &lt;h3&gt;, etc.</li>
        <li><strong>Paragraphs:</strong> &lt;p&gt;</li>
        <li><strong>Links:</strong> &lt;a href="..."&gt;</li>
        <li><strong>Lists:</strong> &lt;ul&gt;, &lt;ol&gt;</li>
        <li><strong>Images:</strong> &lt;img&gt;</li>
    </ul>
    <p>For more information, check out the <a href="https://pub.dev/packages/flutter_html">flutter_html package documentation</a>.</p>
</body>
</html>

  """;
}