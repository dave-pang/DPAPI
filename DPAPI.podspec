#
# Be sure to run `pod lib lint DPAPI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'DPAPI'
    s.version          = '0.9.7'
    s.summary          = 'An Alamofire wrapper for easy API creation.'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    API is a wrapper for the Alamofire framework. API allows for easy API creation within one's app, so that time when can be saved.
    DESC
    
    s.homepage         = 'https://github.com/dave-pang/DPAPI'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'dave.pang' => 'yainoma00@gmail.com' }
    s.source           = { :git => 'https://github.com/dave-pang/DPAPI.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.source_files = 'Pod/Classes/**/*'
    
    s.ios.deployment_target = '10.0'
#    s.swift_version = '4.2'

    #s.resource_bundles = {
    #    'DPAPI' => ['DPAPI/Assets/*.png']
    #}
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'RxSwift'
#    s.dependency 'RxCocoa'
    s.dependency 'Alamofire'
end
