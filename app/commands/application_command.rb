class ApplicationCommand
  def self.call(...)
    new(...).call
  end

  def params
    raise NotImplementedError
  end

  def contract
    raise NotImplementedError
  end

  def validation_result
    @validation_result ||= contract.call(params)
  end
end
