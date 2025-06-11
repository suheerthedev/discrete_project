import 'package:stacked/stacked.dart';

class FirstProblemViewModel extends BaseViewModel {
  // 3x3 matrix: matrix[i][j] == 1 if user i follows user j
  List<List<int>> _matrix = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0],
  ];
  bool _isLoading = false;
  List<List<int>>? _closure;
  List<String>? _suggestions;

  List<List<int>> get matrix => _matrix;
  bool get isLoading => _isLoading;
  List<List<int>>? get closure => _closure;
  List<String>? get suggestions => _suggestions;

  void toggleFollow(int from, int to) {
    if (from == to) return;
    _matrix[from][to] = _matrix[from][to] == 1 ? 0 : 1;
    notifyListeners();
  }

  Future<void> computeTransitiveClosure() async {
    _isLoading = true;
    _closure = null;
    _suggestions = null;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    // Warshall's algorithm
    List<List<int>> closure = [
      for (var row in _matrix) [...row]
    ];
    for (int k = 0; k < 3; k++) {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (closure[i][j] == 1 ||
              (closure[i][k] == 1 && closure[k][j] == 1)) {
            closure[i][j] = 1;
          }
        }
      }
    }
    _closure = closure;
    _suggestions = _generateSuggestions(closure);
    _isLoading = false;
    notifyListeners();
  }

  List<String> _generateSuggestions(List<List<int>> closure) {
    List<String> users = ['A', 'B', 'C'];
    List<String> suggestions = [];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (i != j && _matrix[i][j] == 0 && closure[i][j] == 1) {
          suggestions.add(
              'User ${users[i]} may know ${users[j]} (via mutual connections)');
        }
      }
    }
    return suggestions;
  }

  void reset() {
    _matrix = [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0],
    ];
    _closure = null;
    _suggestions = null;
    _isLoading = false;
    notifyListeners();
  }
}
