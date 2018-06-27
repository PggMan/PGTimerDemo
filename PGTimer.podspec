Pod::Spec.new do |s|
s.name         = "PGTimer"
s.version      = "0.0.1"
s.ios.deployment_target = '6.0'
s.osx.deployment_target = '10.8'
s.summary      = "GCD Timer"
s.homepage     = "https://github.com/PggMan/PGTimerDemo"
s.license      = "MIT"
s.author             = { "PggMan" => "pg890101@gmail.com" }
s.source       = { :git => "https://github.com/PggMan/PGTimerDemo.git", :tag => s.version }
s.source_files  = 'PGTimerDemo/PGTimer/*.{h,m}'
s.requires_arc = true
end
