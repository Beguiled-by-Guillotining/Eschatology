numberOfNoises = 5
time = 10.0

use_random_source :pink

depth = []
divisor = []
note = []
pan = []
amp = []

numberOfNoises.times do
  depth.append(1.0)
  divisor.append(1.0)
  note.append(35)
  pan.append(rrand -0.1, 0.1)
  amp.append(rrand 0.8, 1.0)
end

define :makeNoise do |i, release|
  use_synth :fm
  c = play note[i], sustain: time - release, release: 0.1 + release, attack: 0.1, env_curve: 1,
    divisor: divisor[i], depth: depth[i], amp: amp[i], pan: pan[i],
    slide: time, slide_shape: 4
  
  depth[i] = (rrand 2.0, 0.5)
  divisor[i] = (rrand 1.5, 0.5)
  note[i] = (rrand 30, 40)
  pan[i] = (rrand -0.5, 0.5)
  amp[i] = (rrand 0.5, 1.2)
  
  control c, note: note[i], divisor: divisor[i], depth: depth[i], amp: amp[i], pan: pan[i]
end

live_loop :noise do
  for i in range(0, numberOfNoises)
    makeNoise i, 0.0
  end
  sleep time
end