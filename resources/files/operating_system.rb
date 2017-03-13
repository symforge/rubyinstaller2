require "ruby_installer/runtime"

RubyInstaller::Runtime.enable_dll_search_paths

# Switch to UTF-8 for all IO
RubyInstaller::Runtime::EncodingSupport.set_console_cp
RubyInstaller::Runtime::EncodingSupport.set_console_output_cp
Encoding.default_external = Encoding::UTF_8

Gem.pre_install do |gem_installer|
  RubyInstaller::Runtime.enable_msys_apps(for_gem_install: true) unless gem_installer.spec.extensions.empty?
end
