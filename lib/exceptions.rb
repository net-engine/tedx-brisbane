module Exceptions
  class EmailEventNotRecognised < StandardError; end

  class TEDXErrorWithPredefinedMessage < StandardError
    def initialize(*opt)
      params = opt.extract_options!
      @msg_params = params.delete(:msg_params) || {}
      super(*(opt << params))
    end

    def message
      return I18n.translate("models." + self.class.to_s.gsub('::','.').underscore, @msg_params)
    end
  end

  class InvalidAttendee < TEDXErrorWithPredefinedMessage
  end

  class MissingCCField < TEDXErrorWithPredefinedMessage
  end

  class UnsupportedCCBrand < TEDXErrorWithPredefinedMessage
  end

  class DeclinedTransaction < TEDXErrorWithPredefinedMessage
  end
end
