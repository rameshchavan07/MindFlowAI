import 'package:flutter/material.dart';
import '../../../widgets/common/app_scaffold.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Community Feed'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Center(
        child: Text(
          'Community feed is scheduled for Phase 6.',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
