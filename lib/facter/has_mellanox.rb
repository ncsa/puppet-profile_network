Facter.add('has_mellanox') do
  setcode do
    Facter::Core::Execution.execute('lspci | grep ConnectX-')
    $CHILD_STATUS.success?
  end
end
