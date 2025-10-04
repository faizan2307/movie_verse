import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';

/// Settings page that provides information about the app and deep link system.
/// 
/// This page displays:
/// - App information (name, version, description)
/// - Deep link format and usage instructions
/// - Step-by-step guide on how to use deep links
/// 
/// The page is designed to help users understand how the deep link system works
/// and how they can share movies with friends.
class SettingsPage extends StatelessWidget {
  /// Creates a new SettingsPage instance.
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.settings),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // App Information Section - Shows basic app details
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.appInformation,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('App Name', AppStrings.appName),
                  _buildInfoRow('Version', AppStrings.appVersion),
                  _buildInfoRow('Description', AppStrings.appDescription),
                ],
              ),
            ),
          ),
          
          // Deep Link Information Section - Explains the deep link format and system
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.deepLinkInformation,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Scheme', AppStrings.deepLinkScheme),
                  _buildInfoRow('Host', AppStrings.deepLinkHost),
                  _buildInfoRow('Format', '${AppStrings.deepLinkScheme}://${AppStrings.deepLinkHost}/123'),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.deepLinkDescription,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // How to Use Section - Step-by-step instructions for using deep links
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.howToUseDeepLinks,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildStepRow(context, '1', AppStrings.step1),
                  _buildStepRow(context, '2', AppStrings.step2),
                  _buildStepRow(context, '3', AppStrings.step3),
                  _buildStepRow(context, '4', AppStrings.step4
                      .replaceAll('{scheme}', AppStrings.deepLinkScheme)
                      .replaceAll('{host}', AppStrings.deepLinkHost)),
                  _buildStepRow(context, '5', AppStrings.step5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds an information row with a label and value.
  /// 
  /// This helper method creates a consistent layout for displaying
  /// key-value pairs of information.
  /// 
  /// [label] - The label text (e.g., "App Name", "Version").
  /// [value] - The value text to display.
  /// 
  /// Returns a Row widget with the label and value properly formatted.
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fixed width label column for consistent alignment
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          // Expandable value column that wraps text if needed
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a step row with a numbered circle and description.
  /// 
  /// This helper method creates a consistent layout for displaying
  /// numbered steps in instructions or guides.
  /// 
  /// [context] - The build context for accessing theme data.
  /// [step] - The step number to display in the circle.
  /// [description] - The description text for the step.
  /// 
  /// Returns a Row widget with a numbered circle and step description.
  Widget _buildStepRow(BuildContext context, String step, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circular step number indicator
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Spacing between step number and description
          const SizedBox(width: 12),
          // Expandable description text
          Expanded(
            child: Text(description),
          ),
        ],
      ),
    );
  }
}
