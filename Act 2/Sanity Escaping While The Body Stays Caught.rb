eval_file SSO_RB_PATH()

use_debug false

len = 9
set :len, len

set :global_amp, 1.0

#instrument, amp, note_offset
instr = [['Xylophone', 1.0, -6],
         ['Xylophone', 1.0, 0],
         ['Xylophone', 1.0, 6]]

curScale = scale :E3, :segah, num_octaves: 2

define :liveLoop do |pitch, window_size, amp|
  in_thread do
    melodies = []
    instr.each do |inst|
      loadName inst[0]
      melody = []
      len.times do
        melody.append([:r, 0.0])
      end
      melodies.append(melody.ring)
    end
    
    with_fx :pitch_shift, pitch: pitch, pitch_dis: 0.001, time_dis: 0.001, window_size: window_size do
      live_loop ("main" + pitch.to_s + window_size.to_s).to_sym do
        new_melodies = []
        
        idx = tick % get(:len)
        instr.zip(melodies).each do |inst,melody|
          if one_in(20)
            melody = melody[0..idx] +
              [[[:r, (choose curScale), (choose curScale)].choose, (rrand -1.0, 1.0)]] +
              melody[(idx+1)..melody.length]
          end
          m = melody[idx]
          pl m[0]+inst[2], 1.0, inst[0], inst[1] * amp * get(:global_amp), 0, m[1]
          new_melodies.append(melody)
        end
        melodies = new_melodies
        sleep 0.2
      end
    end
  end
end

liveLoop -12, 1.0,  0.5
liveLoop -12, 0.5,  0.5
liveLoop -24, 1.0,  1.0
liveLoop -36, 0.02, 1.0
liveLoop -36, 0.2,  1.0
liveLoop -48, 0.2,  2.0
liveLoop -48, 0.02, 2.0
liveLoop -60, 1.0,  8.0
liveLoop -72, 1.0,  10.0

live_loop :ampMod do
  sleep 10.0
  set :global_amp, get(:global_amp) + 0.1
  print "amp", get(:global_amp)
end

live_loop :lenMod do
  sleep 32.0
  set :len, get(:len) - 1
  print "len", get(:len)
  stop if get(:len) <= 1
end

