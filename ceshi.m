com.hlgam.block.puzzle
applinks:www.ydmob.com

//抓包自动URL配置
https://chls.pro/XXXX:XXXX.pac

APP 地址
/Users/lurich/Library/Group Containers/K36BKF7T3D.group.com.apple.configurator/Library/Caches/Assets/TemporaryItems/MobileApps

模拟器应用地址
/Users/lurich/Library/Developer/CoreSimulator/Devices/91CB8304-8B47-4B3D-B922-FA2301A6AC1F/data/Containers/Data/Application

//描述文件所在路径
~/Library/MobileDevice/Provisioning Profiles

安装APP提示磁盘损坏处理
sudo spctl --master-disable
sudo xattr -rd com.apple.quarantine /Applications/XXX.app

删除lib中的"arm64"
lipo -remove "arm64" YXLaunchAds.framework/YXLaunchAds -output YXLaunchAds.framework/YXLaunchAds

lipo -info libGDTMobSDK.a
例如 输出结果：
Architectures in the fat file: libGDTMobSDK.a are: i386 armv7 armv7s x86_64 arm64

cd到指定目录，运行一下代码检测是否包含idfa：
grep -r advertisingIdentifier .

获取所有APP的bundleID
终端安装       ：brew install --HEAD libimobiledevice
获取bundleID  ：ideviceinstaller -l

ios 描述文件位置
/Users/lurich/Library/MobileDevice/Provisioning Profiles

//开启隐藏文件
defaults write com.apple.finder AppleShowAllFiles -bool true
killall Finder
//关闭隐藏文件
defaults write com.apple.finder AppleShowAllFiles -bool false
killall Finder

mkdir armv7
lipo libx.a -thin armv7 -output armv7/libgt-armv7.a
cd armv7
ar xv libgt-armv7.a
rm Pods-GDTMobSDK-dummy.o
rm libgt-armv7.a
ar crv libgt-armv7.a *.o
cd ..

mkdir armv7s
lipo libx.a -thin armv7s -output armv7s/libgt-armv7s.a
cd armv7s
ar xv libgt-armv7s.a
rm Pods-GDTMobSDK-dummy.o
rm libgt-armv7s.a
ar crv libgt-armv7s.a *.o
cd ..

mkdir arm64
lipo libx.a -thin arm64 -output arm64/libgt-arm64.a
cd arm64
ar xv libgt-arm64.a
rm Pods-GDTMobSDK-dummy.o
rm libgt-arm64.a
ar crv libgt-arm64.a *.o
cd ..

mkdir i386
lipo libx.a -thin i386 -output i386/libgt-i386.a
cd i386
ar xv libgt-i386.a
rm Pods-GDTMobSDK-dummy.o
rm libgt-i386.a
ar crv libgt-i386.a *.o
cd ..

mkdir x86_64
lipo libx.a -thin x86_64 -output x86_64/libgt-x86_64.a
cd x86_64
ar xv libgt-x86_64.a
rm Pods-GDTMobSDK-dummy.o
rm libgt-x86_64.a
ar crv libgt-x86_64.a *.o
cd ..

mkdir new
mv armv7/libgt-armv7.a new/
mv armv7s/libgt-armv7s.a new/
mv arm64/libgt-arm64.a new/
mv i386/libgt-i386.a new/
mv x86_64/libgt-x86_64.a new/
cd new
lipo -create /Users/lurich/Downloads/ceshi/new/new/libgt-x86_64.a /Users/lurich/Downloads/ceshi/new/new/libgt-arm64.a /Users/lurich/Downloads/ceshi/new/new/libgt-armv7.a /Users/lurich/Downloads/ceshi/new/new/libgt-armv7s.a /Users/lurich/Downloads/ceshi/new/new/libgt-i386.a -output libGDTMobSDK.a


lipo -thin arm64 /Users/lurich/Downloads/ceshi/libGDTMobSDK.a -output /Users/lurich/Desktop/libGDTMobSDK_arm64
nm -A /Users/lurich/Desktop/libGDTMobSDK_arm64 Pods-GDTMobSDK-dummy.o


mkdir x86_64
lipo libx.a -thin x86_64 -output x86_64/libgt-x86_64.a
mkdir i386
lipo libx.a -thin i386 -output i386/libgt-i386.a
mkdir armv7s
lipo libx.a -thin armv7s -output armv7s/libgt-armv7s.a
mkdir armv7
lipo libx.a -thin armv7 -output armv7/libgt-armv7.a
mkdir arm64
lipo libx.a -thin arm64 -output arm64/libgt-arm64.a
cd arm64
ar xv libgt-arm64.a

国庆年号和国徽     致敬方阵

一 建国创业
开天辟地   浴血奋战   建国伟业   当家做主    艰苦奋斗

情景式行进   青春万岁

二 改革开放
关键抉择   希望天野    春潮滚滚   与时俱进  一国两制    跨越世纪    科学发展    众志成城   圆梦奥运

情景式行进  东方雄狮

三 伟大复兴
创新驱动    区域协调   乡村振兴    民主法治   民族团结   凝心铸魂    中华文化    立德树人   体育强国     脱贫攻坚   美好生活   绿水青山   中华儿女


#import <AppTrackingTransparency/AppTrackingTransparency.h>
//获取idfa
+(NSString *)getIDFABeiyong{
    if (@available(iOS 14, *)) {
        ATTrackingManagerAuthorizationStatus status = ATTrackingManager.trackingAuthorizationStatus;
        switch (status) {
            case ATTrackingManagerAuthorizationStatusDenied:
//                NSLog(@"用户拒绝");
                return @"";
                break;
            case ATTrackingManagerAuthorizationStatusAuthorized:
            {
//                    NSLog(@"用户允许");
                    NSUUID *UUID = [[ASIdentifierManager sharedManager] advertisingIdentifier];
                    NSString *adId = [NSString stringWithFormat:@"%@",UUID.UUIDString];
                    return adId;
            }
                break;
            case ATTrackingManagerAuthorizationStatusNotDetermined:
            {
//                NSLog(@"用户为做选择或未弹窗");
                [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
//                    NSLog(@"app追踪权限：%lu",(unsigned long)status);
                }];
                NSUUID *UUID = [[ASIdentifierManager sharedManager] advertisingIdentifier];
                NSString *adId = [NSString stringWithFormat:@"%@",UUID.UUIDString];
                return adId;
            }
                break;
            default:
                return @"";
                break;
        }
    } else {
        // Fallback on earlier versions
        NSUUID *UUID = [[ASIdentifierManager sharedManager] advertisingIdentifier];
        NSString *adId = [NSString stringWithFormat:@"%@",UUID.UUIDString];
        return adId;
    }
}
