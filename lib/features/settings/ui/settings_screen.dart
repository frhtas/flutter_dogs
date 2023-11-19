import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dogs/common/app_colors.dart';
import 'package:flutter_dogs/common/assets.dart';

import '../bloc/settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SettingsItem> settingItems = [
      const SettingsItem(title: 'Help', iconPath: Assets.info),
      const SettingsItem(title: 'Rate Us', iconPath: Assets.star),
      const SettingsItem(title: 'Share with Friends', iconPath: Assets.export),
      const SettingsItem(title: 'Terms of Use', iconPath: Assets.scroll),
      const SettingsItem(title: 'Privacy Policy', iconPath: Assets.shieldCheck),
    ];

    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SettingsLoading) {
          return const CircularProgressIndicator();
        }

        settingItems.add(
          SettingsItem(
            title: 'OS Version',
            iconPath: Assets.gitBranch,
            trailingText: state.version,
          ),
        );

        return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 16.0),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: settingItems.length,
            itemBuilder: (context, index) {
              return settingItems[index];
            },
            separatorBuilder: (context, index) {
              return const Divider(color: grey, indent: 16.0, height: 2);
            },
          ),
        );
      },
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final String? trailingText;

  const SettingsItem({
    Key? key,
    required this.title,
    required this.iconPath,
    this.trailingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 5,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Image.asset(iconPath, height: 32, width: 32),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: trailingText != null
          ? Text(
              trailingText!,
              style: TextStyle(
                fontSize: 13,
                color: versionColor.withOpacity(0.6),
              ),
            )
          : Image.asset(Assets.arrowUpRight, height: 16, width: 16),
    );
  }
}
