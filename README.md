# flutterPlugin
创建flutter的plugin，并使用pigeon生成接口

## Android
使用Android Studio创建一个flutter plugin后，直接可以运行。
但是想编辑下./android中的文件时，发现不能够自动完成的提示，也不能自动添加引入。
此时代码按正常 编写后，项目还是可以正常的执行，也可以正确执行新添加的代码。
### 问题
android文件夹，使用AS打开后，不能正常的编写代码。
### 解决方法
打开./example/android文件夹，这里的项目是一个完整的android项目，可以正常的编写代码。
同时也打开./文件夹，可以进行flutter的代码编写。

## iOS
打开./example/iOS的工程，执行一下pod install。
如果没有Podfile文件，那么在根目录下 执行一下： flutter create .
搜索FlutterPluginWynPlugin进行功能的编写, 此文件就是./iOS/Classes下的文件，是iOS端的功能实现。

## Pigeon
创建好messages.dart后执行   dart run pigeon --input pigeons/messages.dart
来生成iOS和Android的代码。



