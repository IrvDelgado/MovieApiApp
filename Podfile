# Uncomment the next line to define a global platform for your project
workspace 'TheMovieDb'

def rx
  pod 'RxSwift', '~> 5.0'
  pod 'RxCocoa', '~> 5.0'
end

use_frameworks!

# Pods for TheMovieDb
target 'TheMovieDb' do
  rx
  pod 'SwiftLint'

  target 'TheMovieDbTests' do
    inherit! :search_paths
  end

  target 'TheMovieDbUITests' do
    # Pods for testing
  end

end

# Pods for NetworkLayer
target 'NetworkLayer' do
  use_frameworks!
  project 'Core/NetworkLayer/NetworkLayer'
  pod 'RxSwift', '~> 5.0'
  pod 'RxCocoa', '~> 5.0'
  pod 'SwiftLint'

  target 'NetworkLayerTests' do
    pod 'RxBlocking', '~> 5.0'
    inherit! :search_paths
  end

end

