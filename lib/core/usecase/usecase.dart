// （用例） 表示一段「独立的业务逻辑」。
// 也可以理解为 业务服务层（Application Layer） 的接口或执行器，它「协调」实体与外部资源的交互。
// 来源于 Uncle Bob（Robert C. Martin）提出的 Clean Architecture 模式中的
// 应用业务规则（Application Business Rules） 层的概念。
abstract class UseCase<Type, Params> {
  Future<Type> call({Params params});
}
