import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/report_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID');
  runApp(const LaporDesaApp());
}

class LaporDesaApp extends StatelessWidget {
  const LaporDesaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider()..loadSession(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ReportProvider>(
          create: (_) => ReportProvider(),
          update: (_, authProvider, reportProvider) {
            reportProvider!.setAuthToken(authProvider.token);
            return reportProvider;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Lapor Desa',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF3F7FB),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF10243E),
            brightness: Brightness.light,
          ),
          appBarTheme: const AppBarTheme(
            centerTitle: false,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Color(0xFF10243E),
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Color(0xFF3E5268)),
          ),
        ),
        home: const AppEntry(),
      ),
    );
  }
}

class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        if (!authProvider.isInitialized) {
          return const SplashScreen();
        }

        if (authProvider.isAuthenticated) {
          return const HomeScreen();
        }

        return const LoginScreen();
      },
    );
  }
}

