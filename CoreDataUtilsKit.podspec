Pod::Spec.new do |s|
  s.name = 'CoreDataUtilsKit'
  s.version = '1.0'
  s.license = {
    :type => 'Copyright',
    :text => <<-LICENSE
      Copyright 2012 - 2019 RGMC . All rights reserved.
      LICENSE
  }
  s.homepage = "https://github.com/rgmc95/CoreDataUtilsKit"
  s.author = "Romain Gjura & Michael Coqueret"
  s.summary = "Swift CoreData Utilities"
  s.swift_version = '5.1'
  s.source =  { :git => "https://github.com/rgmc95/CoreDataUtilsKit.git", :tag => "1.0.0" }
  s.default_subspec = 'Core'

  s.ios.deployment_target = '10.0'

  s.subspec 'Core' do |core|
    core.dependency "UtilsKit", '~> 2.0'
    core.source_files = 'CoreDataUtilsKit/**/*.{h,m,swift}'
  end

end

