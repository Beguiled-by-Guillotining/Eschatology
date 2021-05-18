use_bpm 80

use_debug false

define :playSamples do |samples, amp|
  at (line 0, 0.2, steps: [1,2,4,8].choose) do
    sample (choose sample_names samples), amp: amp * (rrand 0.8, 1.5)
  end
end

live_loop :drums do
  playSamples :bd, 2.0
  sleep 0.2
end

live_loop :drums2 do
  playSamples :perc, 0.5
  sleep 0.2
end

live_loop :drums3 do
  playSamples :sn, 0.5
  sleep 0.2
end

live_loop :drums4 do
  playSamples :glitch, 0.1
  sleep 0.2
end

live_loop :drums5 do
  playSamples :elec, 0.7
  sleep 0.2
end

live_loop :drums6 do
  playSamples :bass, 0.2
  sleep 0.2
end

