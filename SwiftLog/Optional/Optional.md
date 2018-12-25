#Optional可空类型
用于指定某个实例可能没有值,即为nil (Swift的安全性)
只有声明为optional类型的变量才能赋值为nil

可选绑定optional binding 检查某个可空类型是否为nil

```
    if let variable = optional {
       //使用 variable
    }else{
    //nil,没有值
    }
    //可以多个连用
    if let variable1 = optional1,let variable2 = optional2 {
    //使用 variable1,2
    }else{
    //nil,没有值
    }
```
可选链式调用 optional chaining 查询一连串可空值
即将多个查询串联为一个可空类型的值,链式调用中的每个可空实例都包含值,调用才会成功

```
var errorCodeString:String?
errorCodeString = "404"

var errorDescption:String?

if let theError = errorCodeString,let errorCodeInterger = Int(theError),errorCodeString == "404"{
    errorDescption = "\(errorCodeInterger + 200):resource was not found"
}

print(errorDescption ?? "nil")

```


隐式调用?与强制解包 forced unwrapping !
隐式调用当一个可选类型为nil时,什么也不做
强制解包需要程序员保证其一定不为空,否则将会发生运行时错误

```
var name:String?
name = nil
name?.append("zhang")

```

隐式展开可空类型 implicitly unwrapping optional

```
  var errorCodeString:String!
  errerrorCodeString = "NO Error"
```
隐式展开可空类型不需要编译器进行为空判断,所以需要程序员自己保证其不为空值,否则将会引发运行时错误
一般用于类的初始化

```
var errorCodeString:String!
errorCodeString = "404"
print(errorCodeString)

errorCodeString = nil

//为nil将导致运行时错误
//errorCodeString.append("sss")
//print(errorCodeString)

//如果errorCodeString为nil将会导致运行时错误
let anotherCodeString:String = errorCodeString

//编译器推断为 String? 类型
let yetAnotherString = errorCodeString

```
nil合并运算符??(空合运算符)

nil合并运算符 ??左边必须是可空类型,右边是非可空的同类型的实例
表示当可空类型不为空时使用其本身的值,为nil时使用??右边的实例,避免了判断的麻烦

```
var errorDescption:String?
print(errorDescption ?? "nil")
```
