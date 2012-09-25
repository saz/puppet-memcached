module Puppet::Parser::Functions
  newfunction(:memcached_max_memory, :type => :rvalue, :doc => <<-EOS
    Calculate max_memory size from fact 'memsize' and passed argument.
    EOS
  ) do |arguments|

    raise(Puppet::ParseError, "memcached_max_memory(): " +
          "Wrong number of arguments given " +
          "(#{arguments.size} for 1)") if arguments.size != 1

    arg = arguments[0]
    memsize = lookupvar('memorysize')

    if arg and !arg.to_s.end_with?('%')
      result_in_mb = arg.to_i
    else
      max_memory_percent = arg ? arg : '95%'
      Puppet::Parser::Functions.function('to_bytes')
      result_in_mb = ( (function_to_bytes([memsize]) / (1 << 20) ) * (max_memory_percent.to_f / 100.0) ).floor
    end

    return result_in_mb
  end
end
