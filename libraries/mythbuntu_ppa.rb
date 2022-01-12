require 'chef/exceptions'

class LSB
  CODENAMES = {
      :lucid    => '10.04',
      :maverick => '10.10',
      :natty    => '11.04',
      :oneiric  => '11.10',
      :precise  => '12.04',
      :quantal  => '12.10',
      :raring   => '13.04',
      :saucy    => '13.10',
      :trusty   => '14.04'
    } unless const_defined?(:CODENAMES)
end

class MythbuntuPPA

  VERSIONS = {
    '0.24' => [ :lucid, :maverick, :natty, :oneiric ],
    '0.25' => [ :lucid, :natty, :oneiric, :precise, :quantal ],
    '0.26' => [ :precise, :quantal, :raring ],
    '0.27' => [ :precise, :raring, :saucy, :trusty ]
  } unless const_defined?(:VERSIONS)

  def self.supported_versions(lsb_codename)
    case lsb_codename.to_sym
    when :lucid
      return [ '0.24', '0.25' ]
    when :maverick
      return [ '0.24' ]
    when :natty
      return [ '0.24', '0.25' ]
    when :oneiric
      return [ '0.24', '0.25' ]
    when :precise
      return [ '0.25', '0.26', '0.27' ]
    when :quantal
      return [ '0.25', '0.26' ]
    when :raring
      return [ '0.26', '0.27' ]
    when :saucy
      return [ '0.27' ]
    when :trusty
      return [ '0.27' ]
    else
      raise Chef::Exceptions::InvalidPlatformVersion, "This cookbook or the Mythbuntu PPA does not support version #{lsb_codename}"
    end
  end

  def self.latest_supported_version(lsb_codename)
    return self.supported_versions(lsb_codename).sort_by{ |a| a }.reverse![0]
  end

  def self.supports_version?(lsb_codename, mythbuntu_version)
    begin
      return !!self.supported_versions(lsb_codename).include?(mythbuntu_version)
    rescue
      false
    end
  end
end
