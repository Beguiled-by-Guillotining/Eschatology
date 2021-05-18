cur_scale = scale :C3, :minor, num_octaves: 3
synth_used = :piano

use_debug false

with_debug false do
  live_loop :bg do
    use_synth :gnoise
    time = (rrand 0.8, 1.0)
    play 30, amp: 0.02, sustain: time, cutoff: 90, release: 0
    play 130, amp: 0.01, sustain: time, cutoff: 130, release: 0
    sleep time
  end
  
  live_loop :bg2 do
    sample :vinyl_hiss
    sleep sample_duration :vinyl_hiss
  end
  
  live_loop :hoover_notes do
    use_synth :pluck
    note = rrand_i 30, 60
    time = rrand 8.0, 16.0
    s = play note, amp: 1.0, attack: time / 2, release: time / 2,
      note_slide: time, note_slide_shape: 4
    note += rrand_i -10, 10
    control s, note: note
    sleep time / 2
  end
end

# return value: list, where elements have the form [relative_note, length] or [pause_length]
define :generate_motif do
  motif = []
  note_index = 0
  notes_in_motif = (rrand_i 5, 8)
  i = 0
  next_step = 0
  notes_in_motif.times do
    if i >= notes_in_motif - 1
      length = [1.0].choose
    else
      length = [0.25, 0.5, 1.0].choose
    end
    
    motif.push [note_index, length]
    
    motif.push [0.5] if length >= 1.0 and i < notes_in_motif - 1 and next_step != 0 and one_in(6)
    
    if next_step != 0
      note_index += next_step
      next_step = 0
    elsif one_in(10)
      next_step = [-1, 1].choose
      note_index += -next_step * (rrand_i 4, 6)
    elsif one_in(3)
      note_index += [-1, 1].choose * (rrand_i 2, 3)
    else
      note_index += rrand_i -1, 1
    end
    
    i += 1
  end
  
  return motif
end

define :play_note do |note, length|
  use_synth synth_used
  play note, release: length, amp: (rrand 0.5, 0.6)
end


define :play_motif do |motif, cur_scale, tranposed_to|
  for note in motif
    if note.length >= 2
      play_note cur_scale[tranposed_to + note[0]], note[1]
      sleep note[1] / 2
    else
      sleep note[0]
    end
  end
  
  return tranposed_to + motif[motif.length - 1][0]
end


live_loop :melody do
  note_index = 7
  notes_in_melody = (rrand_i 20, 30)
  motifs = []
  print "Generating new motifs"
  3.times do
    motifs.push generate_motif
  end
  
  i = 0
  notes_in_melody.times do
    if one_in(2)
      if one_in(4)
        print "Resetting to base note"
        play_note cur_scale[[7, 11].choose], [1.0, 2.0].choose
        note_index = 7
        sleep 0.5
      end
      motif_index = (rrand_i 1, motifs.length)
      print "Playing motif " + motif_index.to_s
      note_index = play_motif motifs[motif_index - 1], cur_scale, note_index
      sleep 0.5 if !one_in(4)
    else
      print "Playing connecting note"
      if i >= notes_in_melody - 1
        length = [1.0, 2.0].choose
      else
        length = [0.5, 1.0, 2.0].choose
      end
      
      play_note cur_scale[note_index], length
      
      if one_in(4)
        note_index += [-1, 1].choose * (rrand_i 3, 5)
      else
        note_index += rrand_i -1, 1
      end
      
      sleep length / 2
      sleep 0.5 if length >= 1.0 and one_in(6)
      i = i + 1
    end
  end
  sleep 1.0
end

