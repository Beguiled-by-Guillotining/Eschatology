require PETAL_PATH()

d1 "bubble/2 bd bd ~ bd sn", amp: "10.0 0.5*4 1.0", n: "irand 64"
d2
d3
d4
d5
sleep 5.0
d2 "alphabet", n: "irand 64", fast: 2, amp: 0.5
sleep 10.0
d5 "alphabet", n: "irand 64", fast: 6, amp: 0.5
sleep 1.0
d2
sleep 10.0
d3 "hmm/4 moan/5", n: "irand 64", amp: "0.9 0.3"
sleep 10.0
d4 "numbers", amp: "1.5", n: "irand 64"
sleep 20.0
d2 "alphabet", n: "irand 64", fast: 6, amp: 0.4, stretch: :b
sleep 20.0
d5
sleep 10.0
d4
sleep 5.0
d3
sleep 5.0
d1 "bubble/2 bd bd ~ bd ~", amp: "10.0 0.5*4 1.0", n: "irand 64"
sleep 7.0
d1 "bubble/2 ~ bd ~ bd ~", amp: "10.0 0.5*4 1.0", n: "irand 64"
sleep 5.0
d2
sleep 7.0
d1 "~ ~ bd ~ bd ~", amp: "10.0 0.5*4 1.0", n: "irand 64"
sleep 7.0
d1 "~ ~ ~ ~ bd ~", amp: "10.0 0.5*4 1.0", n: "irand 64"
sleep 7.0
d1