Pod::Spec.new do |s|

  s.name         = "ToastSimple"
  s.version      = "0.1.0"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.summary      = "ToastSimple written in Swift"
  s.homepage     = "https://github.com/comodinx/ToastSimple"
  s.screenshots  = "https://raw.githubusercontent.com/comodinx/ToastSimple/master/Screenshots/DemoExample.gif"
  s.authors      = { "Nicolas Molina" => "comodinx@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/comodinx/ToastSimple.git", :tag => s.version }

  s.source_files = "Sources/*.swift"

end
