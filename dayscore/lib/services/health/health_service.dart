import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class HealthService {
  final Health _health = Health();

  final List<HealthDataType> _types = [
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.HEART_RATE,
    HealthDataType.SLEEP_SESSION,
  ];

  /// Checks if health data is available and requests permissions.
  /// Returns [true] if authorization is granted.
  Future<bool> requestPermissions() async {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) {
      debugPrint('Health integration is not supported on this platform.');
      return false;
    }

    try {
      // Check Activity Recognition (Android) or Sensor permission
      if (Platform.isAndroid) {
        final activityRecognitionStatus = await Permission.activityRecognition.request();
        final bodySensorsStatus = await Permission.sensors.request();
        if (activityRecognitionStatus.isDenied || bodySensorsStatus.isDenied) {
          debugPrint('Android runtime sensors/activity permissions denied.');
          return false;
        }
      }

      final permissions = _types.map((e) => HealthDataAccess.READ).toList();
      final hasPermissions = await _health.hasPermissions(_types, permissions: permissions);

      if (hasPermissions == true) {
        return true;
      }

      final requested = await _health.requestAuthorization(
        _types,
        permissions: permissions,
      );

      return requested;
    } catch (e) {
      debugPrint('Error requesting health permissions: $e');
      return false;
    }
  }

  /// Fetches steps count for today. Returns a default mock value of 6432 if permissions are denied.
  Future<int> fetchTodaySteps() async {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) {
      return 6432; // Mock fallback
    }

    try {
      final now = DateTime.now();
      final midnight = DateTime(now.year, now.month, now.day);
      final steps = await _health.getTotalStepsInInterval(midnight, now);
      return steps ?? 0;
    } catch (e) {
      debugPrint('Error fetching steps, using fallback: $e');
      return 6432; // Mock fallback
    }
  }

  /// Fetches active calories burned today. Returns a default mock value of 350 if permissions are denied.
  Future<double> fetchTodayCalories() async {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) {
      return 350.0; // Mock fallback
    }

    try {
      final now = DateTime.now();
      final midnight = DateTime(now.year, now.month, now.day);
      final dataPoints = await _health.getHealthDataFromTypes(
        startTime: midnight,
        endTime: now,
        types: [HealthDataType.ACTIVE_ENERGY_BURNED],
      );

      double totalCalories = 0.0;
      for (var point in dataPoints) {
        final val = point.value;
        if (val is NumericHealthValue) {
          totalCalories += val.numericValue.toDouble();
        }
      }
      return totalCalories;
    } catch (e) {
      debugPrint('Error fetching calories, using fallback: $e');
      return 350.0; // Mock fallback
    }
  }

  /// Fetches heart rate samples from today and returns the average. Returns 72 bpm if denied.
  Future<int> fetchAverageHeartRate() async {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) {
      return 72; // Mock fallback
    }

    try {
      final now = DateTime.now();
      final midnight = DateTime(now.year, now.month, now.day);
      final dataPoints = await _health.getHealthDataFromTypes(
        startTime: midnight,
        endTime: now,
        types: [HealthDataType.HEART_RATE],
      );

      if (dataPoints.isEmpty) return 72;

      double totalHR = 0.0;
      int count = 0;
      for (var point in dataPoints) {
        final val = point.value;
        if (val is NumericHealthValue) {
          totalHR += val.numericValue.toDouble();
          count++;
        }
      }
      return count > 0 ? (totalHR / count).round() : 72;
    } catch (e) {
      debugPrint('Error fetching heart rate, using fallback: $e');
      return 72; // Mock fallback
    }
  }

  /// Fetches sleep session duration today (in minutes). Returns 432 minutes (7.2 hours) if denied.
  Future<int> fetchTodaySleepMinutes() async {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) {
      return 432; // Mock fallback (7.2 hours)
    }

    try {
      final now = DateTime.now();
      final yesterdayMidnight = DateTime(now.year, now.month, now.day).subtract(const Duration(hours: 24));
      final dataPoints = await _health.getHealthDataFromTypes(
        startTime: yesterdayMidnight,
        endTime: now,
        types: [HealthDataType.SLEEP_SESSION],
      );

      int totalSleepMinutes = 0;
      for (var point in dataPoints) {
        final val = point.value;
        if (val is NumericHealthValue) {
          // If value is stored as minutes or hours
          totalSleepMinutes += val.numericValue.toInt();
        } else {
          // Calculate duration between dateFrom and dateTo
          final diff = point.dateTo.difference(point.dateFrom).inMinutes;
          totalSleepMinutes += diff;
        }
      }
      return totalSleepMinutes > 0 ? totalSleepMinutes : 432; // Mock fallback if 0
    } catch (e) {
      debugPrint('Error fetching sleep, using fallback: $e');
      return 432; // Mock fallback
    }
  }
}
