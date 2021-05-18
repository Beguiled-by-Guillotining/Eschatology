use_debug false

with_fx :gverb, room: 100 do
  live_loop :main do
    use_synth :pluck
    play (choose chord :E4, 'm7+9'), coef: 0.6
    sleep [0.25, 0.25, 0.25, 0.5].choose
  end
  
  live_loop :main3 do
    use_synth :hollow
    play (choose chord :E2, 'm7+9'), coef: 0.3, release: 2.0, amp: 0.5
    sleep [0.5, 1.0].choose
  end
  
  live_loop :main2 do
    use_synth :pluck
    play (choose chord :E2, 'm7+9'), coef: 0.2
    sleep [0.25, 0.25, 0.25, 0.5].choose
  end
end