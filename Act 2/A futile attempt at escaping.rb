require PETAL_PATH()

with_fx :reverb, room: 1.0, mix: 0.0 do |rev|
  
  mix = 0.0
  cur_bpm = 120
  
  live_loop :control do
    control rev, mix: mix
    mix += 0.025
    
    d1 "tabla2(3,4)", n: "irand 46"
    bpm cur_bpm
    cur_bpm += 5
    
    sleep 2.0
    stop if mix > 1.0
  end
end

sleep 95.0
d2 "bd", n: "irand 24", slow: 2.0, amp: 10.0, rate: 0.2
sleep 5.0

amp = 0.0
set :end, false
live_loop :noise do
  synth :noise, sustain: 1.0, release: 0.0, amp: amp
  amp += 0.05 if amp < 1.0
  sleep 1.0
  stop if get :end
end

sleep 20.0
d1
set :end, true
sleep 5.0
d2
sleep 0.5
for s in sample_names :bd
  sample s, amp: 10.0
end
