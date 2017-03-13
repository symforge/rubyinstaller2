module RubyInstaller
module Build
  autoload :Colors, 'ruby_installer/build/colors'
  autoload :DllDirectory, 'ruby_installer/build/dll_directory'
  autoload :EncodingSupport, 'ruby_installer/build/encoding_support'
  autoload :ErbCompiler, 'ruby_installer/build/erb_compiler'
  autoload :Gems, 'ruby_installer/build/gems'
  autoload :Msys2Installation, 'ruby_installer/build/msys2_installation'
  autoload :GEM_VERSION, 'ruby_installer/build/gem_version'
  autoload :BaseTask, 'ruby_installer/build/base_task'
  autoload :Openstruct, 'ruby_installer/build/openstruct'
  autoload :Utils, 'ruby_installer/build/utils'

  require 'ruby_installer/build/singleton'
end
end
