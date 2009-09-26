require 'open4'
require 'fileutils'
require 'strongbox'

module Safe
  class KeygenError < StandardError;end
  module Keys
    SAFE_KEYS_DIR = File.join(RAILS_ROOT,'config', 'safe_keys')
    
    def gen_private_key(path, pass)
      cmd = "openssl genrsa -des3 -passout pass:#{pass} -out #{path}private.pem 2048"
      Open4::popen4("sh") do |pid, stdin, stdout, stderr|
        stdin.puts cmd
        stdin.close
      end
    end

    def gen_public_key(path, pass)
      cmd = "openssl rsa -in #{path}private.pem -out #{path}public.pem -outform PEM -pubout -passin pass:#{pass}"
      Open4::popen4("sh") do |pid, stdin, stdout, stderr|
        stdin.puts cmd
        stdin.close
      end
    end

    def gen_keypair(path, pass)
      gen_private_key(path, pass)
      gen_public_key(path, pass)
      if File.exists?("#{path}keypair.pem")
        FileUtils.rm("#{path}keypair.pem")
      end
      cmd = "cat #{path}private.pem  #{path}public.pem >> #{path}keypair.pem"
      Open4::popen4("sh") do |pid, stdin, stdout, stderr|
        stdin.puts cmd
        stdin.close
      end
    end

    # destructible, only call once
    def make_keys!
      root_dir = SAFE_KEYS_DIR
      object_id = self.id
      pass = self.password 
      raise Safe::KeygenError if object_id.nil? || pass.nil?
      dir_class = root_dir + "/#{self.class.to_s.tableize}/"
      dir = dir_class + "#{object_id}/"
      if File.exists?(root_dir) && File.directory?(root_dir)
        Dir.mkdir(dir_class) unless File.exists?(dir_class)
        Dir.mkdir(dir) unless File.exists?(dir)
        gen_keypair(dir, pass)
      else
        Dir.mkdir(root_dir)
        Dir.mkdir(dir_class)
        Dir.mkdir(dir)
        gen_keypair(dir, pass)
      end  
    end
  end
end
