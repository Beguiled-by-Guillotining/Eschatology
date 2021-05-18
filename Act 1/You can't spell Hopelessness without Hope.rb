require PETAL_PATH()
eval_file SSO_RB_PATH()


with_fx :bitcrusher, sample_rate: 5000 do
  d2
  
  live_loop :bg do
    pl (choose scale :E2, :segah), 2.0, 'Trombones sus', 0.5
    
    d2 "circus", n: "irand 64", amp: 0.4 if one_in 10
    d2 if one_in 10
    sleep 2
  end
end

d1 "auto auto [auto auto]", n: "irand 64", stretch: :b, amp: 2.0

with_fx :reverb, room: 1, mix: 0.6 do |rev|
  
  with_fx :tanh, krunch: 5 do
    with_fx :echo, phase: 0.2, decay: 2.0 do
      live_loop :main do
        play (choose scale :E3, :segah), release: (rrand 0.1, 0.2), amp: 10.0
        control rev, mix: (rrand 0.4, 0.7) if one_in 5
        sleep [1.0, 5.0].choose
      end
    end
  end
end