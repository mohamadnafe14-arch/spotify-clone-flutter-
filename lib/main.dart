import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:spotify_clone/core/providers/user_model_notifier.dart';
import 'package:spotify_clone/core/theme/app_palette.dart';
import 'package:spotify_clone/core/theme/theme.dart';
import 'package:spotify_clone/features/auth/view/sign_in_view.dart';
import 'package:spotify_clone/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:spotify_clone/features/home/views/home_view.dart';

ProviderContainer providerContainer = ProviderContainer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  await Hive.initFlutter();
  await Hive.openBox('Songs');
  await providerContainer
      .read(authViewmodelProvider.notifier)
      .initSharedPrefs();
  await providerContainer.read(authViewmodelProvider.notifier).getCurrentUser();
  runApp(
    UncontrolledProviderScope(
      container: providerContainer,
      child: SpofifyApp(),
    ),
  );
}

class SpofifyApp extends ConsumerWidget {
  const SpofifyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userModelNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode.copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
      ),
      home: user == null ? SignInView() : const HomeView(),
    );
  }
}
