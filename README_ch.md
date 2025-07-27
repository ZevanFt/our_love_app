# Flutter Note

## 关键字

### `Future`是什么

在 Dart 中，很多操作都不是立即完成的，比如：

1. 向服务器发送一个网络请求（需要等待服务器响应）。
2. 从手机的硬盘读取一个文件（需要等待 I/O 操作）。
3. 获取 GPS 定位（需要等待卫星信号和硬件计算）。

为了不让整个 App 在等待这些耗时操作时卡住（想象一下，在等定位时，屏幕上的按钮都点不动了），Dart 引入了 Future 这个概念。

`Future`：可以理解为一个“未来的凭证”或“承诺”。当你调用一个会返回 `Future` 的函数时，它会立即给你一个“凭证”，然后就在后台开始工作了。你的 App 可以继续做别的事情。

`async / await`：这是一对“魔法”关键字，用来处理 `Future`。

`async`：当你把它放在一个函数声明的末尾时（比如 `async { ... }`），你就在告诉 Dart：“这个函数里可能会有需要等待的操作”。

`await`：当你把它放在一个返回 `Future` 的函数调用前面时，你就在告诉 Dart：“请在这里暂停一下，一直等到这个 Future 完成，拿到它的最终结果，我们再继续往下走”。

### `Future<Position?>` 是什么意思？

让我们把它拆开看：

`Future<...>`：这是一个承诺，它承诺在未来会给你一个结果。

`Position`：这是 geolocator 库定义的一个类，代表一个“地理位置”，里面包含了经度(longitude)、纬度(latitude)等信息。

`?`：这个问号在 Dart 中表示 “可以为空” (nullable) 。

所以，`Future<Position?> `连起来的意思就是：
“我承诺，在未来会给你一个结果。这个结果要么是一个有效的` Position `对象（如果成功获取到位置），要么就是 `null`（如果因为某种原因失败了，比如用户没开GPS，或者没有权限）。”

### `geolocator`库的使用与代码逐行详解

```dart
// 在 _HomeState 类中

// 首先看函数声明
// async 关键字表示这个函数内部会执行异步操作
// Future<Position?> 是这个函数的返回值类型，我们刚刚解释过
Future<Position?> _getCurrentLocation() async { 
  
  // try-catch 语句块：这是一个非常好的编程习惯。
  // 它表示“尝试”执行 try { ... } 里面的代码。
  // 如果在执行过程中发生了任何预料之外的错误（比如插件内部崩溃），
  // 程序不会直接闪退，而是会跳转到 catch { ... } 部分去处理这个错误。
  try {

    // await: 我们要等待 Geolocator.isLocationServiceEnabled() 这个操作完成。
    // Geolocator.isLocationServiceEnabled()：这是 geolocator 库提供的方法，
    // 用来检查用户手机的系统定位服务（GPS开关）是否已经打开。
    // 它会返回一个 Future<bool>，最终结果是 true (已开启) 或 false (未开启)。
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    
    // 检查上一步获取到的结果
    if (!serviceEnabled) {
      // 如果定位服务没开，再继续往下走也没有意义。
      // 我们打印一条日志方便调试，并提前结束这个函数。
      print('定位服务未启用');
      
      // return null; 表示这个“承诺”最终的结果是 null，
      // 因为我们没能获取到位置。
      return null;
    }

    // await: 我们要等待 Geolocator.checkPermission() 这个操作完成。
    // Geolocator.checkPermission()：检查我们的 App 是否已经被用户授予了定位权限。
    // 它会返回一个 Future<LocationPermission>。
    LocationPermission permission = await Geolocator.checkPermission();
    
    // LocationPermission 是一个枚举类型，它有几个可能的值：
    // - denied: 用户拒绝过一次，但下次还可以再问。
    // - deniedForever: 用户选择了“拒绝且不再询问”，App 无法再弹出请求框了。
    // - whileInUse: 用户授权 App 在使用期间可以定位。
    // - always: 用户授权 App 随时可以定位（包括后台）。
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      
      // 如果权限是“被拒绝”或“被永久拒绝”，我们也无法获取位置。
      print('定位权限被拒绝');
      // 同样，提前结束函数，并返回 null。
      return null;
    }
    
    // 如果前面的检查都通过了（GPS已开启，权限也已授予），
    // 那么现在就可以正式获取当前位置了。
    // await: 等待 Geolocator.getCurrentPosition() 这个核心操作完成。
    // Geolocator.getCurrentPosition()：这是向系统请求当前精确位置的方法。
    // desiredAccuracy: LocationAccuracy.high 表示我们想要一个尽可能精确的位置。
    // 这个方法会返回一个 Future<Position>。
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

  } catch (e) {
    // 如果在上面 try { ... } 代码块的任何一步发生了意料之外的错误，
    // 比如手机硬件故障、网络定位服务不可用等，就会执行到这里。
    // e 是一个包含了错误信息的对象。
    print('获取位置失败: $e');
    
    // 发生错误时，同样返回 null，表示获取失败。
    return null;
  }
}
```
