Pod::Spec.new do |s|

s.name             = "PromisePayOne"

s.version          = "0.1.0"

s.summary          = "PromisePay iOS SDK"

s.description      = <<-DESC

                        The implementation of PromisePay Client SDK

                        DESC



s.homepage         = "https://github.com/KevinHakans/PromisePay-iOS"

s.license          = 'MIT'

s.author           = { "KevinHakans" => "kevin.hakans.it@gmail.com" }

s.source           = { :git => "https://github.com/KevinHakans/PromisePay-iOS.git", :tag => "v0.1.0" }



s.platform     = :ios, '7.0'

s.requires_arc = true



s.source_files = 'Pod/Classes/**/*'

s.resource_bundles = {

'PromisePay' => ['Pod/Assets/*.png']

}



s.frameworks = 'Foundation'

end

