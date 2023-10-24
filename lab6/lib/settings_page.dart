import 'package:flutter/material.dart';
import 'package:lab6/settings_model.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SettingsPage extends StatefulWidget {
  final SettingsModel settings;

  const SettingsPage({
    required this.settings,
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final FormControl<Color> _backgroundColorController = FormControl<Color>(
    value: widget.settings.backgroundColor,
  );

  late final FormControl<Color> _textColorController = FormControl<Color>(
    value: widget.settings.textColor,
  );
  late final FormControl<int> _textSizeController = FormControl<int>(
    value: widget.settings.textSize,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    _BackGroundColorSettings(
                      backgroundColorController: _backgroundColorController,
                    ),
                    _TextColorSettings(
                      textColorController: _textColorController,
                    ),
                    _TextSizeSettings(textSizeController: _textSizeController),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(
                          SettingsModel(
                            backgroundColor: _backgroundColorController.value!,
                            textColor: _textColorController.value!,
                            textSize: _textSizeController.value!,
                          ),
                        );
                      },
                      child: const Text('Применить'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackGroundColorSettings extends StatelessWidget {
  final FormControl<Color> backgroundColorController;

  const _BackGroundColorSettings({
    required this.backgroundColorController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Colors.black),
        const Text(
          'Цвет заднего фона',
          style: TextStyle(fontSize: 16),
        ),
        ReactiveRadioListTile<Color>(
          value: Colors.white,
          formControl: backgroundColorController,
          title: const Text('Белый'),
        ),
        ReactiveRadioListTile<Color>(
          value: Colors.pink,
          formControl: backgroundColorController,
          title: const Text('Розовый'),
        ),
        ReactiveRadioListTile<Color>(
          value: Colors.blueAccent,
          formControl: backgroundColorController,
          title: const Text('Синий'),
        ),
        const Divider(color: Colors.black),
      ],
    );
  }
}

class _TextColorSettings extends StatelessWidget {
  final FormControl<Color> textColorController;

  const _TextColorSettings({
    required this.textColorController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Colors.black),
        const Text(
          'Цвет текста',
          style: TextStyle(fontSize: 16),
        ),
        ReactiveRadioListTile<Color>(
          value: Colors.white,
          formControl: textColorController,
          title: const Text('Белый'),
        ),
        ReactiveRadioListTile<Color>(
          value: Colors.black,
          formControl: textColorController,
          title: const Text('Черный'),
        ),
        ReactiveRadioListTile<Color>(
          value: Colors.yellow,
          formControl: textColorController,
          title: const Text('Желтый'),
        ),
        const Divider(color: Colors.black),
      ],
    );
  }
}

class _TextSizeSettings extends StatelessWidget {
  final FormControl<int> textSizeController;

  const _TextSizeSettings({
    required this.textSizeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Colors.black),
        const Text(
          'Цвет текста',
          style: TextStyle(fontSize: 16),
        ),
        ReactiveRadioListTile<int>(
          value: 14,
          formControl: textSizeController,
          title: const Text('Маленький'),
        ),
        ReactiveRadioListTile<int>(
          value: 30,
          formControl: textSizeController,
          title: const Text('Средний'),
        ),
        ReactiveRadioListTile<int>(
          value: 50,
          formControl: textSizeController,
          title: const Text('Большой'),
        ),
        const Divider(color: Colors.black),
      ],
    );
  }
}
