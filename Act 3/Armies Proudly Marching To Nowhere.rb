eval_file SSO_RB_PATH()

use_bpm 80

loadName 'Trumpet'
loadName 'Trumpets stc'
loadName 'Basses sus'

live_loop :main do
  len = [0.5,0.5,0.5, 1.0].choose
  note = (choose chord :A3, :minor7)
  pl note, len - 0.05, 'Trumpet', (rrand 0.4, 0.6)
  pl note + 12, 1.0, 'Trumpets stc', (rrand 0.8, 1.0)
  if one_in(2) and len == 0.5
    at 0.25 do
      pl (choose chord :A4, :minor7), 1.0, 'Trumpets stc', (rrand 0.8, 1.0)
    end
  elsif one_in(3)  and len == 0.5
    at [0.5/3, 1.0/3] do
      pl (choose chord :A4, :minor7), 1.0, 'Trumpets stc', (rrand 0.8, 1.0)
    end
  end
  sleep len
end

live_loop :bg do
  len = [2.0,4.0,4.0,4.0].choose
  pl (choose chord :A1, :minor7), len - 0.05, 'Basses sus', (rrand 0.5, 0.8)
  pl (choose chord :A2, :minor7), len - 0.05, 'Basses sus', (rrand 0.3, 0.5)
  sleep len
end

percs = ['timpani-f-lh-a1', 'timpani-f-rh-a1', 'tambourine-hit-f', 'piatti', 'conga-opn-rr1', 'conga-mut-rr1', 'conga-slp-rr1', 'castanets-rr1']

live_loop :drums do
  2.times do
    sample SSOSamplePath()+'Percussion', percs.choose, amp: (rrand 0.5, 0.6)
  end
  sleep [0.5, 0.5, 1.0].choose
end