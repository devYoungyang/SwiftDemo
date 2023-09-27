# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'

target 'SwiftDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SwiftDemo
pod 'SwifterSwift'   # 扩展
pod 'SwiftyJSON'    # json转model
pod 'Alamofire'     #网络请求
#pod 'Spring', :git => 'https://github.com/MengTo/Spring.git'  # 动画
pod 'RxSwift'    # rx系列
pod 'RxCocoa'   # rx系列
pod 'SwiftLint'   #静态检测
pod 'Kingfisher'    #加载网络图片
pod 'Moya'    #Alamofire的封装
pod 'HandyJSON'     # json转model
pod 'YYKit'
pod 'SnapKit'   #布局
pod 'SDAutoLayout'
pod 'ESTabBarController-swift'    # 标签栏控制器
pod 'Moya/RxSwift'
pod 'RxDataSources'   # tableview，collectionview的封装
pod 'RxViewController'    # 封装生命周期
pod 'RxSwiftExt'
pod 'Toast-Swift', '~> 5.0.1'   # 吐司
pod 'Hero'    # 转场动画
pod 'ObjectMapper'  # json解析
pod 'RxTheme'     # 主题
pod 'ReactorKit'  #  响应式状态管理
pod 'Then'    #   链式语法
pod 'NSObject+Rx'
pod 'MJRefresh'
pod 'DZNEmptyDataSet'
pod 'EmptyDataSet-Swift', '~> 5.0.0'
pod 'ReachabilitySwift'   #   网络检测
pod 'JXSegmentedView'   #
pod 'JXPagingView/Paging'
pod 'BonMot'    # 富文本
pod 'AttributedString'
pod 'FSPagerView'  # 轮播图
pod 'Starscream', '~> 4.0.0'
pod 'Tiercel'   # 下载
pod 'CryptoSwift', '~> 1.4.0'   # 加密
#pod 'Charts'   #  画图
pod 'PKHUD', '~> 5.0'
pod 'CollectionKit'
pod 'RSKPlaceholderTextView'
pod 'ZLPhotoBrowser'
pod 'GKNavigationBarSwift'
#pod 'RxWebKit'
pod 'SwiftDate'
pod 'JKSwiftExtension'
pod 'TweeTextField'
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end

