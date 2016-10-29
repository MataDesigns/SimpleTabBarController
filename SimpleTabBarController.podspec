#
# Be sure to run `pod lib lint SimpleTabBarController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SimpleTabBarController'
  s.version          = '0.1.0'
  s.summary          = 'Finally you can customize the tabbar and its items easily.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
SimpleBarController is a Swift module to allow more customization of tabbar items, tabbar animations, and it's inherited from UITabBarController.
                       DESC

  s.homepage         = 'https://github.com/NicholasMata/SimpleTabBarController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Nicholas Mata' => 'NicholasMata94@gmail.com' }
  s.source           = { :git => 'https://github.com/NicholasMata/SimpleTabBarController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'SimpleTabBarController/Classes/**/*'
  
  s.resource_bundles = {
    'SimpleTabBarController' => ['SimpleTabBarController/Assets/**/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
end
