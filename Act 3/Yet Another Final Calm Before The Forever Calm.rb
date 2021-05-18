numberOfNoises = 5
time = 10.0

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

define :makeNoise do |i|
  use_synth :fm
  c = play note[i], sustain: time, release: 0.1, attack: 0.1, env_curve: 1,
    divisor: divisor[i], depth: depth[i], amp: amp[i], pan: pan[i],
    slide: time, slide_shape: 4
  
  depth[i] += (rrand_i -1, 1) * 0.1 #((rrand 2.0, 0.5) <=> depth[i]) * 0.1
  divisor[i] += (rrand_i -1, 1) * 0.05#((rrand 1.5, 0.5) <=> divisor[i]) * 0.05
  note[i] += (rrand_i -1, 1) * 0.2#((rrand 30, 40) <=> note[i]) * 0.2
  pan[i] += (rrand_i -1, 1) * 0.1#((rrand -0.5, 0.5) <=> pan[i]) * 0.1
  amp[i] += (rrand_i -1, 1) * 0.1#((rrand 0.5, 1.2) <=> amp[i]) * 0.1
  
  pan[i] = pan[i] < -1.0 ? -1.0 : pan[i] > 1.0 ? 1.0 : pan[i]
  
  control c, note: note[i], divisor: divisor[i], depth: depth[i], amp: amp[i], pan: pan[i]
end

live_loop :noise do
  for i in range(0, numberOfNoises)
    makeNoise i
  end
  sleep time
end