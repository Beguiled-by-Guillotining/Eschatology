load_samples :tabla

samps = [
  :tabla_ghe1, :tabla_ghe2, :tabla_ghe3, :tabla_ghe4, :tabla_ghe5, :tabla_ghe6, :tabla_ghe7, :tabla_ghe8,
  :tabla_na, :tabla_na_o, :tabla_na_s,
  :tabla_tas1, :tabla_tas2, :tabla_tas3,
  :tabla_te1, :tabla_te2, :tabla_te_m, :tabla_te_ne,
  :tabla_tun1, :tabla_tun2, :tabla_tun3
]

define :play_drum do
  sample (choose samps), rate: (rrand 0.5, 1.0), pan: (rrand -1.0, 1.0)
end

live_loop :drums do
  play_drum
  play_drum if one_in 3
  sleep (rrand_i 1, 4) / 4.0
end

live_loop :quick_drums do
  sleep (rrand 5.0, 6.0)
  time = 0.25
  (rrand_i 10, 15).times do
    play_drum
    time -= (rrand 0.01, 0.015)
    sleep time
  end
  (rrand_i 20, 30).times do
    play_drum
    sleep time
  end
  (rrand_i 20, 25).times do
    play_drum
    time += (rrand 0.01, 0.015)
    sleep time
  end
  sleep (rrand 30.0, 50.0)
end

live_loop :woosh do
  sleep (rrand 5.0, 20.0)
  sample :ambi_dark_woosh, release: 1.0
end

live_loop :wob do
  sleep (rrand 10.0, 20.0)
  use_synth :hoover
  len = rrand 8.0, 15.0
  s = play 50, attack: 1.0, decay: 0.0, sustain: len, release: 1.0,
    res: 0.999, amp: 0.2, pan_slide: len/2
  control s, pan: [-1, 1].choose
  sleep len/2
  control s, pan: [-1, 1].choose
end

