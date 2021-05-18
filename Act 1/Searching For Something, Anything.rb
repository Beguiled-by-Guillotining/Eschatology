use_debug false

eval_file SSO_RB_PATH()

bayati_chord = [:D3, :E3 - 0.5, :F3, :G3]
rast_chord = [:C3, :D3, :E3 - 0.5, :F3]
saba_chord = [:D3, :E3 - 0.5, :F3, :Gb3]
sigah_chord = [:E3 - 0.5, :F3, :G3, :A3]

chords = [bayati_chord, rast_chord, saba_chord, sigah_chord]

define :main do
  cur_scale = chords.choose
  print cur_scale
  
  (rrand_i 30, 50).times do
    pl cur_scale.choose + 6, 1.0, 'Trombones stc', (rrand 0.9, 1.0), 0, (rrand -0.6, 0.6)
    sleep 0.12 * (knit 1,2, 2,3, 4,2).choose
  end
end
live_loop :main1 do
  main
end
live_loop :main2 do
  main
end
live_loop :main3 do
  main
end

live_loop :drums do
  note = (rrand_i 52, 64)
  release = (rrand 0.2, 1.0)
  (rrand_i 10, 20).times do
    use_synth :dull_bell
    play note + [0.0, 0.5].tick, amp: (rrand 0.8, 1.0), release: release
    sleep 0.12 * (knit 1,3, 2,3).choose
  end
end

live_loop :noise do
  note = (rrand_i 52, 64)
  (rrand_i 10, 20).times do
    use_synth :tech_saws
    play note + [0.0, 0.5].tick, amp: (rrand 0.5, 0.6), release: 1.0
    sleep 0.24
  end
end

