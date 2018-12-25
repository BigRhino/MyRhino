

#  属性
- 存储型属性&计算型属性
- 惰性属性
- 属性观察器
- 类型属性

##存储型属性&计算型属性
Stored Property&Computed Property
存储型属性就是用来存储值的,比如:

```
struct Town {
  let region = "South"
  var numberOfStoplights = 4
}
```
计算型属性不会像之前的属性那样存储值，而是提供一个读取方法 （getter）来获取属性的值，并可选地提供一个写入方法 （setter）设置属性的值
计算型属性必须有类型信息,提供读取方法来获取属性的值,可选的提供一个写入方法(setter)来设置属性的值

```
var townSize:Size{
    get{
        switch self.population {
        case 0...10_000:
        return Size.small
        case 10_001...100_000:
        return Size.medium
        default:
        return Size.large
        }
    }
}
```
get-only property只读计算型属性 get可以省略,没有实现set方法不能进行赋值,编译器直接报错

```
var weight:Int{
    return height * 3
    }
```
因为在内部调用set,get而导致死循环,在内部编译器会进行警告

```
//死循环
var size:Int{
    get{
    //将会调用get方法
    return size
    }
    set{
    //将会调用set方法
    size = newValue
    }
}
```
###惰性属性
即OC的懒加载,使用才加载,多次使用也只初始化一次

关键:1.lazy 2.var 3.()
1.lazy告诉编译器这个属性不是创建self所必须的,如果它不存在,就应该在它被第一次访问的时候创建
2.延迟把属性的值的计算推迟到实例初始化后,必须声明为var,因为它的值会发生变化
3.圆括号和lazy确保编译器会在我们第一次访问这个属性的时候调用闭包并将结果赋值给它

当闭包被调用时,self肯定已经可用了

```
   //lazy 只会被执行一次
   lazy var townSize:Size  = {
        switch self.population {
        case 0...10_000:
            return Size.small
        case 10_001...100_000:
            return Size.medium
        default:
            return Size.large
        }
    }()

```
###属性观察器 Property Observe
属性观察可以让我们在当前类型内监视对于属性的设定,并作出一些响应.
willSet(观察属性即将发生变化),didSet(观察属性已经发生变化),一般用于作为设置值的验证.
可以根据默认参数oldValue,newValue来获取已经设定的值和即将要设定的值,当然也可以自定义参数名称.
初始化方法对属性的设定,不会触发属性观察器的调用,所以对于let的常量设置属性观察器是无用的(常量是初始化的时候进行赋值)
属性观察器和计算型属性是不能共存的.

```
class LightBulb{

    static let maxCurrent = 30
    var current = 0 {
        // 可以不声明新的变量名，使用newValue
        willSet(newCurrent){
        // 此时，current还是以前的值
        print("Current value changed. The change is \(abs(current-newCurrent))")
    }

    // property observer可以用来限制值或者格式
    // 也可以用来做关联逻辑
    // 可以不声明新的变量名，使用oldValue获取原来的值
    didSet(oldCurrent){
        // 此时，current已经是新的值
        if current == LightBulb.maxCurrent{
        print("Pay attention, the current value get to the maximum point.")
        }
        else if current > LightBulb.maxCurrent{
        print("Current too high, falling back to previous setting.")
        current = oldCurrent
        }

        print("The current is \(current)")
        }
    }
}
```
###类型属性type property
值类型可以有存储类型属性和计算类型属性,值类型的关键字以static开头,存储类型属性必须有默认值,因为类型没有初始化方法
类也可以有存储类型属性和计算类型属性,可以用static,也可以用class,区别在于:class声明的类型属性(不可以是存储类型属性),子类可以覆写,但需要在前面添加override关键字

```
典型应用:
Int.max
Int.min

class Monster{

    var name = "Monster"

    //存储类型属性
    static let isTerrifying = true
    //计算类型属性
    static var sex:String{
       return "男"
    }

    //计算类型属性
    class var spookyNoise: String {
        return "Grrr"
    }
    // Class stored properties not supported in classes; did you mean 'static'?
    //不允许存储类型属性用class声明
    //   class var weight:Double = 67.0
    //存储型属性必须是有初始值的(OPtional除外)！因为不能使用init方法来赋值
    //用class不能声明一个存储型属性,否则会报错
    
    //类型方法
    class func talk(){
       print("Hello,I'm sex is\(sex)")
    }
    
    static func say(){
       print("Hello")
    }
}
//子类
class Zombie:Monster{

    //子类覆写
    override class var spookyNoise: String {
    return "xx"
    }
    //不可以覆写
    //static let isTerrifying = false
    
    override class func talk() {
        super.talk()
        print("xx")
    }
    //Cannot override static method
    //override static func say(){
    // }
}


```


