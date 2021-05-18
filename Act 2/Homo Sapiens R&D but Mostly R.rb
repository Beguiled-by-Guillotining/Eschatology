live_loop :a do
  use_synth :mod_fm
  play (rrand :c3, :c4), divisor: (rrand 0.5, 2.0), mod_range: (rrand 2.0, 7.0), amp: 0.5
  sleep [0.25, 0.25, 0.5].choose
end

live_loop :b do
  use_synth :hollow
  play (choose chord :A5, 'm7+5-9'), attack: 5.0, release: 5.0, amp: 3.0
  sleep 4.0
end

live_loop :c do
  sample choose sample_names :elec
  sleep (rrand 0.1, 1.0)
end

live_loop :d do
  synth :bnoise, amp: 0.5, release: (rrand 1.0, 2.0), attack: (rrand 1.0, 2.0), cutoff: (rrand 50, 100)
  sleep 1.0
end