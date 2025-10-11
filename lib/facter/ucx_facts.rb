ucx_data = nil

# Check if ucx_info command exists
if Facter::Util::Resolution.which('ucx_info')
  ucx_data = Facter::Util::Resolution.exec('ucx_info -d')
end

lines = ucx_data ? ucx_data.lines : []

transports = []
devices = []
seen_transports = {}
seen_devices = {}
current_transport = nil

lines.each do |line|
  if line.match?(%r{Transport:\s+(rc\w*|uc\w*|tcp)}i)
    current_transport = line.match(%r{Transport:\s+(rc\w*|uc\w*|tcp)}i)[1]
  elsif current_transport && line.match?(%r{Device:\s+(\S+)})
    device = line.match(%r{Device:\s+(\S+)})[1]

    unless seen_transports[current_transport]
      transports << current_transport
      seen_transports[current_transport] = true
    end

    unless seen_devices[device]
      devices << device
      seen_devices[device] = true
    end

    current_transport = nil
  end
end

sorted_transports = transports.sort_by { |t| t.casecmp('tcp').zero? ? 1 : 0 }

sorted_devices = devices
                 .reject { |d| d == 'lo' }
                 .reject { |d| d == 'hsn0.1840' }
                 .sort_by { |d| d.casecmp('hsn0').zero? ? 1 : 0 }

Facter.add(:ucx_tls) do
  setcode { sorted_transports.join(',') }
end

Facter.add(:ucx_net_devices) do
  setcode { sorted_devices.join(',') }
end
