
class PathSingleton {
  factory PathSingleton() {
    return _instance;
  }

  late String _appDir;


  PathSingleton._singletonContractor(){
    print('Will be called once when object created');
  }
  
  static final PathSingleton _instance = PathSingleton._singletonContractor();

  // Getter for the stored string value
  String get appDir => _appDir;

  // Setter for the string value
  set setAppDir(String value) {
    _appDir = value;
  }

}