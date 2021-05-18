use_debug false

with_fx :bitcrusher, bits: 16, sample_rate: 40000 do |crusher|
  with_fx :lpf, cutoff: 100 do
    with_fx :gverb, room: 100 do
      live_loop :main do
        use_synth :pluck
        play (choose chord :E2, :minor7), coef: 0.4
        sleep [0.25, 0.25, 0.25, 0.5].choose
      end
      
      live_loop :main3 do
        use_synth :hollow
        play (choose chord :E1, :minor7), coef: 0.3, release: 2.0, amp: 0.5
        sleep [0.5, 1.0].choose
      end
      
      live_loop :main2 do
        use_synth :pluck
        play (choose chord :E4, :minor7), coef: 0.4
        sleep [0.25, 0.25, 0.25, 0.5].choose
      end
    end
  end
  
  samp_rate = 40000
  live_loop :crushController do
    print "Sample rate:", samp_rate
    control crusher, sample_rate: samp_rate
    samp_rate -= 0.1 * samp_rate
    sleep 4.0
  end
  
  bits = 16
  live_loop :bitController do
    print "Bits:", bits
    control crusher, bits: bits
    stop if bits <= 2
    bits -= 2
    sleep 22.2
  end
end