mult = 2.0

live_loop :main do
  use_synth :pulse
  play (rrand :C4, :C7), pulse_width: (rrand 0.00001, 0.99999)
  sleep (rrand 0.1, 1.0) * mult
end

live_loop :main2 do
  use_synth :pulse
  play (rrand :C4, :C7), pulse_width: (rrand 0.00001, 0.99999)
  sleep (rrand 0.1, 1.0) * mult
end
live_loop :main21 do
  use_synth :pulse
  play (rrand :C4, :C7), pulse_width: (rrand 0.00001, 0.99999)
  sleep (rrand 0.1, 1.0) * mult
end
live_loop :main22 do
  use_synth :pulse
  play (rrand :C4, :C7), pulse_width: (rrand 0.00001, 0.99999)
  sleep (rrand 0.1, 1.0) * mult
end

live_loop :main3 do
  use_synth :pulse
  play (rrand :C3, :C6), pulse_width: (rrand 0.00001, 0.99999)
  sleep (rrand 0.1, 1.0) * mult
end

live_loop :main4 do
  use_synth :pulse
  play (rrand :C2, :C5), pulse_width: (rrand 0.00001, 0.99999)
  sleep (rrand 0.1, 1.0) * mult
end

live_loop :main5 do
  use_synth :pulse
  play (rrand :C2, :C5), pulse_width: (rrand 0.00001, 0.99999)
  sleep (rrand 0.1, 1.0) * mult
end

live_loop :timeChanger do
  mult *= 0.96
  sleep 1.0
end

sleep 40.0

live_loop :noise do
  synth :cnoise, attack: 1.0, release: 10.0, amp: tick * 0.1
  sleep 0.5
end