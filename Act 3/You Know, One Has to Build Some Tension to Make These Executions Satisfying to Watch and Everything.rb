samples = (ring :drum_bass_hard, :drum_cymbal_closed, :drum_cymbal_pedal, :drum_heavy_kick, :drum_snare_hard, :drum_tom_hi_hard, :drum_tom_lo_hard, :drum_tom_mid_hard)

use_debug false
use_sched_ahead_time 1.0

set :loopNum, 0
set :loopNumMelody, 0


with_fx :reverb, room: 1.0, mix: 0.6, damp: 1.0 do
  with_fx :reverb, room: 1.0, mix: 0.6, damp: 1.0 do
    with_fx :octaver, mix: 0.6 do
      with_fx :level do |l|
        define :startBeatLoop do |beatSleepTime, alwaysPlay=false|
          n = get :loopNum
          set :loopNum, n+1
          
          live_loop ("loop" + n.to_s).to_sym do
            beatLength = quantise (rrand_i 8, 15), beatSleepTime
            atTimes = range 0, beatLength, step: beatSleepTime
            
            run = tick
            
            samp = (choose samples)
            amp = (rrand 0.3, 0.4) + beatSleepTime * 0.5 + run / 10.0
            pan = (rrand -0.1, 0.1)
            
            n = (rrand_i 7, 11) - run / 2
            timing = (spread (rrand_i 2, 4),  (n > 0 ? n : 1))
            timing = ring true if alwaysPlay
            print run, timing
            
            at atTimes do |t, idx|
              sample samp, amp: amp * 0.6, pan: pan if timing[idx]
            end
            
            sleep beatLength
          end
        end
        
        in_thread do
          startBeatLoop 0.5
          startBeatLoop 0.5
          sleep 5.0
          startBeatLoop 0.25
          startBeatLoop 0.25
          startBeatLoop 0.25
          sleep 5.0
          startBeatLoop 0.125
          startBeatLoop 0.125
          sleep 5.0
          startBeatLoop 0.5
          startBeatLoop 0.5, true
        end
        
        randomness = 20
        
        #instrument, sleepTime, amp, note_offset
        instrs = [
          [
            [0.5  , 0.2 , 0],
            [1.0  , 0.2 , 0]
          ],
          [
            [0.25 , 0.45, -12],
            [0.25 , 0.4 , 0],
            [0.25 , 0.2 , 12]
          ],
          [
            [0.125, 0.8 , -12],
            [0.125, 0.7 , 0],
            [0.125, 0.3 , 12]
          ],
          [
            [0.125, 0.8 , -12],
            [0.125, 0.7 , 0],
            [0.125, 0.3 , 12]
          ]
        ]
        
        curScale = chord :C3, :diminished7, num_octaves: 2
        
        define :liveLoop do |sleepTime, amp, offset|
          use_synth :pluck
          
          len = rrand_i 4, 8
          
          pauses = 2
          
          melody = []
          len.times do
            melody.append([(knit :r, pauses, (choose curScale), 1).choose,
                           (rrand 0.8, 1.2),
                           (rrand -0.2, 0.2)])
          end
          
          n = get :loopNumMelody
          set :loopNumMelody, n+1
          live_loop ("loopMelody" + n.to_s).to_sym do
            idx = tick % len
            if one_in(randomness)
              melody = melody[0..idx] +
                [[(knit :r, pauses, (choose curScale), 1).choose,
                  (rrand 0.8, 1.2),
                  (rrand -0.2, 0.2)
                  ]] +
                melody[(idx+1)..melody.length]
            end
            
            play melody[idx][0] + offset,
              amp: melody[idx][1] * amp * 0.5,
              pan: melody[idx][2],
              release: sleepTime * 2
            
            pauses = (rrand 1, 3) if one_in 20 / sleepTime
            
            sleep sleepTime
          end
        end
        
        
        
        for instr in instrs
          for inst in instr
            liveLoop inst[0], inst[1], inst[2]
          end
          sleep 5.0
        end
        
        sleep 155.0
        control l, amp: 0
      end
      
      4.times do
        for s in samples
          sample s, amp: 10.0
        end
        sleep 0.5
      end
      for s in samples
        sample s, amp: 100.0
      end
      for s in [:drum_cymbal_open, :drum_cymbal_hard, :drum_cowbell ]
        sample s, amp: 100.0
      end
      
    end
  end
end