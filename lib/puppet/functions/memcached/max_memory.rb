# Calculate max_memory size from fact 'memsize' and passed argument.
Puppet::Functions.create_function(:'memcached::max_memory') do
  dispatch :max_memory do
    required_param 'Any', :arg
  end

  def max_memory(arg)
    scope = closure_scope
    memsize = scope['facts']['memorysize']

    if arg && !arg.to_s.end_with?('%')
      result_in_mb = arg.to_i
    else
      max_memory_percent = arg ? arg : '95%'

      # Taken from puppetlabs-stdlib to_bytes() function
      value, prefix = *%r{([0-9.e+-]*)\s*([^bB]?)}.match(memsize)[1, 2]

      value = value.to_f
      case prefix
      when '' then value = value
      when 'k' then value *= (1 << 10)
      when 'M' then value *= (1 << 20)
      when 'G' then value *= (1 << 30)
      when 'T' then value *= (1 << 40)
      when 'E' then value *= (1 << 50)
      else raise Puppet::ParseError, "memcached_max_memory(): Unknown prefix #{prefix}"
      end
      value = value.to_i
      result_in_mb = ((value / (1 << 20)) * (max_memory_percent.to_f / 100.0)).floor
    end

    result_in_mb
  end
end
