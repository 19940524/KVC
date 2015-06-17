//
//  ViewController.m
//  KVC
//
//  Created by 广东省陆丰市湖东镇薛国宾 on 15/6/11.
//  Copyright (c) 2015年 深圳法爱工程技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "PersonMonitor.h"
#import "MyPerson.h"
@interface ViewController ()

@property (nonatomic, retain) MyPerson *testPerson;

@end

@implementation ViewController
@synthesize testPerson;


/*------------------------------------- KVC（一）---------------------------------------------*/
/*
 KVC，即是指 NSKeyValueCoding，一个非正式的 Protocol，提供一种机制来间接访问对象的属性。KVO 就是基于 KVC 实现的关键技术之一。
 
 一个对象拥有某些属性。比如说，一个 Person 对象有一个 name 和一个 address 属性。以 KVC 说法，Person 对象分别有一个 value 对应他的 name 和 address 的 key。 key 只是一个字符串，它对应的值可以是任意类型的对象。从最基础的层次上看，KVC 有两个方法：一个是设置 key 的值，另一个是获取 key 的值。如下面的例子：
 */

void changeName(Person *p, NSString *newName)
{
    
    // using the KVC accessor (getter) method
    NSString *originalName = [p valueForKey:@"name"];
    
    // using the KVC  accessor (setter) method.
    [p setValue:newName forKey:@"name"];
    
    NSLog(@"Changed %@'s name to: %@", originalName, newName);
    
}
// 现在，如果 Person 有另外一个 key 配偶（spouse），spouse 的 key 值是另一个 Person 对象，用 KVC 可以这样写：
void logMarriage(Person *p)
{
    
    // just using the accessor again, same as example above
    NSString *personsName = [p valueForKey:@"name"];
    
    // this line is different, because it is using
    // a "key path" instead of a normal "key"
    NSString *spousesName = [p valueForKeyPath:@"spouse.name"];
    
    NSLog(@"%@ is happily married to %@", personsName, spousesName);
    
}

/*
 key 与 key pat 要区分开来，key 可以从一个对象中获取值，而 key path 可以将多个 key 用点号 “.” 分割连接起来，比如：
 
 [p valueForKeyPath:@"spouse.name"];
 相当于这样……
 
 [[p valueForKey:@"spouse"] valueForKey:@"name"];
 */

#warning mark - KVC 二 浅入
/*------------------------------------- KVC（二）---------------------------------------------*/
/*
 一，概述
 KVC是KeyValueCoding的简称，它是一种可以直接通过字符串的名字(key)来访问类属性的机制。而不是通过调用Setter、Getter方法访问。
 
  当使用KVO、Core Data、CocoaBindings、AppleScript(Mac支持)时，KVC是关键技术。
 
 二，使用方法
 关键方法定义在：NSKeyValueCodingprotocol
 
 KVC支持类对象和内建基本数据类型。
 
 获取值
 
 valueForKey:，传入NSString属性的名字。
 
 valueForKeyPath:，传入NSString属性的路径，xx.xx形式。
 
 valueForUndefinedKey它的默认实现是抛出异常，可以重写这个函数做错误处理。
 
 修改值
 
 setValue:forKey:
 
 setValue:forKeyPath:
 
 setValue:forUndefinedKey:
 
 setNilValueForKey:当对非类对象属性设置nil时，调用，默认抛出异常。
 
 一对多关系成员的情况
 
 mutableArrayValueForKey：有序一对多关系成员  NSArray
 
 mutableSetValueForKey：无序一对多关系成员  NSSet
 
 三，实例:
 
 四，小结
 KVO/KVC这种编码方式使用起来很简单，很适用与datamodel修改后，引发的UIVIew的变化这种情况，就像上边的例子那样，当更改属性的值后，监听对象会立即得到通知。
 */

#warning mark - KVC 三 皮毛
/*------------------------------------- KVC（三）---------------------------------------------*/
/*
 一个类的成员变量如果没有提供getter／setter的话，外界就失去了对这个变量的访问渠道。而KVC则提供了一种访问的方法，这个方法可以不通过getter／setter方法来访问对象的属性。
 实例:
 */

