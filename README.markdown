Safe
====

A wrapper around [strongbox](http://github.com/spikex/strongbox) to store and encrypt data.

Setup
----

Install strongbox and safe

    config.gem "spikex-strongbox", :lib => "strongbox", :source => "http://gems.github.com"
    config.gem "bitzesty-safe", :lib => "safe", :source => "http://gems.github.com"
    
    rake gems:install
    rake gems:unpack

Generate a migration with `script/generate migration CreateSafeCabinet` and add the following

    class CreateSafeCabinet < ActiveRecord::Migration
      def self.up
        create_table :safe_cabinets, :force => true do |t|
          t.binary :data
          t.binary :data_key
          t.binary :data_iv
          t.integer :encryptable_id
          t.string :encryptable_type
          t.timestamps
        end
        add_index :safe_cabinets, [:encryptable_id, :encryptable_type]
      end

      def self.down
        drop_table :safe_cabinet
      end
    end
    
In your model that you want to store the encrypted data add:

    class MyModel
      include Safe::Keys
      attr_accessor :password #length must be > 3  
      has_many :safe_cabinets, :as => :encryptable #or has_one
      after_create :make_keys!
    end

_N.B. A password must be used when creating an instance of MyModel._

To create and use safe_cabinets:

    m = MyModel.create(:password => "1234")
    c = m.safe_cabinets.new
    c.data = "super secret data"
    c.save
    
    c.data
    => #<Strongbox::Lock:0x1f372d...
    
    c.data.read_data("1234")
    => "super secret data"
    


Copyright (c) 2009 Matthew Ford and Bit Zesty Ltd, See LICENSE for details.