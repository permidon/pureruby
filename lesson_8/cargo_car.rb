class CargoCar < Car
  attr_reader :type, :filled, :free

  def initialize(id, volume)
    super
    @type = :сargo
    @volume = volume
    valid!
    @filled = 0
    @free = volume
  end

  def fill_vol(content)
    @content = content
    raise "Volume is greater than the capacity" if @filled + @content > @volume
    raise "There is no extra space" if @filled == @volume
    @free = @volume - @filled - @content
    @filled += @content
  end

  protected

  def valid!
    raise "Volume must be an integer" if @volume.class != Fixnum
    raise "Volume must be in range 100-1000" if @volume < 100 || @volume > 1000
    true
  end
end
