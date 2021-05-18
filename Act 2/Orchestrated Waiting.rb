eval_file SSO_RB_PATH()

live_loop :main do
  v = choose allVoices
  pl((rrand_i v[4], v[5]), 1.0, v[0])
  sleep 0.5
end