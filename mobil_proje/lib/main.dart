import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mobil_proje/view/home.dart';
import 'package:mobil_proje/view/restapi.dart';
import 'package:mobil_proje/view/json.dart';

import 'view/profile.dart';  // Burada ekleme yapıldı.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('tr', 'TR')],
      path: 'assets/translations', // çeviri dosyalarının bulunduğu klasör
      fallbackLocale: Locale('en', 'US'), // varsayılan dil
      child: ProviderScope(
        child: App(),
      ),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/main');
    });

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MainPage extends ConsumerStatefulWidget {
  final VoidCallback toggleTheme;

  const MainPage({Key? key, required this.toggleTheme}) : super(key: key);

  void _toggleLanguage(BuildContext context) {
    if (context.locale == Locale('en', 'US')) {
      context.setLocale(Locale('tr', 'TR'));
    } else {
      context.setLocale(Locale('en', 'US'));
    }
  }

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int _selectedViewIndex = 0;
  late final List<Widget> _widgetsOptions;

  @override
  void initState() {
    super.initState();
    _widgetsOptions = [
      Home(toggleTheme: widget.toggleTheme),
      RestApi(toggleTheme: widget.toggleTheme),
      Json(toggleTheme: widget.toggleTheme),
      ImageLoad(toggleTheme: widget.toggleTheme),  // Burada ekleme yapıldı.
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedViewIndex = index;
    });
  }

  void _toggleLanguage() {
    if (context.locale == Locale('en', 'US')) {
      context.setLocale(Locale('tr', 'TR'));
    } else {
      context.setLocale(Locale('en', 'US'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Center(
        child: _widgetsOptions.elementAt(_selectedViewIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.web),
            label: 'RestApi'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_present),
            label: 'Json'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.animation),
            label: 'Animation'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'ImageLoad'.tr(),  // Burada ekleme yapıldı.
          ),
        ],
        currentIndex: _selectedViewIndex,
        selectedItemColor: isDarkMode ? Colors.white : Colors.blue,
        unselectedItemColor: isDarkMode ? Colors.grey[600] : Colors.grey[700],
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
