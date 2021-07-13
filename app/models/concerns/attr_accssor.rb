module Attr_accssor
  extend ActiveSupport::Concern

  included do
    attr_accessor :selectbox_parameter
  end
end
