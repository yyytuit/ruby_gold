class Log
  [:debug, :info, :notice].each do |level|
    define_method(level) do
    @state = level
    end
  attr_reader :state
  end
end
 log = Log.new
 log.debug  ; p log.state
 log.info   ; p log.state
 log.notice ; p log.state
