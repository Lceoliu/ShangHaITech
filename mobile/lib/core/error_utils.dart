import 'dart:async';
import 'dart:io';

import 'api_client.dart';

class AppErrorInfo {
  const AppErrorInfo({
    required this.title,
    required this.message,
    this.hint,
  });

  final String title;
  final String message;
  final String? hint;
}

String formatAppError(Object error) {
  return describeAppError(error).message;
}

AppErrorInfo describeAppError(Object error) {
  if (error is ApiException) {
    final message = error.displayMessage;
    final statusCode = error.statusCode;
    if (statusCode == 401) {
      return const AppErrorInfo(
        title: "需要重新登录",
        message: "当前登录态已失效，请重新登录后再试。",
        hint: "如果刚刚切换过账号，等待 1 到 2 秒后重试通常会恢复。",
      );
    }
    if (statusCode == 402) {
      return const AppErrorInfo(
        title: "额度不足",
        message: "当前可用 Credits 不足，暂时无法继续完成这项操作。",
        hint: "可以前往个人页的 AI 功能中心补充额度或切换到自定义模型。",
      );
    }
    if (statusCode == 404) {
      return const AppErrorInfo(
        title: "内容不存在",
        message: "请求的内容暂时不可用，可能已经被删除或接口尚未返回该资源。",
        hint: "下拉刷新或稍后再试。",
      );
    }
    if (statusCode == 429) {
      return const AppErrorInfo(
        title: "请求过于频繁",
        message: "系统刚刚收到了太多请求，已临时限流。",
        hint: "稍等几秒后再试，不需要连续重复点击。",
      );
    }
    if (statusCode != null && statusCode >= 500) {
      return const AppErrorInfo(
        title: "服务器暂时繁忙",
        message: "服务器刚刚没有成功处理这次请求。",
        hint: "保留当前页面内容，稍后会更容易恢复。",
      );
    }
    return AppErrorInfo(title: "请求失败", message: message);
  }
  if (error is TimeoutException) {
    return const AppErrorInfo(
      title: "请求超时",
      message: "这次加载等待时间过长，可能是校园系统或网络较慢。",
      hint: "当前页面内容会保留，可以稍后再刷新。",
    );
  }
  if (error is SocketException) {
    return const AppErrorInfo(
      title: "网络连接失败",
      message: "当前设备无法连接到服务器。",
      hint: "请检查网络、代理或 DNS 配置。",
    );
  }
  final text = error.toString();
  if (text.contains("Failed host lookup")) {
    return const AppErrorInfo(
      title: "域名解析失败",
      message: "当前网络无法解析服务器域名。",
      hint: "通常是 DNS、代理或网络环境异常导致的。",
    );
  }
  if (text.contains("Connection reset") ||
      text.contains("Connection closed") ||
      text.contains("Software caused connection abort")) {
    return const AppErrorInfo(
      title: "连接被中断",
      message: "请求过程中连接意外中断。",
      hint: "保留当前内容后重新尝试，通常会恢复。",
    );
  }
  return AppErrorInfo(
    title: "请求失败",
    message: error.toString(),
  );
}
