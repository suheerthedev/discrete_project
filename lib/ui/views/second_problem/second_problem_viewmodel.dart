import 'package:discrete_project/app/app.locator.dart';
import 'package:discrete_project/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SecondProblemViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  // 3 variables: a, b, c. 8 possible combinations.
  final List<bool> _truthTable = List.filled(8, false);

  List<bool> get truthTable => _truthTable;

  void toggleOutput(int index) {
    _truthTable[index] = !_truthTable[index];
    notifyListeners();
  }

  List<String> get selectedCombinations {
    List<String> result = [];
    for (int i = 0; i < 8; i++) {
      if (_truthTable[i]) {
        final a = (i >> 2) & 1;
        final b = (i >> 1) & 1;
        final c = i & 1;
        result.add(
            'a: ${a == 1 ? "Yes" : "No"}, b: ${b == 1 ? "Yes" : "No"}, c: ${c == 1 ? "Yes" : "No"}');
      }
    }
    return result;
  }

  // Placeholder for K-map generation
  void generateKMap() {
    _navigationService.navigateToKMapView(truthTable: truthTable);
  }
}
