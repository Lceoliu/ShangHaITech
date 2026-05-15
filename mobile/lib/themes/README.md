# 主题贡献指南

Better SKD 的主题系统支持通过 PR 添加新主题。本文档说明所有贡献规则和流程。

## 快速上手

1. 复制 `_template.dart.example` 为 `lib/themes/<your_id>.dart`
2. 按模板注释填写颜色、token 和变体配置
3. 在 `lib/theming/registry.dart` 的 `ThemeRegistry.all` 按字母序追加你的主题
4. 运行 `cd mobile && flutter test test/theming/theme_files_test.dart` 通过
5. 提交 PR，附上截图

---

## 主题文件规范

### ✅ 可以写

- 文件内 private 颜色常量（`const _myColor = Color(0xFF...)`）
- `ColorScheme` 的所有字段
- `BetterTokens` 的所有子结构（字体、圆角、间距、阴影等）
- `SubjectAccentScheme` 的 9 个学科色（`computer` 至 `fallback`）
- `VariantSet` 的所有 enum 选项，但只能使用**已发布**的值
- 引用已有的 `HomeStyleId`（如 `HomeStyleId.sunlitV1`）与 `ChromeStyleId`
- `ThemeData` 里的字段（`CardThemeData` / `InputDecorationTheme` / `ChipThemeData` 等）
- `ThemePreview`（`swatch` + 可选 `thumbnailAsset`）

### ❌ 不可以写

- `import` 任何 `features/`、`shared/`、`core/` 目录下的文件
- 定义新的 widget class（`extends StatelessWidget` 等）
- 引入新的 enum case（如给 `CardVariant` 加一个新值）
- 引入新的 `HomeStyleId` 或 `ChromeStyleId`
- 调用网络 API、读写 `SharedPreferences`、启动 `Timer`
- 依赖未在 `pubspec.yaml` 中已有的 pub package

> **新 variant / 新 slot 由谁来加：** `CardVariant` 等 enum 的新 case、新 `HomeStyleId` / `ChromeStyleId` 及其配套 slot 实现，必须由仓库 maintainer 在主线 PR 完成（同时补齐所有 `Themed*` 组件的新分支）。贡献者 PR 只能引用**已发布**的选项，不得附带 enum 改动。

---

## 注册主题

在 `lib/theming/registry.dart` 的 `ThemeRegistry.all` 列表里**按字母序**追加你的主题常量：

```dart
static const List<BetterTheme> all = [
  sunlitDarkTheme,
  sunlitLightTheme,
  YourTheme,   // 按字母序插入
];
```

---

## 命名约定

| 项目 | 规范 | 示例 |
|---|---|---|
| 文件名 | `<id>.dart`（小写 + 下划线） | `coral_spring.dart` |
| 主题常量名 | 大驼峰 | `CoralSpringTheme` |
| `id` 字段 | 与文件名一致，只含小写字母、数字、下划线 | `coral_spring` |
| `authorName` | 你的 GitHub handle | `octocat` |

---

## PR 要求

1. `flutter test test/theming/theme_files_test.dart` 通过
2. 提供四张截图：**首页 · 课程页 · 设置页 · Bottom Nav**
3. `id` 全仓唯一（CI 校验 `ThemeRegistry.all` 无重复 id）
4. 填写 `description`：一句话描述主题的视觉概念

---

## 参考实现

- `sunlit_light.dart`：亮色主题参考（默认主题）
- `sunlit_dark.dart`：暗色主题参考
