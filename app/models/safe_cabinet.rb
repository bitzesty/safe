require "openssl"
require 'base64'
require 'strongbox/lock'

class SafeCabinet < ActiveRecord::Base
  # Class Configuration :::::::::::::::::::::::::::::::::::::::::::::
  class_inheritable_reader :lock_options
  write_inheritable_attribute(:lock_options, {}) if lock_options.nil?

  SAFE_KEYS_DIR = File.join(RAILS_ROOT,'config', 'safe_keys')
  
  # Assocations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  belongs_to :encryptable, :polymorphic => true
 
  # Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  validates_presence_of :encryptable_id
  validates_presence_of :encryptable_type

  # Callbacks :::::::::::::::::::::::::::::::::::::::::::::::::::::::
  before_save :lockdown

  # Instance Methods :::::::::::::::::::::::::::::::::::::::::::::::: 
  def options
    @options ||= {
      :base64 => false,
      :symmetric => :always,
      :padding => OpenSSL::PKey::RSA::PKCS1_PADDING,
      :symmetric_cipher => 'aes-256-cbc'
    }
  end
  
  def data
    lock_for("data")
  end
  
  def lockdown
    self.data = lock_for("data").encrypt self[:data]
  end
  
  def read_data(pass)
    self.data.decrypt pass
    rescue OpenSSL::PKey::RSAError
      nil 
  end
  
  def lock_for name
    lock_options[name] = options.merge(:key_pair => File.join(SAFE_KEYS_DIR, self.encryptable_id.to_s, "keypair.pem"))
    @_locks ||= {}
    @_locks[name] ||= Lock.new(name, self, self.class.lock_options[name])
  end
end 