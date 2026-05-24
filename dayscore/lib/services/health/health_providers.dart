import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/auth_providers.dart';
import 'health_service.dart';

class HealthMetricsState {
  final int steps;
  final double calories;
  final int heartRate;
  final int sleepMinutes;
  final bool hasPermissions;
  final bool isLoading;

  const HealthMetricsState({
    required this.steps,
    required this.calories,
    required this.heartRate,
    required this.sleepMinutes,
    required this.hasPermissions,
    required this.isLoading,
  });

  HealthMetricsState copyWith({
    int? steps,
    double? calories,
    int? heartRate,
    int? sleepMinutes,
    bool? hasPermissions,
    bool? isLoading,
  }) {
    return HealthMetricsState(
      steps: steps ?? this.steps,
      calories: calories ?? this.calories,
      heartRate: heartRate ?? this.heartRate,
      sleepMinutes: sleepMinutes ?? this.sleepMinutes,
      hasPermissions: hasPermissions ?? this.hasPermissions,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final healthServiceProvider = Provider<HealthService>((ref) {
  return HealthService();
});

class HealthMetricsNotifier extends StateNotifier<HealthMetricsState> {
  final HealthService healthService;

  HealthMetricsNotifier({required this.healthService})
      : super(const HealthMetricsState(
          steps: 6432, // Start with defaults/cached
          calories: 350.0,
          heartRate: 72,
          sleepMinutes: 432,
          hasPermissions: false,
          isLoading: false,
        ));

  Future<void> init() async {
    if (state.hasPermissions || state.isLoading) return;

    state = state.copyWith(isLoading: true);
    final granted = await healthService.requestPermissions();
    state = state.copyWith(hasPermissions: granted);
    await syncData();
  }

  Future<void> syncData() async {
    state = state.copyWith(isLoading: true);
    try {
      final steps = await healthService.fetchTodaySteps();
      final calories = await healthService.fetchTodayCalories();
      final hr = await healthService.fetchAverageHeartRate();
      final sleep = await healthService.fetchTodaySleepMinutes();

      state = state.copyWith(
        steps: steps,
        calories: calories,
        heartRate: hr,
        sleepMinutes: sleep,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}

final healthMetricsProvider = StateNotifierProvider<HealthMetricsNotifier, HealthMetricsState>((ref) {
  final healthService = ref.watch(healthServiceProvider);
  final notifier = HealthMetricsNotifier(healthService: healthService);
  
  // Automatically initialize health when user is signed in
  ref.listen(currentUserProvider, (previous, next) {
    if (next.hasValue && next.value != null) {
      notifier.init();
    }
  });

  return notifier;
});

/// Computes a composite wellness score (0-100) based on fitness goals and current stats
final wellnessScoreProvider = Provider<double>((ref) {
  final metrics = ref.watch(healthMetricsProvider);
  final userProfile = ref.watch(currentUserProvider).value;

  // Retrieve user-specific targets or use smart defaults
  final stepTarget = userProfile?.fitnessTarget ?? 8000;
  final sleepTargetMinutes = ((userProfile?.sleepTarget ?? 8.0) * 60).toInt();

  // 1. Steps Score (Max 35 points)
  double stepsScore = (metrics.steps / stepTarget) * 35.0;
  if (stepsScore > 35.0) stepsScore = 35.0;

  // 2. Sleep Score (Max 35 points)
  double sleepScore = (metrics.sleepMinutes / sleepTargetMinutes) * 35.0;
  if (sleepScore > 35.0) sleepScore = 35.0;

  // 3. Heart Rate Healthiness (Max 15 points)
  // Optimal resting/active average is between 60 and 85
  double hrScore = 15.0;
  if (metrics.heartRate < 60) {
    hrScore -= (60 - metrics.heartRate) * 0.5;
  } else if (metrics.heartRate > 85) {
    hrScore -= (metrics.heartRate - 85) * 0.4;
  }
  if (hrScore < 0.0) hrScore = 0.0;

  // 4. Calories / Activity level (Max 15 points)
  // Assuming a baseline active expenditure of 300 kcal
  double caloriesScore = (metrics.calories / 300.0) * 15.0;
  if (caloriesScore > 15.0) caloriesScore = 15.0;

  final composite = stepsScore + sleepScore + hrScore + caloriesScore;
  return composite.clamp(0.0, 100.0);
});