#warning mark - KVC 四 精华
/*------------------------------------- KVC（四）---------------------------------------------*/
/*
 KVC
 1 、概述
 KVC是KeyValue Coding的简称，它是一种可以直接通过字符串的名字(key)来访问类属性的机制。而不是通过调用Setter、Getter方法访问。
 当使用KVO、Core Data、CocoaBindings、AppleScript(Mac支持)时，KVC是关键技术。
 2、如何使用KVC
 关键方法定义在：NSKeyValueCodingprotocol
 KVC支持类对象和内建基本数据类型。
 获取值
 valueForKey:，传入NSString属性的名字。
 valueForKeyPath:，传入NSString属性的路径，xx.xx形式。
 valueForUndefinedKey它的默认实现是抛出异常，可以重写这个函数做错误处理。
 修改值
 setValue:forKey:
 setValue:forKeyPath:
 setValue:forUndefinedKey:
 setNilValueForKey: 当对非类对象属性设置nil时，调用，默认抛出异常。
 一对多关系成员的情况
 mutableArrayValueForKey：有序一对多关系成员  NSArray
 mutableSetValueForKey：无序一对多关系成员  NSSet
 3、KVC的实现细节
 搜索Setter、Getter方法
 　这一部分比较重要，能让你了解到KVC调用之后，到底是怎样获取和设置类成员值的。
 搜索简单的成员
 如：基本类型成员，单个对象类型成员：NSInteger，NSString*成员。
 a. setValue:forKey的搜索方式：
 首先搜索set:方法
 如果成员用@property，@synthsize处理，因为@synthsize告诉编译器自动生成set:格式的setter方法，所以这种情况下会直接搜索到。
 注意：这里的是指成员名，而且首字母大写。下同。
 上面的setter方法没有找到，如果类方法accessInstanceVariablesDirectly返回YES(注：这是NSKeyValueCodingCatogery中实现的类方法，默认实现为返回YES)。
 那么按_，_is，，is的顺序搜索成员名。
 如果找到设置成员的值，如果没有调用setValue:forUndefinedKey:。
 b. valueForKey:的搜索方式：
 1. 首先按get、、is的顺序查找getter方法，找到直接调用。如果是bool、int等内建值类型，会做NSNumber的转换。
 2. 上面的getter没有找到，查找countOf、objectInAtIndex:、AtIndexes格式的方法。
 如果countOf和另外两个方法中的一个找到，那么就会返回一个可以响应NSArray所有方法的代理集合(collection proxy object)。发送给这个代理集合(collection proxy object)的NSArray消息方法，就会以countOf、objectInAtIndex:、AtIndexes这几个方法组合的形式调用。还有一个可选的get:range:方法。
 3. 还没查到，那么查找countOf、enumeratorOf、memberOf:格式的方法。
 如果这三个方法都找到，那么就返回一个可以响应NSSet所有方法的代理集合(collection proxy object)。发送给这个代理集合(collection proxy object)的NSSet消息方法，就会以countOf、enumeratorOf、memberOf:组合的形式调用。
 4. 还是没查到，那么如果类方法accessInstanceVariablesDirectly返回YES，那么按_，_is，，is的顺序直接搜索成员名。
 5. 再没查到，调用valueForUndefinedKey:。
 查找有序集合成员，比如NSMutableArray
 mutableArrayValueForKey:搜索方式如下：
 1. 搜索insertObject:inAtIndex:、removeObjectFromAtIndex:或者insert:atIndexes、removeAtIndexes:格式的方法。
 如果至少一个insert方法和至少一个remove方法找到，那么同样返回一个可以响应NSMutableArray所有方法的代理集合。那么发送给这个代理集合的NSMutableArray消息方法，以insertObject:inAtIndex:、removeObjectFromAtIndex:、insert:atIndexes、removeAtIndexes:组合的形式调用。还有两个可选实现的接口：replaceObjectInAtIndex:withObject:、replaceAtIndexes:with:。
 2. 否则，搜索set:格式的方法，如果找到，那么发送给代理集合的NSMutableArray最终都会调用set:方法。
 也就是说，mutableArrayValueForKey取出的代理集合修改后，用set:重新赋值回去。这样做效率会差很多，所以推荐实现上面的方法。
 3. 否则，那么如果类方法accessInstanceVariablesDirectly返回YES，那么按_，的顺序直接搜索成员名。如果找到，那么发送的NSMutableArray消息方法直接转交给这个成员处理。
 4. 再找不到，调用setValue:forUndefinedKey:。
 搜索无序集合成员，如：NSSet。
 mutableSetValueForKey:搜索方式如下：
 1. 搜索addObject:、removeObject:或者add:、remove:格式的方法，如果至少一个insert方法和至少一个remove方法找到，那么返回一个可以响应NSMutableSet所有方法的代理集合。那么发送给这个代理集合的NSMutableSet消息方法，以addObject:、removeObject:、add:、remove:组合的形式调用。还有两个可选实现的接口：intersect、set:。
 2. 如果reciever是ManagedObejct，那么就不会继续搜索了。
 3. 否则，搜索set:格式的方法，如果找到，那么发送给代理集合的NSMutableSet最终都会调用set:方法。也就是说，mutableSetValueForKey取出的代理集合修改后，用set:重新赋值回去。这样做效率会差很多，所以推荐实现上面的方法。
 4. 否则，那么如果类方法accessInstanceVariablesDirectly返回YES，那么按_，的顺序直接搜索成员名。如果找到，那么发送的NSMutableSet消息方法直接转交给这个成员处理。
 5. 再找不到，调用setValue:forUndefinedKey:。
 KVC还提供了下面的功能
 
 值的正确性核查
 
 KVC提供属性值确认的API，它可以用来检查set的值是否正确、为不正确的值做一个替换值或者拒绝设置新值并返回错误原因。
 
 实现核查方法
 
 为如下格式：validate:error:
 
 如：
 
 -(BOOL)validateName:(id *)ioValue error:(NSError **)outError
 
 {
 
 // The name must not be nil, and must be at least two characters long.
 
    if ((*ioValue == nil) || ([(NSString *)*ioValue length] < 2]) {
 
        if (outError != NULL) {
 
             NSString *errorString = NSLocalizedStringFromTable(
             
             @"A Person's name must be at least two characters long", @"Person",
             
             @"validation: too short name error");
             
             NSDictionary *userInfoDict = [NSDictionary dictionaryWithObject:errorString forKey:NSLocalizedDescriptionKey];
 
             *outError = [[[NSError alloc] initWithDomain:PERSON_ERROR_DOMAIN
             
             code:PERSON_INVALID_NAME_CODE
             
             userInfo:userInfoDict] autorelease];
 
        }
    return NO;
    }
 return YES;
 }
 
 调用核查方法：
 
 validateValue:forKey:error:，默认实现会搜索 validate:error:格式的核查方法，找到则调用，未找到默认返回YES。
 
 注意其中的内存管理问题。
 
 集合操作
 
 集合操作通过对valueForKeyPath:传递参数来使用，一定要用在集合(如：array)上，否则产生运行时刻错误。其格式如下：
 
 Left keypath部分：需要操作对象路径。
 
 Collectionoperator部分：通过@符号确定使用的集合操作。
 
 Rightkey path部分：需要进行集合操作的属性。
 
 1、数据操作
 
 @avg：平均值
 
 @count：总数
 
 @max：最大
 
 @min：最小
 
 @sum：总数
 
 确保操作的属性为数字类型，否则运行时刻错误。
 
 2、对象操作
 
 针对数组的情况
 
 @distinctUnionOfObjects：返回指定属性去重后的值的数组
 
 @unionOfObjects：返回指定属性的值的数组，不去重
 
 属性的值不能为空，否则产生异常。
 
 3、数组操作
 
 针对数组的数组情况
 
 @distinctUnionOfArrays：返回指定属性去重后的值的数组
 
 @unionOfArrays：返回指定属性的值的数组，不去重
 
 @distinctUnionOfSets：同上，只是返回值为NSSet
 
 示例代码：
 
 效率问题
 
 相比直接访问KVC的效率会稍低一点，所以只有当你非常需要它提供的可扩展性时才使用它。
 
 小结
 
 Kvo是Cocoa的一个重要机制，他提供了观察某一属性变化的方法，极大的简化了代码。这种观察－被观察模型适用于这样的情况，比方说根据A（数 据类）的某个属性值变化，B（view类）中的某个属性做出相应变化。对于推崇MVC的cocoa而言，kvo应用的地方非常广泛。（这样的机制听起来类似Notification，但是notification是需要一个发送notification的对象，一般是 notificationCenter，来通知观察者。而kvo是直接通知到观察对象。）
 
 适用kvo时，通常遵循如下流程：
 1、注册：
 
 -(void)addObserver:(NSObject *)anObserver forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void*)context
 
 keyPath就是要观察的属性值，options给你观察键值变化的选择，而context方便传输你需要的数据（注意这是一个void型）
 
 2、实现变化方法：
 
 -(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
 change:(NSDictionary *)change context:(void*)context
 
 change里存储了一些变化的数据，比如变化前的数据，变化后的数据；如果注册时context不为空，这里context就能接收到。
 
 是不是很简单？kvo的逻辑非常清晰，实现步骤简单。
 
 说了这么多，大家都要跃跃欲试了吧。可是，在此之前，我们还需要了解KVC机制。其实，知道了kvo的逻辑只是帮助你理解而已，要真正掌握的，不在于kvo的实现步骤是什么，而在于KVC，因为只有符合KVC标准的对象才能使用kvo（强烈推荐要使用kvo的人先理解KVC）。
 
 KVC是一种间接访问对象属性（用字符串表征）的机制，而不是直接调用对象的accessor方法或是直接访问成员对象。
 
 key就是确定对象某个值的字符串，它通常和accessor方法或是变量同名，并且必须以小写字母开头。Key path就是以“.”分隔的key，因为属性值也能包含属性。比如我们可以person这样的key，也可以有key.gender这样的key path。
 
 获取属性值时可以通过valueForKey:的方法，设置属性值用setValue:forKey:。与此同时，KVC还对未定义的属性值定义了 valueForUndefinedKey:，你可以重载以获取你要的实现（补充下，KVC定义载NSKeyValueCoding的非正式协议里）。
 
 在O-C 2.0引入了property，我们也可以通过.运算符来访问属性。下面直接看个例子：
 
 @property NSInteger number;
 
 instance.number =3;
 [instance setValue:[NSNumber numberWithInteger:3] forKey:@"number"];
 
 注意KVC中的value都必须是对象。
 
 以上介绍了通过KVC来获取／设置属性，接下来要说明下实现KVC的访问器方法（accessor method）。Apple给出的惯例通常是：
 
 －key：，以及setKey：（使用的name convention和setter／getter命名一致）。对于未定义的属性可以用setNilValueForKey:。
 
 至此，KVC的基本概念你应该已经掌握了。之所以是基本，因为只涉及到了单值情况，kvc还可以运用到对多关系，这里就不说了，留给各位自我学习的空间
 
 接下来，我们要以集合为例，来对掌握的KVC进行一下实践。
 
 之所以选择array，因为在ios中，array往往做为tableview的数据源，有这样的一种情况：
 
 假设我们已经有N条数据，在进行了某个操作后，有在原先的数据后多了2条记录；或者对N中的某些数据进行更新替换。不使用KVC我们可以使用 reloadData方法或reloadRowsAtIndexPaths。前一种的弊端在于如果N很大消耗就很大。试想你只添加了几条数据却要重载之前 N数据。后一种方法的不足在于代码会很冗余，你要一次计算各个indexPath再去reload，而且还要提前想好究竟在哪些情况下会引起数据更新，
 
 倘若使用了KVC/kvo，这样的麻烦就迎刃而解了，你将不用关心追加或是更新多少条数据。
 
 下面将以添加数据为例，说明需要实现的方法：
 
 实现insertObject:inKeyAtIndex:或者insertKey:atIndexes。同时在kvo中我们可以通过change这个dictionary得知发生了哪种变化，从而进行相应的处理。
 
 KVC 就是一种通过字符串去间接操作对象属性的机制，
 
 访问一个对象属性我们可以 person.age  也可以通过KVC的方式   [person valueForKey:@"age"]
 
 keypath 就是属性链式访问  如 person.address.street  有点象java里面的pojo  ognl表达式子类的
 
 假如给出的字符串没有对象的属性 会访问valueForUndefineKey方法 默认实现是raise 一个异常但你可以重写这个方法, setValue的时候也是一样的道理
 
 key path accounts.transactions.payee would return an array with all the payee objects, for all the transactions, in all the accounts.
 
 当设置一个非对象属性为nil时会抛异常， 但你也可以重写方法
 
 KVC就是一个在语言框架层面实现的观察者模式 通过KVC的方式修改属性时，会主动通知观察者
 */
