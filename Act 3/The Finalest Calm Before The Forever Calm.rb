numberOfNoises = 10
time = 10.0

depth = []
divisor = []
note = []
pan = []
amp = []

depth_change = []
divisor_change = []
note_change = []
pan_change = []
amp_change = []

numberOfNoises.times do
  depth.append(1.0)
  divisor.append(1.0)
  note.append(35)
  pan.append(rrand -0.1, 0.1)
  amp.append(rrand 0.8, 1.0)
  
  depth_change.append((rrand_i -1, 1) * 0.1)
  divisor_change.append((rrand_i -1, 1) * 0.05)
  note_change.append((rrand_i -1, 1) * 0.2)
  pan_change.append((rrand_i -1, 1) * 0.1)
  amp_change.append((rrand_i -1, 1) * 0.1)
end

define :makeNoise do |i|
  use_synth :fm
  c = play note[i], sustain: time, release: 0.1, attack: 0.1, env_curve: 1,
    divisor: divisor[i], depth: depth[i], amp: amp[i], pan: pan[i],
    slide: time, slide_shape: 7
  
  if one_in 10
    depth_change[i] = (rrand_i -1, 1) * 0.1
    divisor_change[i] = (rrand_i -1, 1) * 0.05
    note_change[i] = (rrand_i -1, 1) * 0.2
    pan_change[i] = (rrand_i -1, 1) * 0.1
    amp_change[i] = (rrand_i -1, 1) * 0.1
  end
  
  depth[i] += depth_change[i]
  divisor[i] += divisor_change[i]
  note[i] += note_change[i]
  pan[i] += pan_change[i]
  amp[i] += amp_change[i]
  
  pan[i] = pan[i] < -1.0 ? -1.0 : pan[i] > 1.0 ? 1.0 : pan[i]
  amp[i] = amp[i] < 0.0 ? 0.0 : amp[i] > 3.5 ? 3.5 : amp[i]
  
  control c, note: note[i], divisor: divisor[i], depth: depth[i], amp: amp[i], pan: pan[i]
end

live_loop :noise do
  for i in range(0, numberOfNoises)
    makeNoise i
  end
  sleep time
end