import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:hospital_control/controllers/data_controller.dart';
import 'package:hospital_control/controllers/setting_controller.dart';
import 'package:hospital_control/controllers/split_view_controller.dart';
import 'package:hospital_control/models/auth_models.dart';
import 'package:hospital_control/screens/common/notification.dart';
import 'package:hospital_control/screens/common/prop_card.dart';
import 'package:sprintf/sprintf.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthStatus status = Get.arguments;
    bool adminFeatures = false;
    switch (status.status) {
      case Status.admin:
        adminFeatures = true;
        break;
      case Status.user:
        adminFeatures = false;
        break;
      case Status.noUser:
        print('unknown user');
        SchedulerBinding.instance
            ?.addPostFrameCallback((_) => Get.offNamed('/', arguments: status));
        break;
    }
    SplitViewController controller = Get.find<SplitViewController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Контроль микроклимата'), actions: [
        if (adminFeatures)
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Уставки',
            onPressed: () => controller.toggleSplit(),
          ),
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Выйти',
          onPressed: () => Get.offNamed('/auth'),
        ),
      ]),
      body: adminFeatures
          ? Obx(() => SplitView(
                showRightWidget: controller.split,
                leftWidget: const DataPanel(),
                rightWidget: const SettingsPanel(),
              ))
          : const DataPanel(),
    );
  }
}

class NotificationsView extends StatelessWidget {
  final bool showThiefNotification;
  final bool showUnknownCardNotification;

