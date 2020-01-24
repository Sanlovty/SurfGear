import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/services/pub_publish_manager.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/utils/process_result_extension.dart';

/// Проверка на возможность публикации пакета модулей openSource
class PubDryRunTask extends Check {
  final Element element;

  PubDryRunTask(this.element) : assert(element != null);

  @override
  Future<bool> run() async {
    if (element.hosted) {
      final result = await _getProcessResult(element);
      if (result.exitCode != 0) {
        return Future.error(_getErrorElement(element, result));
      }
    } else {
      return false;
    }
    return true;
  }

  /// Получаем [ProcessResult]  и выводим в консоль результат
  Future<ProcessResult> _getProcessResult(Element element) async {
    final result = await runDryPublish(element);
    result.print();
    return result;
  }

  /// Возвращает имя [Element] и ошибку
  String _getErrorElement(Element element, ProcessResult result) {
    return element.name.toString() + ': ' + result.stderr.toString();
  }
}
