use_random_source :perlin

live_loop :main do
  timing = []
  timing2 = []
  with_random_source :white do
    timing = (spread (rrand_i 7, 10), 12)
    timing2 = (spread (rrand_i 7, 10), 12)
  end
  (rrand_i 40, 50).times do
    use_synth :chiplead
    play (choose scale :C3, :rast, num_octaves: 3), amp: 0.2, note_resolution: 0.0 if timing.tick
    use_synth :chipbass
    play (choose scale :C2, :rast, num_octaves: 3), amp: 0.2, note_resolution: 0.0 if timing.look
    with_random_source :white do
      sample [:tabla_tas1, :tabla_tas2, :tabla_tas3].choose, amp: (rrand 0.3, 0.5) if timing2.look
    end
    sleep 0.2
  end
end

with_fx :ixi_techno, cutoff_max: 80, phase: 10.0 do
  live_loop :bg do
    use_synth :bnoise
    play :C3, sustain: 1.0, release: 0.0, amp: 0.3
    sleep 1.0
  end
end