#pragma 当遇到property的时候，可以多想想是否可以KVC来帮助我，是否可以用KVC来重构代码， 当需要加入observer模式时，可以考虑下KVO, 在高性能的observer里面，KVO会给我们很好的帮助。
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*------------------------------------- KVC（二）---------------------------------------------*/
    //初始化被监视对象
    Person *p = [[Person alloc] init];
    
    //监视对象
    PersonMonitor *pm = [[PersonMonitor alloc] init];
    [p addObserver:pm forKeyPath:@"name" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    
    //测试前的数据
    NSLog(@"p.name is %@",p.name);
    
    //通过setvalue 的方法，PersonMonitor的监视将被调用
    [p setValue:@"通过setvalue设置name的值" forKey:@"name"];
    
    //查看设置后的值
    NSLog(@"p name 查看设置后的值 is %@",[p valueForKey:@"name"]);
    
    //效果和通过setValue 是一致的
    p.name = @"通过p.nema直接改变name的值";
    
    
    //通过person自己的函数来更改name    ps:不知道什么原因 调不了了
    [p changeNamed];

#warning 注意记得删除监视对象
    [p removeObserver:pm forKeyPath:@"name"];
    
    /*------------------------------------- KVC（三）---------------------------------------------*/
    testPerson = [[MyPerson alloc] init];
    
    NSLog(@"testPerson's init height = %@", [testPerson valueForKey:@"height"]);
    [testPerson setValue:[NSNumber numberWithInt:168] forKey:@"height"];
        NSLog(@"testPerson's height = %@", [testPerson valueForKey:@"height"]);
//    [testPerson test];
    /*
     第一段代码是定义了一个myPerson的类，这个类有一个_height的属性，但是没有提供任何getter／setter的访问方法。同时在ViewController这个类里面有一个myPerson的对象指针。
     当myPerson实例化后，常规来说是无法访问这个对象的_height属性的，不过通过KVC我们做到了，代码就是testKVC这个函数。
     
     运行之后打印值就是：
     
     2013-11-02 11:16:21.970 test[408:c07] testPerson's init height = 0
     2013-11-02 11:16:21.971 test[408:c07] testPerson's height = 168
     这就说明确实读写了_height属性。
     */
    /*
     KVC的常用方法：
     - (id)valueForKey:(NSString *)key;
     - (void)setValue:(id)value forKey:(NSString *)key;
     
     valueForKey的方法根据key的值读取对象的属性，setValue:forKey:是根据key的值来写对象的属性。
     这里有几个要强调一下
     1. key的值必须正确，如果拼写错误，会出现异常
     2. 当key的值是没有定义的，valueForUndefinedKey:这个方法会被调用，如果你自己写了这个方法，key的值出错就会调用到这里来
     3. 因为类key反复嵌套，所以有个keyPath的概念，keyPath就是用.号来把一个一个key链接起来，这样就可以根据这个路径访问下去
     4. NSArray／NSSet等都支持KVC
     */
    
    
}




@end
