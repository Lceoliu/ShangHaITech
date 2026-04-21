# 开发指南

这份文档说明社区贡献者如何在 ShangHaITech 的公开协作代码上开发。主 README 面向用户介绍 App 内容；开发边界、贡献范围和实现约定放在这里维护。

## 协作范围

当前公开仓库主要适合这些贡献：

- 移动端 UI、动效、布局、深色模式和无障碍优化
- 首页、课程、DDL、邮件、消息、设置等公共交互模式的建议和原型
- 共享组件、主题 token、错误展示、加载态和缓存体验优化
- 文案、本地化、README、QA、Release notes 和开发文档
- 轻量校园工具和社区扩展 manifest
- 公开工具代码的测试和质量检查

涉及以下内容时，请先开 issue 描述目标和数据边界，不要直接提交实现：

- 需要新增后端 API 的功能
- 需要处理真实用户凭据、邮箱内容、课程平台数据或其他敏感数据的功能
- 可能影响校园系统访问频率、风控、权限或合规性的功能
- 依赖未公布测试服务、内部接口或生产环境行为的功能

## 本地环境

先安装 Flutter 并检查环境：

```bash
flutter doctor
```

然后安装移动端依赖：

```bash
cd mobile
flutter pub get
```

公开 Flutter 代码主要用于共享 UI、主题、API envelope、错误处理和扩展机制的协作。部分页面、路由、仓库层和后端能力会被有意省略。

## API 配置

公开代码不应写死生产 API。需要本地运行时，请使用构建参数：

```bash
flutter run --dart-define=API_BASE_URL=http://127.0.0.1:18000/api/v1
```

正式构建由维护者在私有发布流程中注入真实 API 地址。

## 前端结构

公开 Flutter 子集保留这些层：

```text
mobile/lib/core/          API envelope、配置、主题、安全存储模式
mobile/lib/shared/        可复用组件、模型和工具函数
mobile/lib/features/      安全的 feature 示例和公共交互模式
```

推荐 feature 结构：

```text
features/your_feature/
  your_feature_page.dart
  your_feature_repository.dart
  your_feature_models.dart
```

页面代码应专注 UI 状态；网络解析、缓存和错误分类放到 repository 层；加载、错误、搜索和导航尽量复用 shared 组件。

## 加载与刷新

用户可见功能应做到：

- 快速渲染缓存或占位内容
- 使用局部 loading，不要轻易整页阻塞
- 后台刷新时保留旧内容
- 乐观更新后用简洁 toast 反馈
- 将错误明确分为鉴权、网络、服务端、参数校验或暂不可用

切换底部 tab 时不要整页重刷。

## 主题要求

所有 UI 改动都必须同时支持浅色和深色模式。避免硬编码文字颜色，优先使用：

```dart
final cs = Theme.of(context).colorScheme;
```

新增视觉元素前，先检查已有 shared widget 和 theme token。

## 扩展开发

社区扩展从 manifest 开始：

```json
{
  "key": "hello-world",
  "name": "Hello World",
  "description": "Example extension manifest",
  "version": "0.1.0",
  "enabled": false,
  "required_role": "user",
  "web": {
    "entry_path": "/extensions/hello-world"
  },
  "api": {
    "base_path": "/api/v1/extensions/hello-world"
  },
  "jobs": ["hello.run"],
  "owner": "community"
}
```

维护者会决定一个扩展是否可以启用，以及是否需要私有后端支持。

## 后端边界

公开仓库只包含经过筛选的非敏感服务示例。生产路由、管理 API、内部额度与资源调度、AI 路由、邮件处理、敏感校园数据链路和自动化服务均不在公开范围内。

如果贡献需要后端能力，请在 issue 中描述你需要的数据形状和用户场景，不要在公开代码中假设私有 API。

## PR 前检查

- 对修改过的 Flutter 代码尽量运行 `flutter analyze`
- 不包含密钥、token、日志、私有 endpoint 或数据库快照
- 不包含生产 API 文档
- UI 改动附截图或录屏
- 已检查深色模式
- 涉及用户数据时说明隐私影响和授权方式