  const NotificationsView({
    Key? key,
    required this.showThiefNotification,
    required this.showUnknownCardNotification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (showThiefNotification)
          AlertNotification(
            text: 'Возможно в помещение проник злоумышленник!',
            icon: const Icon(
              Icons.warning,
              color: Colors.white,
            ),
            gradient: LinearGradient(
              colors: [
                Colors.red.shade600,
                Colors.red.shade900,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            textColor: Colors.white,
          ),
        if (showUnknownCardNotification)
          AlertNotification(
            text:
                'Кто-то пытался войти в помещение, используя незарегистрированную карту.',
            icon: const Icon(
              Icons.warning,
              color: Colors.white,
            ),
            gradient: LinearGradient(
              colors: [
                Colors.orange.shade600,
                Colors.orange.shade900,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            textColor: Colors.white,
          ),
      ],
    );
  }
}

class DataPanel extends GetView<DataController> {
  const DataPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        controller.obx(
          (data) => NotificationsView(
            showThiefNotification: data?.thief ?? false,
            showUnknownCardNotification: data?.unknownCard ?? false,
          ),
          onLoading: Container(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Text(
            'Показатели',
            style: Get.textTheme.headline4,
          ),
        ),
        Expanded(
          child: controller.obx(
            (data) {
              final bool? motion = data?.motion;
              final bool? open = data?.open;
              final bool? heater = data?.heater;
              final bool? cooler = data?.cooler;

              return GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 1.5,
                children: [
                  PropCard(
                    data: sprintf('%.1f°C', [data?.temperature]),
                    description: "Температура",
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade300,
                        Colors.blue.shade600,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    textColor: Colors.white,
                  ),
                  PropCard(
                    data: sprintf('%.0f%%', [data?.humidity]),
                    description: "Влажность",
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade300,
                        Colors.blue.shade600,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    textColor: Colors.white,
                  ),
                  PropCard(
                    data: sprintf('%.1f лк', [data?.light]),
                    description: "Освещенность",
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade300,
                        Colors.blue.shade600,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    textColor: Colors.white,
                  ),
                  PropCard(
                    data: sprintf('%.1f Вт*ч', [data?.energy]),
                    description: "Потребление",
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade300,
                        Colors.blue.shade600,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    textColor: Colors.white,
                  ),
                  PropCard(
                    data: motion == null
                        ? 'Нет данных'
                        : (motion ? 'Присутствуют' : 'Отсутствуют'),
                    description: "Люди",
                    gradient: LinearGradient(
                      colors: (motion == null || !motion)
                          ? [
                              Colors.grey.shade400,
                              Colors.grey.shade600,
                            ]
                          : [
                              Colors.orange.shade300,
                              Colors.orange.shade600,
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    textColor: Colors.white,
                  ),
                  PropCard(
                    data: open == null
                        ? 'Нет данных'
                        : (open ? 'Открыта' : 'Закрыта'),
                    description: "Дверь",
                    gradient: LinearGradient(
                      colors: (open == null || !open)
                          ? [
                              Colors.blue.shade300,
                              Colors.blue.shade600,
                            ]
                          : [
                              Colors.orange.shade300,
                              Colors.orange.shade600,
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    textColor: Colors.white,
                  ),
                  PropCard(
                    data: heater == null
                        ? 'Нет данных'
                        : (heater ? 'Включён' : 'Выключен'),
                    description: "Нагреватель",
                    gradient: LinearGradient(
                      colors: (heater == null || !heater)
                          ? [
                              Colors.grey.shade400,
                              Colors.grey.shade600,
                            ]
                          : [
                              Colors.lightGreen.shade300,
                              Colors.lightGreen.shade600,
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    textColor: Colors.white,
                  ),
                  PropCard(
                    data: cooler == null
                        ? 'Нет данных'
                        : (cooler ? 'Включён' : 'Выключен'),
                    description: "Вентилятор",
                    gradient: LinearGradient(
                      colors: (cooler == null || !cooler)
                          ? [
                              Colors.grey.shade400,
                              Colors.grey.shade600,
                            ]
                          : [
                              Colors.lightGreen.shade300,
                              Colors.lightGreen.shade600,
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    textColor: Colors.white,
                  ),
                ],
              );
            },
            onError: (error) => Center(child: Text('ERROR: $error')),
            onEmpty: const Center(child: Text('ERROR: no response')),
          ),
        ),
      ],
    );
  }
}

class SettingsPanel extends StatelessWidget {
  const SettingsPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataController dataController = Get.find<DataController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Text(
            'Уставки',
            style: Get.textTheme.headline4,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Text(
            'Температура',
            style: Get.textTheme.headline6,
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              SettingsListTile(
                leading: const Icon(Icons.local_fire_department),
                title: 'Max',
                controllerTag: 'max_temperature',
                format: '%d°C',
                sendValue: (value) => dataController.postTemp(maxTemp: value),
                checker: (value) =>
                    dataController.checkForTemps(maxTemp: value),
              ),
              SettingsListTile(
                leading: const Icon(Icons.ac_unit),
                title: 'Min',
                controllerTag: 'min_temperature',
                format: '%d°C',
                sendValue: (value) => dataController.postTemp(minTemp: value),
                checker: (value) =>
                    dataController.checkForTemps(minTemp: value),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class SettingsListTile extends StatelessWidget {
  final String title;
  final Widget? leading;
  final String format;
  final bool readOnly;
  final double step;
  final String controllerTag;
  final void Function(double value) sendValue;
  final bool Function(double value) checker;

  const SettingsListTile({
    Key? key,
    required this.title,
    this.leading,
    this.format = '%f',
    this.readOnly = false,
    this.step = 1.0,
    required this.controllerTag,
    required this.sendValue,
    required this.checker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingController settingController =
        Get.find<SettingController>(tag: controllerTag);

    return SizedBox(
      child: ListTile(
        leading: leading,
        title: Text(title),
        trailing: ValueChooser(
          initialValue: settingController.value.value,
          setValue: (value) {
            settingController.setValue(value);
            sendValue(value);
          },
          step: step,
          format: format,
          minValue: settingController.minValue,
          maxValue: settingController.maxValue,
          checker: checker,
        ),
      ),
    );
  }
}

class ValueChooser extends StatefulWidget {
  double initialValue;
  final void Function(double value) setValue;
  final double step;
  final String format;
  final double minValue;
  final double maxValue;
  final bool Function(double value) checker;

  ValueChooser({
    Key? key,
    required this.initialValue,
    required this.setValue,
    this.step = 1.0,
    this.format = '%f',
    this.minValue = 0.0,
    this.maxValue = 100.0,
    required this.checker,
  }) : super(key: key);

  @override
  _ValueChooserState createState() => _ValueChooserState();
}

class _ValueChooserState extends State<ValueChooser> {
  late double value;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          color: Colors.red,
          onPressed: (value > widget.minValue)
              ? () => setState(() {
                    value -= widget.step;
                  })
              : null,
        ),
        Text(sprintf(widget.format, [value])),
        IconButton(
          icon: const Icon(Icons.add),
          color: Colors.green,
          onPressed: (value < widget.maxValue)
              ? () => setState(() {
                    value += widget.step;
                  })
              : null,
        ),
        SizedBox(
          width: 1.0,
          height: 30.0,
          child: Container(
            color: Colors.grey,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          color: Colors.red,
          tooltip: 'Отменить',
          onPressed: (value != widget.initialValue)
              ? () {
                  setState(() {
                    value = widget.initialValue;
                  });
                }
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.done),
          color: Colors.green,
          tooltip: 'Принять',
          onPressed: (value != widget.initialValue && widget.checker(value))
              ? () {
                  setState(() {
                    widget.initialValue = value;
                  });
                  widget.setValue(value);
                }
              : null,
        ),
      ],
    );
  }
}

class SplitView extends StatelessWidget {
  final Widget leftWidget;
  final Widget rightWidget;
  final bool showRightWidget;
  static const double _ratio = 0.65;
  static const double _dividerWidth = 2.0;

  const SplitView({
    Key? key,
    required this.leftWidget,
    required this.rightWidget,
    this.showRightWidget = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!showRightWidget) {
      return leftWidget;
    }

    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;
        final leftWidth = maxWidth * _ratio - _dividerWidth / 2;
        final rightWidth = maxWidth * (1 - _ratio) - _dividerWidth / 2;

        return SizedBox(
          width: maxWidth,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: leftWidth,
                child: leftWidget,
              ),
              SizedBox(
                width: _dividerWidth,
                height: maxHeight,
                child: Container(
                  color: Get.theme.colorScheme.primary,
                ),
              ),
              SizedBox(
                width: rightWidth,
                child: rightWidget,
              ),
            ],
          ),
        );
      },
    );
  }
}
