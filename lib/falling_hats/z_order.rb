module FallingHats
  module ZOrder
    [
      :BACKGROUND,
      :ENTITY,
      :INFO,
      :MESSAGE,
    ].each_with_index do |name, i|
      const_set(name, i)
    end
  end
end
