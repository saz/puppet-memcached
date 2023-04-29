# frozen_string_literal: true

# Calculate max_memory size from fact 'memsize' and passed argument.
Puppet::Functions.create_function(:'memcached::max_memory') do
  dispatch :max_memory do
    required_param 'Any', :arg
  end

  def max_memory(arg)
    scope = closure_scope
    memsize = if scope['facts']['memory'].nil?
                scope['facts']['memorysize']
              else
                scope['facts']['memory']['system']['total']
              end

    if arg && !arg.to_s.end_with?('%')
      result_in_mb = arg.to_i
    else
      max_memory_percent = arg || '95%'

      # Taken from puppetlabs-stdlib to_bytes() function
      value, suffix = *%r{([0-9.e+-]*)\s*([^bB]?)}.match(memsize)[1, 2]

      value = value.to_f
      case suffix
      when 'k' then value *= (1 << 10)
      when 'M' then value *= (1 << 20)
      when 'G' then value *= (1 << 30)
      when 'T' then value *= (1 << 40)
      when 'E' then value *= (1 << 50)
      else raise Puppet::ParseError, "memcached_max_memory(): Unknown suffix #{suffix}"
      end
      value = value.to_i
      result_in_mb = ((value / (1 << 20)) * (max_memory_percent.to_f / 100.0)).floor
    end

    result_in_mb
  end
end
