row = shuffle scale :C3, :chromatic, num_octaves: 1
times = shuffle range 0.1, 1.4, 0.1
releases = shuffle range 0.2, 2.8, 0.2

synths = shuffle [:blade, :fm, :piano, :pluck, :pretty_bell, :saw, :sine, :square, :blade, :fm, :piano, :pluck, :pretty_bell]

print row.length, times.length, releases.length, synths.length

live_loop :main do
  use_synth synths.tick(:a)
  play row.tick(:b), release: releases.tick(:c)
  sleep times.tick(:d)
end