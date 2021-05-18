
define :playNotes do
  use_synth_defaults attack: 5.0, sustain: 5.0, release: 5.0
  
  play (hz_to_midi (rrand 40, 80)), amp: (rrand 0.8, 1.2)
  play (hz_to_midi (rrand 120, 150)), amp: 0.5 * (rrand 0.8, 1.2) if factor? tick, 2
  play (hz_to_midi (rrand 240, 300)), amp: 0.2 * (rrand 0.8, 1.2) if !factor? look, 2
  
  sleep (rrand 4.0, 6.0)
end

live_loop :main do
  playNotes
end

with_fx :level, amp: 0.3 do
  live_loop :blade do
    use_synth :square
    playNotes
  end
end

with_fx :level, amp: 0.5 do
  live_loop :saw do
    use_synth :saw
    playNotes
  end
end