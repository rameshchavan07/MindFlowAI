import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/mood/presentation/mood_screen.dart';
import '../../features/chatbot/presentation/chatbot_screen.dart';
import '../../features/analytics/presentation/analytics_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/journal/presentation/journal_screen.dart';
import '../../features/community/presentation/community_screen.dart';
import '../../features/counselor/presentation/counselor_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../widgets/navigation/bottom_nav_bar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    // Splash Route
    GoRoute(
      path: '/splash',
      name: RouteNames.splash,
      builder: (BuildContext context, GoRouterState state) => const SplashScreen(),
    ),
    // Onboarding Route
    GoRoute(
      path: '/onboarding',
      name: RouteNames.onboarding,
      builder: (BuildContext context, GoRouterState state) => const OnboardingScreen(),
    ),
    // Auth Routes
    GoRoute(
      path: '/login',
      name: RouteNames.login,
      builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: RouteNames.register,
      builder: (BuildContext context, GoRouterState state) => const RegisterScreen(),
    ),

    // Shell Route for Tabbed Navigation
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return ShellLayout(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/dashboard',
          name: RouteNames.dashboard,
          builder: (BuildContext context, GoRouterState state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/mood',
          name: RouteNames.mood,
          builder: (BuildContext context, GoRouterState state) => const MoodScreen(),
        ),
        GoRoute(
          path: '/chatbot',
          name: RouteNames.chatbot,
          builder: (BuildContext context, GoRouterState state) => const ChatbotScreen(),
        ),
        GoRoute(
          path: '/analytics',
          name: RouteNames.analytics,
          builder: (BuildContext context, GoRouterState state) => const AnalyticsScreen(),
        ),
        GoRoute(
          path: '/profile',
          name: RouteNames.profile,
          builder: (BuildContext context, GoRouterState state) => const ProfileScreen(),
        ),
      ],
    ),

    // Subpages (Outside the Shell Bottom NavBar)
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/journal',
      name: RouteNames.journal,
      builder: (BuildContext context, GoRouterState state) => const JournalScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/community',
      name: RouteNames.community,
      builder: (BuildContext context, GoRouterState state) => const CommunityScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/counselor',
      name: RouteNames.counselor,
      builder: (BuildContext context, GoRouterState state) => const CounselorScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/settings',
      name: RouteNames.settings,
      builder: (BuildContext context, GoRouterState state) => const SettingsScreen(),
    ),
  ],
);

// Shell Layout wraps child screens in a Scaffold and places the floating BottomNavBar on top
class ShellLayout extends StatelessWidget {
  final Widget child;

  const ShellLayout({
    super.key,
    required this.child,
  });

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/mood')) return 1;
    if (location.startsWith('/chatbot')) return 2;
    if (location.startsWith('/analytics')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0; // default dashboard
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed(RouteNames.dashboard);
        break;
      case 1:
        context.goNamed(RouteNames.mood);
        break;
      case 2:
        context.goNamed(RouteNames.chatbot);
        break;
      case 3:
        context.goNamed(RouteNames.analytics);
        break;
      case 4:
        context.goNamed(RouteNames.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // lets the background flow behind the floating navbar
      body: Stack(
        children: [
          child,
          BottomNavBar(
            currentIndex: _calculateSelectedIndex(context),
            onTap: (index) => _onItemTapped(index, context),
          ),
        ],
      ),
    );
  }
}
