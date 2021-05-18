melodySleepTime = 0.25

live_loop :bad_melody do
  beatLength = rrand_i 40, 50
  atTimes = range melodySleepTime, beatLength * melodySleepTime, step: melodySleepTime
  
  (rrand_i 3,4).times do
    note = (scale :C3, :minor).choose
    amp = (rrand 0.8, 1.0)
    x = (rrand_i 4, 40)
    timing = (spread (rrand_i 2, x / 2), x)
    len = (rrand_i 2, 10)
    coef = (rrand 0.3, 0.5)
    
    at atTimes do |t, idx|
      synth :pluck, note: note, amp: amp, sustain: len, coef: coef, pluck_decay: len, noise_amp: 1.0 if timing[idx]
    end
  end
  
  sleep beatLength * melodySleepTime
end

live_loop :bad_drums do
  sample (choose sample_names :sn), amp: 0.2
  sleep melodySleepTime * (rrand_i 1, 3)
end