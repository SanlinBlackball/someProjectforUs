# 使用时需要新建一个名为 Podfile 的文件，以如下格式，将依赖的库名字依次列在文件中即可
  # 指定平台和系统版本
  platform :ios, '8.0'

  # 表示可以使用 swift 的框架
use_frameworks!
# 表示去除第三方库的全部警告
inhibit_all_warnings!

  # 这个是 cocoapods 升级 1.0 后必须的
 #  MyApp 就是 TARGET NAME
target 'chaoKids' do

      # 指定库 和 库的版本
    pod 'AFNetworking', '~> 2.6'            #网络通信库
	pod 'NSObject-ObjectMap', '~> 2.3' #json，xml与NSObject转换
    pod 'IQKeyboardManager', '~> 3.3'   #键盘
    pod 'MBProgressHUD', '~> 1.1.0'    #HUD
      
end
