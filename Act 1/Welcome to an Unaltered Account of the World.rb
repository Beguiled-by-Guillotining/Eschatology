samples = []
sampleNum = 0

live_loop :main do
  in_thread do
    l = (rrand 0.005, 0.02)
    times = range 0, l * sampleNum, l
    at times, (shuffle samples) do |s|
      sample s, amp: (rrand 0.0, 1.0), rate: [1 / (rrand 1.0, 4.0), (rrand 1.0, 4.0)].choose
    end
  end
  
  sleep (rrand 0.1, 0.6)
end

baseSampleGroups = [:guit, :bd, :loop, :mehackit, :perc, :misc, :bass, :ambi]
sampleGroups = baseSampleGroups + [:r]

live_loop :sampleChanger do
  g = sampleGroups.tick
  if g == :r
    samples = []
    sampleNum = 0
    sampleGroups = (shuffle baseSampleGroups) + [:r]
    sleep (rrand 20.0, 25.0)
  else
    samples = sample_names g
    sampleNum = samples.length
  end
  sleep (rrand 10.0, 15.0)
end
