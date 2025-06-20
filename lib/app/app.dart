import 'package:discrete_project/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:discrete_project/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:discrete_project/ui/views/home/home_view.dart';
import 'package:discrete_project/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:discrete_project/ui/views/first_problem/first_problem_view.dart';
import 'package:discrete_project/ui/views/second_problem/second_problem_view.dart';
import 'package:discrete_project/ui/views/k_map/k_map_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: FirstProblemView),
    MaterialRoute(page: SecondProblemView),
    MaterialRoute(page: KMapView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
