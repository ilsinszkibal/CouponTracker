xcodeproj 'Coupon.xcodeproj'
platform :ios, '7.0'

# ignore all warnings from all pods
inhibit_all_warnings!

workspace "CouponTracker"
xcodeproj "CouponTracker/CouponTracker"

target :"CouponUtils" do
    #Networking
    pod 'RestKit', "~> 0.23.3"
    pod 'Reachability', "~> 3.1.1"

    #Cache
    pod 'SDWebImage', "~> 3.7.1"
    pod 'SDWebImage-ProgressView', "~> 0.4.0"
    pod 'UIActivityIndicator-for-SDWebImage', "~> 1.2"

    #Logging
    pod 'CocoaLumberjack', "~> 1.9"

    #Social service SDKs
    pod 'AFOAuth2Client', "~> 0.1.2"

    #QR
    pod 'iOS-QR-Code-Encoder', "~> 0.0.1"

    xcodeproj "CouponTracker/CouponTracker/Projects/CouponServices/CouponAnalytics/CouponData/CouponUtils/CouponUtils"
end