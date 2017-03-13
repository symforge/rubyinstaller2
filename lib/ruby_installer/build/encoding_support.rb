module RubyInstaller
module Build # Use for: Build, Runtime
module EncodingSupport
  class WinApiError < RuntimeError
  end

  KERNEL32 = Fiddle.dlopen('kernel32.dll')
  SetConsoleOutputCP = Fiddle::Function.new(
    KERNEL32['SetConsoleOutputCP'], [Fiddle::TYPE_INT], Fiddle::TYPE_INT
  )
  SetConsoleCP = Fiddle::Function.new(
    KERNEL32['SetConsoleCP'], [Fiddle::TYPE_INT], Fiddle::TYPE_INT
  )
  GetConsoleOutputCP = Fiddle::Function.new(
    KERNEL32['GetConsoleOutputCP'], [], Fiddle::TYPE_INT
  )
  GetConsoleCP = Fiddle::Function.new(
    KERNEL32['GetConsoleCP'], [], Fiddle::TYPE_INT
  )

  def self.set_console_output_cp(cp=65001)
    raise WinApiError, "SetConsoleOutputCP failed" if SetConsoleOutputCP.call(cp)==0
  end

  def self.set_console_cp(cp=65001)
    raise WinApiError, "SetConsoleCP failed" if SetConsoleCP.call(cp)==0
  end

  def self.get_console_output_cp
    GetConsoleOutputCP.call
  end

  def self.get_console_cp
    GetConsoleCP.call
  end
end
end
end
