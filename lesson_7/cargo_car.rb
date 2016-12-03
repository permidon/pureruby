class CargoCar < Car

  attr_reader :type, :filled, :free

  def initialize(id, volume)
    super
    @type = "сargo"
    @volume = volume
    valid!
    @filled = 0
    @free = volume
  end

  def fill_vol(content)
    @content = content
    raise "Занимаемый объем не может превышать общий" if @filled + @content > @volume
    raise "Весь объем в вагоне занят" if @filled == @volume
    @free = @volume - @filled - @content
    # свободный объем добавлен выше, чтобы последним выводом было
    # кол-во занятого объема
    @filled += @content
  end

  protected

  def valid!
    raise "Объем вагона должен быть целым числом" if @volume.class != Fixnum
    raise "Объем вагона находится в интервале от 100 до 1000" if @volume < 100 || @volume > 1000
    true
  end

end
