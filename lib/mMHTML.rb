require 'mMHTML/extensions/object'

require 'mMHTML/version'
require 'mMHTML/exception'
require 'mMHTML/header'
require 'mMHTML/reflection'
require 'mMHTML/document'
require 'mMHTML/element'

module MMHTML

  DEFAULTS = {

    :store_source => false,

    :formats => {

      'quoted-printable' => 'M',

      'base64' => 'm'

    }

  }.freeze

  def self.configure
    reset!
    yield @config
  end

  def self.config
    @config
  end

  def self.formats
    config[:formats]
  end

  def self.store_source?
    config[:store_source]
  end

  def self.reset!
    @config = DEFAULTS.dup
  end

end
