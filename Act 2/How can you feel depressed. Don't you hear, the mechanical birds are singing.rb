require PETAL_PATH()
eval_file SSO_RB_PATH()

d1 "birds/2", n: "irand 10", amp: 0.6
d2 "birds3(5,8)", n: "irand 18", slow: 2

live_loop :main do
  pl (choose chord :b3, :minor7, num_octaves: 1), 10.0, 'Flute', (rrand 0.4, 0.5)
  sleep (rrand 4.0, 6.0)
end

live_loop :main2 do
  pl (choose chord :b3, :minor7, num_octaves: 2), 10.0, 'Clarinet', (rrand 0.2, 0.3)
  sleep (rrand 4.0, 6.0)
end

live_loop :main3 do
  pl (choose chord :b2, :minor7, num_octaves: 2), 10.0, 'Xylophone', (rrand 0.2, 0.4)
  sleep (rrand 2.0, 3.0)
end