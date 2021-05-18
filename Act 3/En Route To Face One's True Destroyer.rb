eval_file SSO_RB_PATH()

loadName "Chorus male"
loadName "Chorus female"
loadName 'Timpani f rh'
loadName 'Timpani p rh'

live_loop :main do
  note = (choose scale :A2, :minor)
  pl note, 1.0, "Chorus male", (rrand 0.8, 1.0)
  pl note + 24, 1.0, "Chorus female", (rrand 0.8, 1.0)
  sleep [0.5,0.5,0.5, 1.0].choose
end

live_loop :drums do
  pl (choose scale :C1, :minor), 1.0, 'Timpani f rh'
  sleep 1.0
  pl (choose scale :C1, :minor), 1.0, 'Timpani p rh'
  sleep [0.5, 1.0].choose
end