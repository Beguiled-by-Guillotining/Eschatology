saba_chord = [:D3, :E3 - 0.5, :F3, :Gb3]

live_loop :main do
  use_synth :pluck
  play saba_chord, pitch: (rrand_i 12, 20), sustain: 5.0, coef: 0
  sleep 2.3
end

live_loop :drums do
  sample (choose sample_names :tabla), amp: (rrand 0.1, 1.0)
  
  sleepTime = 0.1
  sleepTime += (rrand 1.0, 2.0) if one_in 3
  sleep sleepTime
end


live_loop :noise do
  use_synth :pnoise
  play :C3, amp: 0.1, sustain: 10.0, release: 0.0, cutoff: 130
  sleep 10.0
end